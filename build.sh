#!/usr/bin/env bash

if [ ! -d "pmsrc" ] || [ ! -f "mozconfig.txt" ] ; then
  echo "Check the directories and files!"
  exit 1
fi

cp mozconfig.txt pmsrc/.mozconfig
cd pmsrc/

echo "Build?"
read -n 1 ch

if [ "$ch" == "y" ] ; then
  gmake -f client.mk build &> /dev/stdout | tee buildlog.txt
  if [ ${PIPESTATUS[0]} == 0 ]; then
    cd "../pmbuild"
    gmake package
  fi
else
  echo "Compilation aborted."
fi
