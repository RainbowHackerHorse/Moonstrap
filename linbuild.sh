
#!/bin/bash

if [ ! -d "pmsrc" ] || [ ! -d "pmbuild" ] || [ ! -f "mozconfig.txt" ] ; then
  echo "Check the directories and files!"
  exit 1
fi

cp mozconfig.txt pmsrc/.mozconfig
cd pmsrc/

echo "Build?"
read -n 1 ch

if [ "$ch" == "y" ] ; then
  make -f client.mk build &> /dev/stdout | tee buildlog.txt
  if [ ${PIPESTATUS[0]} == 0 ]; then
    cd "../pmbuild"
    make package
  fi
else
  echo "Compilation aborted."
fi
