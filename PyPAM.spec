%define py_prefix	/usr
%define py_ver		1.5
%define PyPAM_ver	0.4.2
%define PyPAM_rel	1

Summary: PAM bindings for Python
Name: PyPAM
Version: %{PyPAM_ver}
Release: %{PyPAM_rel}
Source: PyPAM-%{PyPAM_ver}.tar.gz
Copyright: LGPL
Group: Development/Languages
BuildRoot:/var/tmp/PyPAM-root
Packager: Rob Riggs <rob@pangalactic.org>
Vendor: tummy.com, Ltd.
Requires: python, pam

%description
PAM (Pluggable Authentication Module) bindings for Python.

%prep

%setup
CFLAGS="$RPM_OPT_FLAGS" ./configure

%build
make

%install
rm -rf $RPM_BUILD_ROOT
make DESTDIR=$RPM_BUILD_ROOT install

%files
%{py_prefix}/lib/python%{py_ver}/site-packages/PAMmodule.so
%doc AUTHORS NEWS README ChangeLog
%doc examples
