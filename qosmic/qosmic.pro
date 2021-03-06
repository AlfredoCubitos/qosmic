################################################################################
#################### qmake project file for qosmic application #################
################################################################################
## Installation prefix on *nix/osx.  Binaries are installed in $$PREFIX/bin
PREFIX = /usr


################################################################################
## The shared resources directory
SHARED = $$PREFIX/share


################################################################################
## The translations files are installed in $$SHARED/qosmic/translations
TRANSDIR = $$SHARED/qosmic/translations


################################################################################
## Icons are installed in $$SHARED/icons/hicolor/*/apps
ICONS16DIR = $$SHARED/icons/hicolor/16x16/apps
ICONS32DIR = $$SHARED/icons/hicolor/32x32/apps
ICONS48DIR = $$SHARED/icons/hicolor/48x48/apps


################################################################################
## Qosmic Lua scripts are installed in $$SHARED/scripts
SCRIPTSDIR = $$SHARED/scripts


################################################################################
## Install the qosmic.desktop file here.
DESKDIR = $$SHARED/applications


################################################################################
## Uncomment to install the qosmic.desktop file and the application icons.
CONFIG += install_icons install_desktop


################################################################################
## Add your non-english locale here to install the translations.
CONFIG += install_locale


################################################################################
## Add linked libs and paths for headers and palettes here using pkg-config.
## If your system doesn't support pkg-config then comment out the next line and
## set these values below.
CONFIG += link_pkgconfig

link_pkgconfig {
	message("Config using pkg-config version "$$system(pkg-config --version))
	PKGCONFIG = flam3 lua

	## The directory that contains flam3-palettes.xml must be set here.  If
	## your system has pkg-config, this should find the flam3 palettes.
	PALETTESDIR = $$system(pkg-config --variable=datarootdir flam3)/flam3
}
else {
	message("Config not using pkg-config")
	## Adjust these variables to set paths and libs without using pkg-config.
	## The PALETTESDIR must be set to the directory containing the
	## flam3-palettes.xml file installed by the flam3 package.
        PALETTESDIR = /usr/share/flam3
	INCLUDEPATH += /usr/include/libxml2
	LIBS += -L/usr/lib/libxml2 -lflam3 -lm -ljpeg -lxml2 -llua
}

################################################################################
## Build style flags.  Adding debug enables more verbose logging.
#CONFIG += release warn_off
CONFIG += debug warn_on


################################################################################
## Set cflags here if needed.
#CONFIG(release, debug|release) {
#	QMAKE_CFLAGS="-march=native -O2 -pipe -Wl,-t"
#	QMAKE_CXXFLAGS=$$QMAKE_CFLAGS
#}


################################################################################
## qosmic app version
VERSION = 2.0.0

################################################################################
## Check for correct package versions
# system( test $$QT_MINOR_VERSION -lt 6 ) {
#	error("Using Qt $$[QT_VERSION]. " \
#	"Qosmic $$VERSION requires at least version 4.6 of Qt to build.")
#}


link_pkgconfig {
	! system(pkg-config --atleast-version 3.0.1 flam3) {
		error("Qosmic $$VERSION requires at least version 3.0.1 of flam3 to build.")
	}
}

! exists($$PALETTESDIR/flam3-palettes.xml) {
	error("The file $$PALETTESDIR/flam3-palettes.xml doesn't exist. " \
	"Please install libflam3 (http://flam3.org/) and set PALETTESDIR" \
	"to the directory containing flam3-palettes.xml in qosmic.pro.")
}

################################################################################
DEFINES += VERSION='\'"$$VERSION"\''
DEFINES += FLAM3DIR='\'"$$PALETTESDIR"\''
DEFINES += TRANSDIR='\'"$$TRANSDIR"\''
DEFINES += SCRIPTSDIR='\'"$$SCRIPTSDIR"\''
# CONFIG += qt thread uitools
QT += uitools widgets gui
RESOURCES = qosmic.qrc
INCLUDEPATH += src
      ##using local installed flam3
#INCLUDEPATH += ../flam3/trunk/src
#INCLUDEPATH += ../flam3/
DESTDIR = .

## add the target to the install set
target.path += $$PREFIX/bin
INSTALLS += target

## add the translations to the install set
install_locale {
	locale.files= ts/*.qm
	locale.path = $$TRANSDIR
	INSTALLS += locale
}

## add icons to the install set
install_icons {
	icons16.files = icons/hicolor/16x16/apps/qosmic.png
	icons16.path = $$ICONS16DIR
	icons32.files = icons/hicolor/32x32/apps/qosmic.png
	icons32.path = $$ICONS32DIR
	icons48.files = icons/hicolor/48x48/apps/qosmic.png
	icons48.path = $$ICONS48DIR
	INSTALLS += icons16 icons32 icons48
}

## add the qosmic.desktop file to the install set
install_desktop {
   desktop.files = qosmic.desktop
   desktop.path  = $$DESKDIR
   INSTALLS += desktop
}

message(Generating Makefile for Qosmic version $$VERSION)
message(Qt version : $$[QT_VERSION])
message(Location of flam3-palettes.xml : $$PALETTESDIR)
! link_pkgconfig {
	message(Include header paths : $$INCLUDEPATH)
	message(Include libraries : $$LIBS)
}

CONFIG(debug, debug|release) {
	## enable more verbose logging
	message(Building debug version)
	DEFINES += LOGGING
}

FORMS += \
 ui/mainwindow.ui \
 ui/mainviewer.ui \
 ui/paletteeditor.ui \
 ui/camerasettingswidget.ui \
 ui/colorsettingswidget.ui \
 ui/imgsettingswidget.ui \
 ui/mainpreviewwidget.ui \
 ui/trianglecoordswidget.ui \
 ui/triangledensitywidget.ui \
 ui/variationswidget.ui \
 ui/mutationwidget.ui \
 ui/colorbalancewidget.ui \
 ui/directoryviewwidget.ui \
 ui/statuswidget.ui \
 ui/scripteditwidget.ui \
 ui/colordialog.ui \
 ui/selectgenomewidget.ui \
 ui/genomevectorlistmodelitemeditor.ui \
 ui/selectgenomeconfigdialog.ui \
 ui/mutationconfigdialog.ui \
 ui/viewerpresetswidget.ui \
 ui/selecttrianglewidget.ui \
 ui/renderdialog.ui \
 ui/renderprogressdialog.ui \
 ui/adjustscenewidget.ui \
 ui/editmodeselectorwidget.ui \
 ui/chaoswidget.ui \
 ui/sheeploopwidget.ui \
 ui/scripteditconfigdialog.ui

HEADERS += \
 src/qosmic.h \
 src/flam3util.h \
 src/mainwindow.h \
 src/xfedit.h \
 src/basistriangle.h \
 src/triangle.h \
 src/nodeitem.h \
 src/mainviewer.h \
 src/renderthread.h \
 src/colorselector.h \
 src/genomecolorselector.h \
 src/paletteeditor.h \
 src/mutationwidget.h \
 src/colorlabel.h \
 src/doublevalueeditor.h \
 src/intvalueeditor.h \
 src/camerasettingswidget.h \
 src/colorsettingswidget.h \
 src/imgsettingswidget.h \
 src/mainpreviewwidget.h \
 src/trianglecoordswidget.h \
 src/variationswidget.h \
 src/logger.h \
 src/colorbalancewidget.h \
 src/gradientlistmodel.h \
 src/varstablewidget.h \
 src/directoryviewwidget.h \
 src/flamfileiconprovider.h \
 src/directorylistview.h \
 src/snapslider.h \
 src/statuswidget.h \
 src/scripteditwidget.h \
 src/wheelvalueeditor.h \
 src/genomevector.h \
 src/lua/lunar.h \
 src/lua/frame.h \
 src/lua/xform.h \
 src/lua/genome.h \
 src/lua/luathread.h \
 src/colordialog.h \
 src/selectgenomewidget.h \
 src/viewerpresetsmodel.h \
 src/viewerpresetswidget.h \
 src/coordinatemark.h \
 src/lua/luathreadadapter.h \
 src/lua/highlighter.h \
 src/lua/luaeditor.h \
 src/lua/luatype.h \
 src/selecttrianglewidget.h \
 src/triangledensitywidget.h \
 src/undoring.h \
 src/triangleselection.h \
 src/posttriangle.h \
 src/qosmicwidget.h \
 src/renderdialog.h \
 src/renderprogressdialog.h \
 src/adjustscenewidget.h \
 src/gradientstopseditor.h \
 src/editmodeselectorwidget.h \
 src/genomevectorlistview.h \
 src/chaoswidget.h \
 src/transformablegraphicsitem.h \
 src/transformablegraphicsguide.h \
 src/sheeploopwidget.h \
 src/flam3filestream.h \
 src/checkersbrush.h

SOURCES += \
 src/qosmic.cpp \
 src/mainwindow.cpp \
 src/xfedit.cpp \
 src/basistriangle.cpp \
 src/triangle.cpp \
 src/nodeitem.cpp \
 src/flam3util.cpp \
 src/mainviewer.cpp \
 src/renderthread.cpp \
 src/colorselector.cpp \
 src/genomecolorselector.cpp \
 src/paletteeditor.cpp \
 src/logger.cpp \
 src/mutationwidget.cpp \
 src/colorlabel.cpp \
 src/doublevalueeditor.cpp \
 src/intvalueeditor.cpp \
 src/camerasettingswidget.cpp \
 src/colorsettingswidget.cpp \
 src/imgsettingswidget.cpp \
 src/mainpreviewwidget.cpp \
 src/trianglecoordswidget.cpp \
 src/variationswidget.cpp \
 src/colorbalancewidget.cpp \
 src/gradientlistmodel.cpp \
 src/varstablewidget.cpp \
 src/directoryviewwidget.cpp \
 src/flamfileiconprovider.cpp \
 src/directorylistview.cpp \
 src/snapslider.cpp \
 src/statuswidget.cpp \
 src/scripteditwidget.cpp \
 src/wheelvalueeditor.cpp \
 src/lua/frame.cpp \
 src/lua/genome.cpp \
 src/lua/xform.cpp \
 src/lua/luathread.cpp \
 src/colordialog.cpp \
 src/selectgenomewidget.cpp \
 src/genomevector.cpp \
 src/viewerpresetsmodel.cpp \
 src/viewerpresetswidget.cpp \
 src/coordinatemark.cpp \
 src/lua/luathreadadapter.cpp \
 src/lua/highlighter.cpp \
 src/lua/luaeditor.cpp \
 src/lua/luatype.cpp \
 src/selecttrianglewidget.cpp \
 src/triangledensitywidget.cpp \
 src/undoring.cpp \
 src/triangleselection.cpp \
 src/posttriangle.cpp \
 src/qosmicwidget.cpp \
 src/renderdialog.cpp \
 src/renderprogressdialog.cpp \
 src/adjustscenewidget.cpp \
 src/gradientstopseditor.cpp \
 src/editmodeselectorwidget.cpp \
 src/genomevectorlistview.cpp \
 src/chaoswidget.cpp \
 src/transformablegraphicsitem.cpp \
 src/transformablegraphicsguide.cpp \
 src/sheeploopwidget.cpp \
 src/flam3filestream.cpp \
 src/checkersbrush.cpp


TRANSLATIONS += ts/qosmic_fr.ts \
                ts/qosmic_cs.ts \
                ts/qosmic_ru.ts \
                ts/qosmic_de.ts

MOC_DIR = .moc
OBJECTS_DIR = .obj
RCC_DIR = .res
UI_DIR = .ui

isEmpty(QMAKE_LRELEASE):QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease
system($${QMAKE_LRELEASE} -silent $${_PRO_FILE_} 2> /dev/null)

updateqm.input = TRANSLATIONS
updateqm.output = ts/${QMAKE_FILE_BASE}.qm
updateqm.commands = $$QMAKE_LRELEASE \
    ${QMAKE_FILE_IN} \
    -qm \
    ${QMAKE_FILE_OUT}
updateqm.CONFIG += no_link
QMAKE_EXTRA_COMPILERS += updateqm
TS_OUT = $$TRANSLATIONS
TS_OUT ~= s/.ts/.qm/g
PRE_TARGETDEPS += $$TS_OUT
