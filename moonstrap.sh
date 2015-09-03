#!/bin/sh
pmlogo() {
cat <<"EOT"

   __  ___                  __              
  /  |/  /__  ___  ___  ___/ /________ ____ 
 / /|_/ / _ \/ _ \/ _ \(_-< __/ __/ _ `/ _ \
/_/  /_/\___/\___/_//_/___|__/_/  \_,_/ .__/
                                     /_/     

Moonstrap Version 0.6
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
     echo "I don't like you, and I don't like your joke of an OS. But I've got support for most distros"
     echo "Now detecting your Distribution"
#       if ls /usr/bin | grep -q apt-get; then
#        	echo "You're using a Debian Derivative! Let's find out which"
#        	if cat /etc/*-release | grep -q Ubuntu; then
#         	echo "Ubuntu! Aren't you special? I bet you think you're so great, having just switched from Windows! Installing deps, yo..."
#         	apt-get update
#         	apt-get upgrade
#         	apt-get install #deps list
#         else
#         	if cat /etc/*-release | grep -q Debian; then
#         		echo "Debian! Woohoo! Installing deps, yo!"
#         		apt-get update
#         		apt-get upgrade
#         		apt-get install # deps go here
#       else
       		if ls /usr/bin | grep -q yum; then
         	echo "You're using a Yum distro! CentOS 6 is the only supported one, let's check that distro!"
         		if cat /etc/*-release | grep -q "CentOS release 6"; then
         			echo "CentOS 6! Hooray! Lemme grab those deps for you bruh"
         			wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
					rpm -ivh epel-release-6-8.noarch.rpm
         			yum update -y
         			yum install -y autoconf213 yasm mesa-libGL-devel alsa-lib-devel libXt-devel gstreamer-devel gstreamer-plugins-base-devel pulseaudio-libs-devel
					yum groupinstall -y 'Development Tools' 'GNOME Software Development'
					yum install -y zlib-devel openssl-devel sqlite-devel bzip2-devel # dependencies
					wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
					tar -xf Python-2.7.6.tar.xz
					cd Python-2.7.6
					./configure --prefix=/usr/local
					make
					make altinstall # don't use make install, as that will replace the system python!
					wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
					python2.7 ez_setup.py
					easy_install-2.7 pip
					pip2.7 install virtualenv 
         			cd /etc/yum.repos.d
					wget http://people.centos.org/tru/devtools-1.1/devtools-1.1.repo
					yum update -y
					yum install -y devtoolset-1.1-{gcc,gcc-c++,binutils,elfutils}
					cd

         	else 
         		echo "Dunno what you're using, sorry bruh. I don't care enough to support Gentoo, Arch, Slack, or OTHER"
         		echo "But if you're using one of them you're intelligent enough to install the dependancies and continue manually"
         	fi
       fi
       wget https://raw.githubusercontent.com/RainbowHackz/Moonstrap/Moonstrap-0.6/linbuild.sh
       wget https://raw.githubusercontent.com/RainbowHackz/Moonstrap/Moonstrap-0.6/linmozconfig.txt
       mv linbuild.sh build.sh
       mv linmozconfig.txt mozconfig.txt
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
   cd /root
   fetch --no-verify-peer https://raw.githubusercontent.com/RainbowHackz/Moonstrap/Moonstrap-0.5/bsdmozconfig.txt
   mv bsdmozconfig.txt mozconfig.txt
   fetch --no-verify-peer https://raw.githubusercontent.com/RainbowHackz/Moonstrap/Moonstrap-0.5/build.sh
   ;;
esac
chmod +x build.sh
mkdir ~/pmbuild
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
