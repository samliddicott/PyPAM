%define name PyPAM
%define version 0.5.0
%define release 1

Summary: PAM (Pluggable Authentication Module) bindings for Python
Name: %{name}
Version: %{version}
Release: %{release}
Source0: %{name}-%{version}.tar.gz
License: LGPL
Group: Development/Libraries
BuildRoot: %{_tmppath}/%{name}-buildroot
Prefix: %{_prefix}
Vendor: Rob Riggs <rob+pypam@pangalactic.org>
Requires: python pam
Url: http://www.pangalactic.org/PyPAM
BuildRequires: pam-devel

%description
UNKNOWN

%prep
%setup

%build
env CFLAGS="$RPM_OPT_FLAGS" python setup.py build

%install
python setup.py install --root=$RPM_BUILD_ROOT --record=INSTALLED_FILES

%clean
rm -rf $RPM_BUILD_ROOT

%files -f INSTALLED_FILES
%defattr(-,root,root)
%doc AUTHORS ChangeLog COPYING INSTALL README NEWS examples/ tests/
