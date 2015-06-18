#remove restrictions for all extended users - in this case we only
#have one user to clean up.

PASS_CHANGE="passwd"
DEV_MAKE="make"
CHANGE_PERMS="chmod"
REPOSITORIES="add-apt-repository"
APT_GET="apt-get"

echo "P\@$$w0rd" | su root


echo "Removing restrictions for Rhythmbox..."
setfacl -x u:jobsearch /usr/bin/rhythmbox
setfacl -x u:jobsearch /usr/bin/rhythmbox-client
echo "Removing restrictions for Terminal..."
setfacl -x u:jobsearch /usr/bin/gnome-terminal
echo "Removing restrictions for xterm emulator..."
setfacl -x u:jobsearch /usr/bin/xterm
echo "Removing restrictions for uxterm emulator..."
setfacl -x u:jobsearch /usr/bin/uxterm
echo "Removing restrictions for Ubuntu Software Center..."
setfacl -x u:jobsearch /usr/bin/software-center
echo "Removing restrictions for Onboard Settings..."
setfacl -x u:jobsearch /usr/bin/onboard-settings
echo "Removing restrictions for System Settings..."
setfacl -x u:jobsearch /usr/bin/gnome-control-center
echo "Removing restrictions for Remmina RDP Client..."
setfacl -x u:jobsearch /usr/bin/remmina
echo "Removing restrictions for Network Control..."
setfacl -x u:jobsearch /usr/bin/gnome-nettool
echo "Removing restrictions for Disk Image Mounting..."
setfacl -x u:jobsearch /usr/bin/gnome-disk-image-mounter
echo "Removing restrictions for System Monitor..."
setfacl -x u:jobsearch /usr/bin/gnome-system-monitor
echo "Removing restrictions for Gnome Disk Utility..."
setfacl -x u:jobsearch /usr/bin/gnome-disks
echo "Removing restrictions for dev utils and term tools..."
setfacl -x u:jobsearch /usr/bin/$DEV_MAKE
setfacl -x u:jobsearch /usr/bin/$PASS_CHANGE
setfacl -x u:jobsearch /bin/$CHANGE_PERMS
setfacl -x u:jobsearch /usr/bin/$REPOSITORIES
echo "Removing restrictions for web cam utils..."
setfacl -x u:jobsearch /usr/bin/cheese
echo "Removing restrictions for optical disk creation..."
setfacl -x u:jobsearch /usr/bin/brasero
echo "Removing restrictions for all games..."
setfacl -R -x u:jobsearch /usr/games/

sleep 4


#Delete user
deluser jobsearch

#Delete user's home directory
echo -ne "Removing /home/user directory...\n\n"
sleep 4
rm -r /home/Public\ User

#Remove Teamviewer
sudo apt-get remove teamviewer
