#!/bin/sh

pmlogo() {
cat <<"EOT"

   __  ___                  __              
  /  |/  /__  ___  ___  ___/ /________ ____ 
 / /|_/ / _ \/ _ \/ _ \(_-< __/ __/ _  / _ \
/_/  /_/\___/\___/_//_/___|__/_/  \_,_/ .__/
                                     /_/     

Moonstrap Version 0.9
Pale Moon Version 26.2.0 Release

You should have received a License file, if you cloned from Github.
If not, please see https://github.com/RainbowHackerHorse/Moonstrap/blob/master/LICENSE
This script is released under a Simplified 2-Clause BSD license. Support 
truly Free software, and use a BSD license for your projects. 
GPL restrictions just make it Open, not Free.

EOT
}

pmlogo

echo "This script written by Rainbow."
echo "Follow me on Twitter (or don't. I don't really care.) @Hacker_Horse"

echo "Now making sure Moonstrap is compatible with your OS..."
case "$(uname -s)" in
	Darwin)
		echo "OS X IS NOT FREEBSD. STAHP."
		exit 1
	;;
	Linux)
		echo "Now detecting your Distribution"
		if ls /usr/bin | grep -q apt-get; then
			echo "You're using a Debian Derivative! I don't support you yet, sorry"
			exit 1
		elif cat /etc/*-release | grep -q "CentOS release 6"; then
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
			yum install -y glib gtk+ gtk+-devel gtk2-devel dbus dbus-x11 dbus-glib dbus-glib-devel
			yum install -y 
			cd
			ln -s /root /home/root
		elif cat /etc/*-release | grep -q "Arch"; then
			echo "Arch baby, yeah! I would have stayed on Linux for you, but you chose SystemD instead ;~;"
			pacman -Syu
			pacman -S --needed base-devel
			echo "Grabbin them deps, baby. Might wanna check out https://aur.archlinux.org/packages/palemoon/ too"
			pacman -Sy alsa-lib dbus-glib desktop-file-utils gtk2 libxt mime-types nss autoconf2.13 git \
			gstreamer0.10 gstreamer0.10-base-plugins python2 unzip yasm zip \
			gstreamer0.10-bad-plugins gstreamer0.10-good-plugins \
			gstreamer0.10-ugly-plugins hunspell hyphen libpulse
			echo "now I need to alias python 2.7 to python for this to build. Cool? (y/n)"
			read -n 1 ch
			if [ "$ch" == "n" ] ; then
				echo "OKIEDOKIELOKIE BRO"
				exit 1
			else
  				echo "Cool, aliasing and moving on!"
  				ln -s /usr/bin/python2.7 /usr/bin/python
			fi
		else 
			echo "Dunno what you're using, sorry bruh."
			echo "Hopefully you're intelligent enough to install the dependancies and continue manually"
			exit 1
		fi
		wget https://raw.githubusercontent.com/RainbowHackerHorse/Moonstrap/master/linbuild.sh
		wget https://raw.githubusercontent.com/RainbowHackerHorse/Moonstrap/master/linmozconfig.txt
		mv linbuild.sh build.sh
		mv linmozconfig.txt mozconfig.txt
	;;
	FreeBSD)
		echo "FreeBSD! Doin' it right, bruh! Go UNIX!"
		echo "Bootstrapping build environment..."
		echo "Using build dependancy list from http://www.freshports.org/www/firefox/"
		echo "Calling pkgng: "

		pkg install -y devel/nspr security/nss devel/libevent2 audio/soundtouch print/harfbuzz \
		graphics/graphite2 audio/libvorbis multimedia/libvpx databases/sqlite3 databases/py-sqlite3 \
		multimedia/v4l_compat devel/autoconf213 archivers/zip archivers/unzip devel/libnotify \
		devel/gmake devel/pkgconf lang/python27 devel/desktop-file-utils graphics/cairo graphics/libGL \
		x11/glproto x11/dri2proto x11/libXext x11/libXrender x11-toolkits/libXt multimedia/gstreamer1-plugins-good \
		multimedia/gstreamer1-libav lang/perl5.20 lang/gcc49 shells/bash devel/py-virtualenv devel/git \
		devel/py-gobject devel/dbus devel/yasm

		echo "Installing Library Dependancies"

		pkg install -y multimedia/libv4l graphics/cairo devel/libevent2 devel/libffi graphics/graphite2 \
		print/harfbuzz textproc/hunspell devel/icu devel/nspr security/nss graphics/png x11/pixman \
		audio/soundtouch databases/sqlite3 multimedia/libvpx audio/libvorbis devel/dbus-glib \
		x11/startup-notification audio/alsa-lib converters/libiconv graphics/jpeg accessibility/atk \
		devel/glib20 x11-toolkits/gtk20 x11-toolkits/pango

		echo "Setting up GCC as default compiler..."
		CC=gcc49
		CXX=g++49
		CPP=cpp49
		GCJ=gcj49
		export CC CXX CPP GCJ
		echo "Setting up build environment in /root"
		mkdir /usr/home
		ln -s /usr/home /home
		ln -s /root /usr/home/root
		cd /root
		fetch --no-verify-peer https://raw.githubusercontent.com/RainbowHackerHorse/Moonstrap/Moonstrap-0.9/bsdmozconfig.txt
		mv bsdmozconfig.txt mozconfig.txt
		fetch --no-verify-peer https://raw.githubusercontent.com/RainbowHackerHorse/Moonstrap/master/build.sh
	;;
esac
chmod +x build.sh
mkdir ~/pmbuild
echo "Grabbing source from Git Branch..."
git clone https://github.com/MoonchildProductions/Pale-Moon.git --branch 26.2.0_RelBranch --single-branch pmsrc
# git clone https://github.com/trav90/Pale-Moon.git --branch bsd-work --single-branch pmsrc
chmod -R +x pmsrc/
echo "Building! Cross your fingers!"
#bash ./autobuild.sh
case "$(uname -s)" in
	Linux)
		if cat /etc/*-release | grep -q "CentOS release 6"; then
		scl enable devtoolset-1.1 ./build.sh
		else bash ./build.sh
		fi
	;;
	FreeBSD)
		bash ./build.sh
	;;
esac
