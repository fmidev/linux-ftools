Summary: FS Cache and system resource utilization tools
Name: linux-ftools
Version: 1.0.0
Release: 1
License: GPL
Group: Applications/System
URL: https://github.com/hpernu/linux-ftools
Source: %{name}-%{version}.tar.gz
BuildRequires: autoconf-archive
BuildRequires: automake
BuildRequires: make
BuildRequires: gcc
BuildRequires: rpm-build

%description
These are tools designed for working with modern linux system calls including, mincore, fallocate, fadvise, etc.

They are designed primarily to work in high performance environments to determine information about the running kernel, improve system performance, and debug performance problems.

%prep
%setup
 
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
%{_bindir}/*

%changelog
* Mon May 28 2018 Heikki Pernu
- Fix and make source build more de-facto standard conforming

* Thu May 24 2018 Heikki Pernu
- Created spec file

