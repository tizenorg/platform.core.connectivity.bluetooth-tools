Name:       bluetooth-tools
Summary:    Bluetooth-tools
Version:    0.2.35
Release:    3
Group:      Network & Connectivity/Bluetooth
License:    Apache-2.0
Source0:    %{name}-%{version}.tar.gz
Source1001:	bluetooth-address.service
BuildRequires:  cmake
Requires:       bluetooth-tools-no-firmware
Suggests:       bluetooth-share

%description
Tools fo bluetooth run/stop and set address

%package no-firmware
Summary:    On/Off Bluetooth adapter
Group:      Network & Connectivity/Bluetooth
Requires:   %{name} = %{version}-%{release}
Requires: rfkill
Conflicts:  bluetooth-firmware-bcm

%description no-firmware
On/Off bluetooth device

%prep
%setup -q

%build
export CFLAGS+=" -fpie -fvisibility=hidden"
export LDFLAGS+=" -Wl,--rpath=/usr/lib -Wl,--as-needed -Wl,--unresolved-symbols=ignore-in-shared-libs -pie"

cmake . -DCMAKE_INSTALL_PREFIX=%{_prefix}
make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%make_install

mkdir -p %{buildroot}%{_sysconfdir}/rc.d/rc3.d
mkdir -p %{buildroot}%{_sysconfdir}/rc.d/rc5.d
ln -s %{_sysconfdir}/rc.d/init.d/bluetooth-address %{buildroot}%{_sysconfdir}/rc.d/rc3.d/S60bluetooth-address
ln -s %{_sysconfdir}/rc.d/init.d/bluetooth-address %{buildroot}%{_sysconfdir}/rc.d/rc5.d/S60bluetooth-address

mkdir -p %{buildroot}%{_unitdir}/multi-user.target.wants
install -m 0644 %{SOURCE1001} %{buildroot}%{_unitdir}
ln -s ../bluetooth-address.service %{buildroot}%{_unitdir}/multi-user.target.wants/bluetooth-address.service

mkdir -p %{buildroot}%{_prefix}/etc/bluetooth/
install -m 0755 scripts/bt-dev-start.sh %{buildroot}%{_prefix}/etc/bluetooth/bt-dev-start.sh
install -m 0755 scripts/bt-dev-end.sh %{buildroot}%{_prefix}/etc/bluetooth/bt-dev-end.sh

%files
%manifest %{name}.manifest
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

%{_unitdir}/multi-user.target.wants/bluetooth-address.service
%{_unitdir}/bluetooth-address.service

%files no-firmware
%manifest %{name}.manifest
%defattr(-, root, root)
%attr(755,-,-) %{_prefix}/etc/bluetooth/bt-dev-end.sh
%attr(755,-,-) %{_prefix}/etc/bluetooth/bt-dev-start.sh
