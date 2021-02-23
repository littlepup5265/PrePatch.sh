#!/bin/bash

for options in $(echo $@)
do
  SERVERLIST=$options
done

if [ ! -s "$SERVERLIST" ]:wq
then
  echo "ERROR: $SERVERLIST does not exit"
  exit 1
fi

for i in $(cat $SERVERLIST)
do
        echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        echo $i
        rosh -l root -n $i -t 'uname -r;cat /etc/redhat-release;yum check-update |grep -I kernel'
        rosh -l root -n $i -t 'ps -ef | grep cybAgent'
        rosh -l root -n $i -t 'rpm -qa |grep gpfs*'
        echo Available Scripts
        rosh -l root -n $i -t 'ls -la /bbtscripts/unix/validate_*;ls -la /bbtscripts/web/validate_*'
        echo Numbers of Mount:
        rosh -l root -n $i -t 'df -Ph|wc -l'
        echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
done 