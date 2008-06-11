Copyright: distributable
Source: rh-gfs-en-%{version}.tbz
Release: 2
Name: rh-gfs-en
Group: Documentation
URL: http://www.redhat.com/docs/
Version: 6.1
Summary: Red Hat GFS %{version}
BuildArchitectures: noarch
Buildroot: %{_tmppath}/%{name}-%{version}-buildroot
Requires: htmlview

%description 
The Red Hat GFS %{version} Administrator's Guide provides information about 
installing, configuring, and maintaining Red Hat GFS (Global File System). 
The document contains procedures for commonly performed tasks, reference 
information, and examples of complex operations and tested GFS configurations.

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
Name=Red Hat GFS Administrator Guide
Comment=Learn about GFS administration
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
* Fri Jun  4 2004  <jha@redhat.com> 6.0-3
- build final version for 6.0 release

* Wed May 26 2004  <jha@redhat.com> 6.0-2
- updated build and revved for new GFS build location

* Sat May 22 2004  <jha@redhat.com> 6.0-1
- bumped version to 6.0

* Mon May 10 2004  <jha@redhat.com> 5.2-1
- first build of GFS Admin Guide
