#!/bin/sh
pmlogo() {
cat <<"EOT"

   __  ___                  __              
  /  |/  /__  ___  ___  ___/ /________ ____ 
 / /|_/ / _ \/ _ \/ _ \(_-< __/ __/ _ `/ _ \
/_/  /_/\___/\___/_//_/___|__/_/  \_,_/ .__/
                                     /_/     

Moonstrap Version 0.4
Pale Moon Version 25.7       
                                         
EOT
}

pmlogo

echo "This script written by Rainbow."
echo "Follow me on Twitter (or don't. I don't really care.) @RainbowHacks"
echo "The original script can always be found at http://cloudsdale.ponix.space/~rainbow/scripts/palemoonfbsd/moonstrap.sh"                                         

echo "Bootstrapping build environment"
echo "Using build dependancy list from http://www.freshports.org/www/firefox/"
echo "Calling pkgng:"

pkg install devel/nspr security/nss devel/libevent2 audio/soundtouch print/harfbuzz \
graphics/graphite2 audio/libvorbis multimedia/libvpx databases/sqlite3 databases/py-sqlite3 \
multimedia/v4l_compat devel/autoconf213 archivers/zip archivers/unzip devel/libnotify \
devel/gmake devel/pkgconf lang/python27 devel/desktop-file-utils graphics/cairo graphics/libGL \
x11/glproto x11/dri2proto x11/libXext x11/libXrender x11-toolkits/libXt multimedia/gstreamer1-plugins-good \
multimedia/gstreamer1-libav lang/perl5.20 lang/gcc49 archivers/p7zip shells/bash devel/py-virtualenv devel/git \
gtk2 devel/glib20 devel/py-gobject devel/dbus devel/dbus-glib devel/yasm

echo "Modifying /etc/make.conf as Pale Moon will not build correctly with Clang"
echo "CC=gcc49" > /etc/make.conf
echo "CPP=cpp49" >> /etc/make.conf
echo "CXX=g++49" >> /etc/make.conf
echo "USE_GCC=gcc49" >> /etc/make.conf

echo "Setting up build environment in /root"

mkdir /usr/home
ln -s /usr/home /home
ln -s /root /usr/home/root
mkdir /usr/home/root/pmbuild
cd /root
fetch http://cloudsdale.ponix.space/~rainbow/scripts/palemoonfbsd/mozconfig.txt
fetch http://cloudsdale.ponix.space/~rainbow/scripts/palemoonfbsd/build.sh
chmod +x build.sh
echo "Grabbing source from Git Branch..."
git clone https://github.com/MoonchildProductions/Pale-Moon.git pmsrc
cd pmsrc
autoconf
cd ..
chmod -R +x pmsrc/
./pmsrc/configure
echo "Building! Cross your fingers!"
bash ./build.sh
