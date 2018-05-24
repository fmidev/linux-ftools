Summary: FS Cache and system resource utilization tools
Name: ftools
Version: 1
Release: 1
License: GPL
Group: Applications/System
URL: https://github.com/hpernu/linux-ftools
Source: %{name}.tar.gz
BuildRequires: autoconf-archive
BuildRequires: automake
BuildRequires: make
BuildRequires: gcc
BuildRequires: rpm-build

%description
These are tools designed for working with modern linux system calls including, mincore, fallocate, fadvise, etc.

They are designed primarily to work in high performance environments to determine information about the running kernel, improve system performance, and debug performance problems.

%prep
rm -rf $RPM_BUILD_ROOT
%setup -q
 
%build
aclocal
automake
autoconf
./configure
make %{_smp_mflags}

%install
%makeinstall

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(0775,root,root,0775)
%{_sbindir}/*

%changelog
* Thu May 24 2018 Heikki Pernu
- Created spec file
