Summary:	Graphical interface for creating flam3 fractal images
Name:		qosmic
Version:	2.0.0
Release:	%mkrel 1
License:	GPLv2
Group:		Graphics/Editors and Converters
Url:		https://github.com/AlfredoCubitos/qosmic
Source0:	%{name}-%{version}.tar.gz
BuildRequires:	pkgconfig(Qt5Core)
BuildRequires:	pkgconfig(Qt5Gui)
BuildRequires:	pkgconfig(Qt5Widgets)
BuildRequires:	pkgconfig(Qt5UiTools)
BuildRequires:	jpeg-devel
BuildRequires:	pkgconfig(flam3)
BuildRequires:	pkgconfig(libxml-2.0)
BuildRequires:	pkgconfig(lua)
BuildRequires:	qttools5
Requires:	qttranslations5

%description
Qosmic is graphical interface for creating, editing, and rendering
flam3 fractal images. The electricsheep screen saver has been gaining
popularity, and Qosmic was developed to provide a Qt interface for
people interested in creating and contributing sheep.

%prep
%setup -q

%build
pushd %{name}
%qmake_qt5
%make
popd

%install
pushd %{name}
%make_install INSTALL_ROOT=%{buildroot}
popd

%files
%doc %{name}/README* %{name}/changes.txt %{name}/scripts
%{_bindir}/*
%{_datadir}/applications/%{name}.desktop
%{_datadir}/pixmaps/%{name}icon.xpm
%{_datadir}/%{name}/translations/*.qm
