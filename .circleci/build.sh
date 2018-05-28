#!/bin/bash

# Go to git repo root
cd `dirname $0`
cd ..


jobs=`fgrep processor /proc/cpuinfo | wc -l`

set -ex
for step in $* ; do
    case $step in
	deps)
	    yum-builddep -y *.spec
	    ;;
	rpm)
	    #git -X
	    rpmlint *.spec
	    ./configure
	    ./rpm-build.sh
	    mkdir -p $HOME/dist
	    for d in /root/rpmbuild $HOME/rpmbuild ; do
	    	test ! -d "$d" || find "$d" -name \*.rpm -exec mv -v {} $HOME/dist/ \; 
	    done
	    set +x
	    echo "Distribution files are in $HOME/dist:"
	    ls -l $HOME/dist
	    ;;
	*)
	    echo "Unknown build step $step"
	    ;;
    esac
done
