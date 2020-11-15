#!/bin/bash

amiroot=$(sudo -n uptime 2>&1| grep -c "load")
if [ "$amiroot" -eq 0 ]
then

     printf "Entering superuser mode, insert password.\n"

    sudo -v

    printf "\n"
fi

printf "Updating.\n"

softwareupdate -i -a > /dev/null 2>&1

printf "Cleaning up the trash.\n"

sudo rm -rfv /Volumes/*/.Trashes > /dev/null 2>&1

sudo rm -rfv ~/.Trash  > /dev/null 2>&1

printf "Deleting system log files.\n"

sudo rm -rfv /private/var/log/*  > /dev/null 2>&1

sudo rm -rfv /Library/Logs/DiagnosticReports/* > /dev/null 2>&1

printf "Deleting spotlight indexing (macos will rebuild them).\n"

sudo rm -rf /private/var/folders/ > /dev/null 2>&1

printf "Rebuilding homebrew.\n"

brew cleanup --force -s > /dev/null 2>&1

brew cask cleanup > /dev/null 2>&1

rm -rfv /Library/Caches/Homebrew/* > /dev/null 2>&1

brew tap --repair > /dev/null 2>&1

brew update > /dev/null 2>&1

brew upgrade > /dev/null 2>&1

printf "Purging memory.\n"

sudo purge > /dev/null 2>&1

printf "Freeing space up on the disk(will probably take a while).\n"

diskutil secureErase freespace 0 "$( df -h / | tail -n 1 | awk '{print $1}')" > /dev/null 2>&1

printf "Done!\n"
