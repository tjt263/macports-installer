#!/usr/bin/env bash
#
urisvn=https://svn.macports.org/repository/macports/trunk/www/includes/common.inc
uridist=https://distfiles.macports.org/MacPorts
#
mpvers=$(curl -s $urisvn | grep -m 1 -e \'*.*.*\' | cut -d \' -f 2)
osmajor=$(uname -r | cut -d . -f 1)
#
case $osmajor in
8)
    osvers=10.4
    osname=Tiger
    ;;
9)
    osvers=10.5
    osname=Leopard
    ;;
10)
    osvers=10.6
    osname=SnowLeopard
    ;;
11)
    osvers=10.7
    osname=Lion
    ;;
12)
    osvers=10.8
    osname=MountainLion
    ;;
13)
    osvers=10.9
    osname=Mavericks
    ;;
14)
    osvers=10.10
    osname=Yosemite
    ;;
15)
    osvers=10.11
    osname=ElCapitan
    ;;
16)
    osvers=10.12
    osname=Sierra
    ;;
17)
    osvers=10.13
    osname=HighSierra
    ;;
*)
    echo Warning: unknown OS version
    ;;
esac
#
mppkg=MacPorts-${mpvers}-${osvers}-${osname}
mpchk=MacPorts-${mpvers}
echo $mppkg.pkg
echo $mpchk.chk.txt
curl $uridist/$mppkg.pkg -O
curl $uridist/$mpchk.chk.txt -O
sha256=$(shasum -a 256 ./$mppkg.pkg)
#
if grep $sha256 $mpchk.chk.txt;
    then sudo installer -verboseR -allowUntrusted -pkg ./$mppkg.pkg -target /;
fi
#
rm ./$mppkg.pkg
rm ./$mpchk.chk.txt
#
if ! grep -F 'export PATH="/opt/local/bin:/opt/local/sbin:$PATH"' .bash_profile;
    then echo 'export PATH="/opt/local/bin:/opt/local/sbin:$PATH"' >> .bash_profile;
fi
#
