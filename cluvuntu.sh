#!/bin/bash
# Execute this script after a fresh Ubuntu install to auto install
# our favourite packages and remove all the unwanted shit.
# Installs the following applications:
# Google Chrome
# Sublime Text 2 (Worlds best text editor)
# Tilda (terminal emulator)
# Terminator (terminal emulator)
# VLC Player
# EmmaSQL (GUI for MySQL like HeidiSQL for Windows)
# Installs the following languages, dev tools and environments:
# curl and xclip
# Git and GitHub connection
# Oracle Java JDK and JRE
# Spyder (IDE for python)
# Python modules:
# 		scipy, numpy, matplotlib, dateutil, pytz, setuptools,
# 		dev, statsmodels, pandas, qt4, cvxopt, pysqlite2,
# 		mysqldb, libapache2
# Django
# QSTK (python financial tool)
# R and RStudio (IDE for R)
# LAMP
# SQLite
# Ruby RVM and Ruby on Rails
# Remove the following:
# Firefox, Thunderbird, Gwibber, Orca Reader, Empathy, all games
echo "Cluvuntu 2012: Ubuntu 12.04 LTS, Clive styles"

# Install curl
echo "Installing curl... (why isnt this standard?)"
sudo apt-get install curl

# Install Chrome
echo "Installing Chrome..."
# Get key
echo "add key from google"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Add repo to apt
echo "add repository to apt"
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# Update package list
sudo apt-get update
# Install chrome
echo "install"
sudo apt-get install google-chrome-stable

# Get Sublime Text 2
echo "Installing Sublime Text 2..."
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text
echo "please test 'subl' command line tool"

# Get Git
echo "Installing Git and connecting to GitHub..."
sudo apt-get install git-core
# Sets the default name for git to use when you commit
git config --global user.name $USER
# Sets the default email for git to use when you commit
echo -n "Enter your email address and press [ENTER]: "
read email
git config --global user.email $email
# Set git to use the credential memory cache
git config --global credential.helper cache
# Set the cache to timeout after 1 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'
# Downloads and installs xclip
sudo apt-get install xclip
# Checks to see if there is a directory named ".ssh" in your user directory
ls /home/$USER/.ssh
echo "Lists all the subdirectories in the current directory"
echo "Something like: config id_rsa id_rsa.pub known_hosts"
# Makes a subdirectory called "key_backup" in the current directory
mkdir /home/$USER/.ssh/key_backup
# Copies the id_rsa keypair into key_backup
cp /home/$USER/.ssh/id_rsa* /home/$USER/.ssh/key_backup
# Deletes the id_rsa keypair
rm /home/$USER/.ssh/id_rsa*
echo "Creating a new ssh key using email"
ssh-keygen -t rsa -C "clive.gross1@gmail.com"
clip < /home/$USER/.ssh/id_rsa.pub
echo "Open https://github.com/settings/ssh in browser, paste key and click 'Add key'"
echo "Attempting to ssh to github..."
ssh -T git@github.com
cd ~/

# Install Tilda command line emulator
echo "Installing Tilda..."
sudo apt-get install tilda

# Install Terminator command line emulator
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

# SQLite
echo "Installing SQLite"
sudo apt-get install sqlite3

# Install Oracle Java Runtime Environment, sould have OpenJDK
java -version
echo "Installing Oracle Java JDK 7"
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-jdk7-installer
jdk -version

# Install python modules
echo "Installing some sick python modules..."
echo "Check python version, should be 2.7 or 2.8"
python --version
echo "Installing Apache module mod_python"
sudo apt-get install libapache2-mod-python
echo "Installing MySQL module mysqldb"
sudo apt-get install python-mysqldb
echo "Installing SQLite module python-pysqlite2"
sudo apt-get install python-pysqlite2
echo "Installing Django"
sudo apt-get install python-django
echo "Installing other python modules..."
echo "python-numpy"
sudo apt-get install python-numpy
echo "python-scipy"
sudo apt-get install python-scipy
echo "python-matplotlib"
sudo apt-get install python-matplotlib
echo "python-dev"
sudo apt-get install python-dev
echo "python-setuptools"
sudo apt-get install python-setuptools
echo "scikits.statsmodels"
sudo easy_install -U scikits.statsmodels
echo "pytz"
sudo easy_install --upgrade pytz
echo "python-dateutil"
sudo apt-get install python-dateutil
echo "pandas"
sudo easy_install pandas==0.7.3
echo "python-qt4"
sudo apt-get install python-qt4
echo "python-cvxopt"
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

# Install R
echo "Installing R..."
# Firstly get the repository SSL key and import it in to apt.
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
# Next edit your sources list...
sudo add-apt-repository "deb http://cran.ma.imperial.ac.uk/bin/linux/ubuntu precise/"
# install R.
sudo apt-get update
sudo apt-get install r-baseAB9

# RStudio
echo "Installing RStudio"
$ sudo apt-get install gdebi-core
$ sudo apt-get install libapparmor1  # Required only for Ubuntu, not Debian
$ wget http://download2.rstudio.org/rstudio-server-0.97.248-amd64.deb
$ sudo gdebi rstudio-server-0.97.248-amd64.deb

# Install EmmaSQL
echo "Install EmmaSQL.."
sudo apt-get install emma

# Spyder
echo "Spyder"
echo apt-get install spyder

# Ruby RVM
# echo "Install Ruby..."
# ruby -v
# curl -L get.rvm.io | bash -s stable
# source ~/.rvm/scripts/rvm
# rvm requirements
# echo "Copy above list of Additional Dependencies and paste #"
# read name
# eval $name
# rvm install 1.9.3
# rvm use 1.9.3 --default
# Ruby on Rails
# echo "Install Ruby on Rails..."
# rvm rubygems current
# gem install rails

# Remove:
# Remove Firefox completely:
# from http://askubuntu.com/questions/183319/how-to-completely-remove-firefox-so-it-wont-update
echo "Removing Firefox..."
sudo apt-get --purge autoremove firefox
echo "should see these packages uninstalled:"
echo "firefox firefox-globalmenu firefox-gnome-support"
# This bastard is usually left behind
sudo apt-get --purge autoremove firefox-locale-en
# check and remove anything left
echo "the following packages remain, please uninstall manually"
dpkg --list | grep firefox
# Thunderbird
echo "Removing Thunderbird..."
sudo apt-get remove --purge thunderbird
echo "Removing Gwibber..."
sudo apt-get remove --purge gwibber gwibber-*
echo "Removing Mahjong..."
sudo apt-get remove --purge mahjongg
echo "Removing Mines..."
sudo apt-get remove --purge gnomine
echo "Removing Solitaire..."
sudo apt-get remove --purge aisleriot
echo "Removing Empathy..."
sudo apt-get remove --purge empathy
echo "Removing Orca Reader..."
sudo apt-get remove --purge gnome-orca
sudo apt-get autoremove --purge

echo "Clean up"
# Cleaning up of partial package
sudo apt-get autoclean
# Cleaning up of the apt cache:
sudo apt-get clean

echo "Write a list of all installed and uninstalled packages to installed-software in home directory"
dpkg --get-selections > installed-software
# Get Dropbox, VMWare, Matlab
echo "Install Dropbox, VMWare Player, Matlab for Unix manually"
