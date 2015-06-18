#!/bin/bash


PASSWORD="jobsearch"
PASS_CHANGE="passwd"
DEV_MAKE="make"
CHANGE_PERMS="/bin/chmod"
REPOSITORIES="add-apt-repository"
APT_GET="apt-get"
USER_var = "Public User"

function countdown() {
	for ((i=$1; i>0; i--)); do
	case $1 in
	30)
	    	echo -en "Computer will restart in: " $i " ...press any key to continue...\r"
		;;
	[10,20]*)
		echo -en "Automation will resume in: " $i "  Press any key to coninue...\r"
		;;
	esac
	sleep .3
	read -s -n 1 -t 1 key
    	if [ $? -eq 0 ]; then
		clear
        	break
    	fi
	done
	clear
}

#Create user 'jobsearch' and set password
echo -ne "$PASSWORD\n$PASSWORD\nPublic User\n\n\n\n\ny" | sudo adduser jobsearch --home /home/Public\ User

echo -ne "\n\nPreparing system files and Home directories..."
setfacl -m u:administrator:rwx /home/Public\ User
sleep 5

#acl is not installed by default - install and prepare for config
#--sudo apt-get install acl

#/etc/fstab needs to be edited to accept ACL permissions - you need to
#add "acl" to fstab root partition entry - the entry should read as follows:
#
#	UUID=...   /     ext4     'defaults',acl   0   1
#
#'defaults' denotes options already present, just add 'acl' at the end
echo ' '
echo ' '
echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
echo '   You must modify /etc/fstab to accept acl permissions   '
echo ' when fstab is opened in this terminal window you will'
echo ' need to modify the line with the partition type "ext4".'
echo ' Add "acl"(no quotes) at the end of the fourth column. If'
echo " you are confused by these instrucions, pause this script"
echo ' and open the .sh file in a text editor and read lines'
echo ' 38 - 46.'
echo ' '
echo 'Once your have modified fstab follow these steps: '
echo '	1. Press ctrl+x to quit nano'
echo '	2. Press "y" to save your changes to fstab'
echo '	3. Press enter to exit nano and continue'
echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
echo ' '
countdown 20
#--sudo nano /etc/fstab

#remount the root partition so we can begin setting acl restrcitions
#--sudo mount -o remount / > ~/Desktop/test_out.txt


#Now begin setting permissions of 'jobsearch' user
echo "Setting full restriction for Rhythmbox..."
setfacl -m u:jobsearch:--- /usr/bin/rhythmbox
setfacl -m u:jobsearch:--- /usr/bin/rhythmbox-client
echo "Setting full restriction for Terminal..."
setfacl -m u:jobsearch:--- /usr/bin/gnome-terminal
echo "Setting full restriction for xterm emulator..."
setfacl -m u:jobsearch:--- /usr/bin/xterm
echo "Setting full restriction for uxterm emulator..."
setfacl -m u:jobsearch:--- /usr/bin/uxterm
echo "Setting full restriction for Ubuntu Software Center..."
setfacl -m u:jobsearch:--- /usr/bin/software-center
echo "Setting full restriction for Onboard Settings..."
setfacl -m u:jobsearch:--- /usr/bin/onboard-settings
echo "Setting full restriction for System Settings..."
setfacl -m u:jobsearch:--- /usr/bin/gnome-control-center
echo "Setting full restriction for Remmina RDP Client..."
setfacl -m u:jobsearch:--- /usr/bin/remmina
echo "Setting full restriction for Network Control..."
setfacl -m u:jobsearch:--- /usr/bin/gnome-nettool
echo "Setting full restriction for Disk Image Mounting..."
setfacl -m u:jobsearch:--- /usr/bin/gnome-disk-image-mounter
echo "Setting full restriction for System Monitor..."
setfacl -m u:jobsearch:--- /usr/bin/gnome-system-monitor
echo "Setting full restriction for Gnome Disk Utility..."
setfacl -m u:jobsearch:--- /usr/bin/gnome-disks
echo "Setting full restriction for dev utils and term tools..."
setfacl -m u:jobsearch:--- /usr/bin/$DEV_MAKE
setfacl -m u:jobsearch:--- /usr/bin/$PASS_CHANGE
setfacl -m u:jobsearch:--- /bin/$CHANGE_PERMS
setfacl -m u:jobsearch:--- /usr/bin/$REPOSITORIES
setfacl -m u:jobsearch:--- /usr/bin/$APT_GET
echo "Setting full restriction for web cam utils..."
setfacl -m u:jobsearch:--- /usr/bin/cheese
echo "Setting full restriction for optical disk creation..."
setfacl -m u:jobsearch:--- /usr/bin/brasero
echo "Setting full restriction for all games..."
setfacl -R -m u:jobsearch:--- /usr/games/
echo "Granting access to Home folder..."
setfacl -R -m u:jobsearch:rwx /home/Public\ User


# UNCOMMENT THE FOLLOWING TO USE TEAMVIEWER RATHER THAN X11VNC:
#
#echo "Setting up Teamviewer for remote access..."
#cd ~/downloads
#wget http://download.teamviewer.com/download/version_9x/teamviewer_linux.deb
#sudo dpkg -i ~/Downloads/teamviewer_linux.deb
#sudo apt-get -f install
#cd /usr/bin


#SSH is needed to create a secure tunnel so we can use a vnc tunnel for remote desktop. The following provides the option to install only SSH for cmd administration only, or x11vnc for graphical administration only, or both. There is no default option but both is recommended.
echo " "
echo " "
echo "We need to install ssh for remote command-line access and/or"
echo "x11vnc for remote desktop access. You may choose to install"
echo "either or both depending on the machine and its intended use."
echo " "
countdown 10
echo " "
echo " "
echo "What would you like to install?"
echo " "
echo "1. SSH Only"
echo "2. VNC Only"
echo "3. Both"
echo "4. Neither"
echo " "
read -p "> " remote

case $remote in
1)
    sudo apt-get install openssh && sudo apt-get install opensshd
    ;;
2)
    sudo apt-get install x11vnc
    sudo cp x11vnc.desktop /Home/$USER_var/.config/autostart/x11vnc.desktop
    sudo cp x11vnc.desktop /user/share/applications/x11vnc.desktop
    x11vnc -forever -display :0
    ;;
3)
    sudo apt-get install openssh && sudo apt-get install opensshd
    sudo apt-get install x11vnc
    sudo cp x11vnc.desktop /Home/$USER_var/.config/autostart/x11vnc.desktop
    sudo cp x11vnc.desktop /user/share/applications/x11vnc.desktop
    x11vnc -forever -display :0
    ;;
4)
    echo "Skipping ssh and vnc installation. Moving on..."
    countdown 10
esac




echo " "
echo " "
echo "All Operations have completed successfully."
echo " "
echo " "
read -p "Reboot [now] or [wait]? " _reboot

function reboot_func() {

    if [$_reboot == "now"]
    then
        countdown 30
    elif [$_reboot == "wait"]
    then
        echo "DONE!"
        exit
    else
        'Type "now" to reboot now or type "wait" to reboot later...'
        reboot_func
    fi

}

reboot_func

#countdown 30

#reboot now
