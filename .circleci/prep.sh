#!/bin/bash

# Go to git repo root
cd `dirname $0`
cd ..

user=`whoami`
if [ "$user" != "root" ] ; then
	echo "This script must be run as root(use sudo)"
	exit 2
fi

set -ex
for step in $* ; do
    case $step in
    fmi)
    	# Install FMI package repositories
		yum install -y http://www.nic.funet.fi/pub/mirrors/fedora.redhat.com/pub/epel/epel-release-latest-7.noarch.rpm \
			https://download.fmi.fi/smartmet-open/rhel/7/x86_64/smartmet-open-release-17.9.28-1.el7.fmi.noarch.rpm \
			https://download.fmi.fi/fmiforge/rhel/7/x86_64/fmiforge-release-17.9.28-1.el7.fmi.noarch.rpm \
			https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-redhat95-9.5-3.noarch.rpm
    	;;
	ccache)
		# Ccache is really only useful if you use the same container for same build multiple times
		yum install -y ccache
		;;
	prep)
		# This will speedup future steps and there seems to be wrong URLs in some of these
	    rm -f /etc/yum.repos.d/CentOS-Vault.repo /etc/yum.repos.d/CentOS-Sources.repo
	    # Update on filesystem package fails on CircleCI containers and on some else as well
	    # Enable workaround
	    sed -i -e '$a%_netsharedpath /sys:/proc' /etc/rpm/macros.dist 
	    yum install -y yum-utils
	    if [ "$SCIRLECI_JOB" = "build" ] ; then yum install -y rpmlint git ; fi
	    ;;
	*)
	    echo "Unknown build step $step"
	    ;;
    esac
done

yum update -y
yum clean all
rm -rf /var/cache/yum
# This takes some time and doubt that it is actually beneficial
# yum makecache