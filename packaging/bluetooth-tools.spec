Name:       bluetooth-tools
Summary:    bluetooth-tools
Version:    0.2.35
Release:    2
Group:      TO_BE/FILLED_IN
License:    Apache License, Version 2.0
Source0:    %{name}-%{version}.tar.gz
Source1001:	bluetooth-address.service
BuildRequires:  cmake

%description
Tools fo bluetooth run/stop and set address


%prep
%setup -q

%build
cmake . -DCMAKE_INSTALL_PREFIX=%{_prefix}
make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%make_install

mkdir -p %{buildroot}%{_sysconfdir}/rc.d/rc3.d
mkdir -p %{buildroot}%{_sysconfdir}/rc.d/rc5.d
ln -s %{_sysconfdir}/rc.d/init.d/bluetooth-address %{buildroot}%{_sysconfdir}/rc.d/rc3.d/S60bluetooth-address
ln -s %{_sysconfdir}/rc.d/init.d/bluetooth-address %{buildroot}%{_sysconfdir}/rc.d/rc5.d/S60bluetooth-address

mkdir -p %{buildroot}%{_libdir}/systemd/system/multi-user.target.wants
install -m 0644 %{SOURCE1001} %{buildroot}%{_libdir}/systemd/system/
ln -s ../bluetooth-address.service %{buildroot}%{_libdir}/systemd/system/multi-user.target.wants/bluetooth-address.service


%files
%manifest bluetooth-tools.manifest
%defattr(-,root,root,-)
%{_sysconfdir}/rc.d/init.d/bluetooth-address
%{_sysconfdir}/rc.d/rc3.d/S60bluetooth-address
%{_sysconfdir}/rc.d/rc5.d/S60bluetooth-address
%attr(0755,-,-) %{_prefix}/etc/bluetooth/bt-stack-up.sh
%attr(0755,-,-) %{_prefix}/etc/bluetooth/bt-stack-down.sh
%attr(0755,-,-) %{_prefix}/etc/bluetooth/bt-reset-env.sh
%attr(0755,-,-) %{_prefix}/etc/bluetooth/bt-edutm-on.sh
%attr(0755,-,-) %{_prefix}/etc/bluetooth/bt-edutm-dev-up.sh
%attr(0755,-,-) %{_prefix}/etc/bluetooth/bt-edutm-mode-on.sh
%attr(0755,-,-) %{_prefix}/etc/bluetooth/bt-edutm-off.sh
%{_libdir}/systemd/system/multi-user.target.wants/bluetooth-address.service
%{_libdir}/systemd/system/bluetooth-address.service

