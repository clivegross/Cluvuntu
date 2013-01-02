#!/bin/bash
# Execute this script line by line after a fresh Ubuntu install to auto install
# our favourite packages and remove all the unwanted shit
echo "Cluvuntu 2012: Ubuntu 12.04 LTS, Clive styles"

# Install Chrome
echo "Installing Chrome..."
# Get key 
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Add repo to apt
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# Update package list
sudo apt-get update
# Install chrome
sudo apt-get install google-chrome-stable

# Remove Firefox completely:
# from http://askubuntu.com/questions/183319/how-to-completely-remove-firefox-so-it-wont-update
echo "Removing Firefox..."
sudo apt-get --purge autoremove firefox
echo "should see these packages uninstalled:"
echo "firefox firefox-globalmenu firefox-gnome-support"
# check and remove anything left
echo "the following packages remain, please uninstall manually"
dpkg --list | grep firefox
dpkg --list | grep mozilla

# Get Sublime Text 2
echo "Installing Sublime Text 2..."
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text
echo "please test 'subl' command line tool"

# Get Git
echo "Installing Git..."
sudo apt-get install git-core
# Sets the default name for git to use when you commit
git config --global user.name "clivegross"
# Sets the default email for git to use when you commit
git config --global user.email "clive.gross1@gmail.com"
# Set git to use the credential memory cache
git config --global credential.helper cache
# Set the cache to timeout after 1 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'
# Checks to see if there is a directory named ".ssh" in your user directory
cd ~/.ssh
echo "Lists all the subdirectories in the current directory"
echo "Something like: config  id_rsa  id_rsa.pub  known_hosts"
ls
# Makes a subdirectory called "key_backup" in the current directory
mkdir key_backup
# Copies the id_rsa keypair into key_backup
cp id_rsa* key_backup
# Deletes the id_rsa keypair
rm id_rsa*
echo "Creating a new ssh key using email"
ssh-keygen -t rsa -C "clive.gross1@gmail.com"
clip < ~/.ssh/id_rsa.pub
echo "Open https://github.com/settings/ssh in browser, paste key and click 'Add key'"
echo "Attempting to ssh to github..."
ssh -T git@github.com
cd ~/

# Install Tilda command line emulator
echo "Installing Tilda..."
sudo apt-get install tilda

# Install  Terminator command line emulator
echo "Installing Terminator..."
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator

# Install VLC Player (without mozilla-plugin-vlc)
echo "Installing VLC Player..."
sudo apt-get install vlc vlc-plugin-pulse

# Install LAMP (LAMP with python)
echo "Installing LAMPP..."
sudo apt-get install tasksel
sudo tasksel install lamp-server

# Install Oracle Java Runtime Environment, sould have OpenJDK
java -version
echo "Installing java JRE"
sudo add-apt-repository ppa:webupd8team/java to add the partner repository.
sudo apt-get update
sudo apt-get install oracle-java7-installer
java -version
sudo update-alternatives --config java

# Install python modules
echo "Installing some sick python modules"
echo "Check python version, should be 2.7 or 2.8"
python --version
echo "Installing Apache module mod_python"
sudo apt-get install libapache2-mod-python
echo "Installing MySQL module mysqldb"
sudo apt-get install python-mysqldb
echo "Installing other python modules"
sudo apt-get install python-numpy
sudo apt-get install python-scipy
sudo apt-get install python-matplotlib
sudo apt-get install python-dev
sudo apt-get install python-setuptools
sudo easy_install -U scikits.statsmodels
sudo easy_install --upgrade pytz
sudo apt-get install python-dateutil
sudo easy_install pandas==0.7.3
sudo apt-get install python-qt4
sudo apt-get build-dep python-cvxopt
sudo apt-get install python-cvxopt

# Install QSTK
echo "Installing QSTK"
git clone https://github.com/tucker777/QSTK QSTK
cd QSTK
cp config.sh local.sh
echo "Opening .bashrc, add line 'source QSTK/local.sh' to end of script, save and exit"
subl ~/.bashrc
echo "Log out, then log back in"
echo "Test environment variables:"
echo $QSDATA
echo "should print: /nethome/tb34/QSTK/QSData"

echo "Restating apache"
/etc/init.d/apache2 restart

# Install:
# EmmaSQL
# SQLite
# Spyder
# RStudio
# Matlab for Unix
# Dropbox
# VMWare Player
# Ruby
# Ruby on Rails

# Remove:
# anything else not used

echo "Clean up"
# Cleaning up of partial package
sudo apt-get autoclean
# Cleaning up of the apt cache:
sudo apt-get clean