#!/bin/sh
pmlogo() {
cat <<"EOT"

   __  ___                  __              
  /  |/  /__  ___  ___  ___/ /________ ____ 
 / /|_/ / _ \/ _ \/ _ \(_-< __/ __/ _ `/ _ \
/_/  /_/\___/\___/_//_/___|__/_/  \_,_/ .__/
                                     /_/     

Moonstrap Version 0.5
Pale Moon Version 25.7    

You should have received a License file, if you cloned from Github.
If not, please see https://github.com/RainbowHackz/Moonstrap/blob/master/LICENSE
This script is released under a Simplified 2-Clause BSD license. Support 
truely Free software, and use a BSD license for your projects. 
GPL restrictions just make it Open, not Free.
                                         
EOT
}

pmlogo

echo "This script written by Rainbow."
echo "Follow me on Twitter (or don't. I don't really care.) @RainbowHacks"
echo "The original script can always be found at "
echo "http://cloudsdale.ponix.space/~rainbow/scripts/palemoonfbsd/moonstrap.sh"                                         

echo "Now making sure Moonstrap is compatible with your OS..."
case "$(uname -s)" in
   Darwin)
     echo "OS X IS NOT FREEBSD. STAHP."
     ;;
   Linux)
     echo "I don't like you, and I don't like your joke of an OS. But Moonstrap 0.6 should have Linux support"
     ;;

   FreeBSD)
   echo "Bootstrapping build environment"
   echo "Using build dependancy list from http://www.freshports.org/www/firefox/"
   echo "Calling pkgng: "

   pkg install devel/nspr security/nss devel/libevent2 audio/soundtouch print/harfbuzz \
   graphics/graphite2 audio/libvorbis multimedia/libvpx databases/sqlite3 databases/py-sqlite3 \
   multimedia/v4l_compat devel/autoconf213 archivers/zip archivers/unzip devel/libnotify \
   devel/gmake devel/pkgconf lang/python27 devel/desktop-file-utils graphics/cairo graphics/libGL \
   x11/glproto x11/dri2proto x11/libXext x11/libXrender x11-toolkits/libXt multimedia/gstreamer1-plugins-good \
   multimedia/gstreamer1-libav lang/perl5.20 lang/gcc49 shells/bash devel/py-virtualenv devel/git \
   devel/py-gobject devel/dbus devel/yasm

   echo "Installing Library Dependancies"

   pkg install multimedia/libv4l graphics/cairo devel/libevent2 devel/libffi graphics/graphite2 \
   print/harfbuzz textproc/hunspell devel/icu devel/nspr security/nss graphics/png x11/pixman \
   audio/soundtouch databases/sqlite3 multimedia/libvpx audio/libvorbis devel/dbus-glib \
   x11/startup-notification audio/alsa-lib converters/libiconv graphics/jpeg accessibility/atk \
   devel/glib20 x11-toolkits/gtk20 x11-toolkits/pango

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
   fetch --no-verify-peer https://raw.githubusercontent.com/RainbowHackz/Moonstrap/Moonstrap-0.5/mozconfig.txt
   fetch --no-verify-peer https://raw.githubusercontent.com/RainbowHackz/Moonstrap/Moonstrap-0.5/build.sh
   chmod +x build.sh
   echo "Grabbing source from Git Branch..."
   git clone https://github.com/MoonchildProductions/Pale-Moon.git pmsrc
   #cd pmsrc
   #autoconf
   #cd ..
   chmod -R +x pmsrc/
   #./pmsrc/configure
   echo "Building! Cross your fingers!"
   #bash ./autobuild.sh
   bash ./build.sh
   ;;
esac
