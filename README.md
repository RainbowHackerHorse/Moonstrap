# Moonstrap
Moonstrap is a bootstrapper for building the PaleMoon web browser.
The script is optimised for use in a FreeBSD 11.0-RELEASE jail built by iocage.
However, Moonstrap now supports select Linux Distros (read: the ones I bothered to figure out deps lists for)
That's right, Moonstrap has super sweet ultra futuristic 1980's OS Detection Technology
courtesy of sh!
Right now, Moonstrap supports FreeBSD, CentOS Linux 6, and Arch; Debian Linux and Ubuntu Linux
support is planned for the future.

http://www.palemoon.org/
https://www.freebsd.org/
http://iocage.readthedocs.org/en/latest/

--------------------------------------------------------
INSTRUCTIONS:

FreeBSD:
Run #cd /usr/ports/sysutils/iocage && make install clean
Create your Jail. Please read man iocage or the docs at http://iocage.readthedocs.org/en/latest/
Run #iocage console to hop into the jail, then fetch moonstrap.sh and execute with sh moonstrap.sh as root

Linux:
Wget moonstrap.sh and execute with sh moonstrap.sh as root
Moonstrap is tested with clean servers from Linode.
I can't guarantee it will work if you have all sorts of other stuff already installed
