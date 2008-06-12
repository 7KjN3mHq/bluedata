Copyright: distributable
Source: rh-cs-en-%{version}.tbz
Release: 1
Name: rh-cs-en
Group: Documentation
URL: http://www.redhat.com/docs/
Version: 4
Summary: Red Hat Cluster Suite Configuring and Managing a Cluster
BuildArchitectures: noarch
Buildroot: %{_tmppath}/%{name}-%{version}-buildroot

%description
This guide discusses how to install, configure, and manage
a high-availability clustered system.

%prep
%define _builddir %(mkdir -p %{buildroot}%{_defaultdocdir} ; echo %{buildroot}%{_defaultdocdir})
%setup -q -c
for i in *
do
if [ -d $i ]; then
   cd $i
   mv -f * ../
   cd ..
   rmdir $i
fi
done

%build
 
%install

mkdir -p $RPM_BUILD_ROOT/usr/share/applications/
                                                                                                                  
cat > $RPM_BUILD_ROOT/usr/share/applications/%{name}.desktop <<'EOF'
[Desktop Entry]
Name=Configuring and Managing a Cluster
Comment=Read about Red Hat Cluster Suite
Exec=htmlview file:%{_defaultdocdir}/%{name}-%{version}/index.html
Icon=/%{_defaultdocdir}/%{name}-%{version}/docs.png
Categories=Documentation;X-Red-Hat-Base;
Type=Application
Encoding=UTF-8
Terminal=false
EOF

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%{_datadir}/applications/%{name}.desktop
/%{_defaultdocdir}/%{name}-%{version}

%changelog
* Fri Jun  4 2004  <jha@redhat.com> 3-2
- build for final mid-year release

* Fri Sep 19 2003 Tammy Fox <tfox@redhat.com>
- build with finished docs

* Fri Sep 05 2003 Tammy Fox <tfox@redhat.com>
- build another beta version for review

* Fri Jul 25 2003 Tammy Fox <tfox@redhat.com>
- build for beta

* Mon Mar 25 2002 Tammy Fox <tfox@redhat.com>
- Build version 1.0

* Fri Jan 18 2002 Tammy Fox <tfox@redhat.com>
- Created spec file
