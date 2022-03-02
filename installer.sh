#!/bin/bash


# ChaosDump Installer v1.0
# Author : Rohit (@marcos_iaf)
# https://twitter.com/marcos_iaf
# https://github.com/720922/chaosDump


##############################################################
#							                                 #
#                  CONFIG VARS		                         #
#							                                 #
##############################################################

# TERM COLORS
bred='\033[1;31m'
bblue='\033[1;34m'
bgreen='\033[1;32m'
yellow='\033[0;33m'
red='\033[0;31m'
blue='\033[0;34m'
green='\033[0;32m'
reset='\033[0m'

##############################################################
#							                                 #
#                  FUNCTIONS		                         #
#							                                 #
##############################################################

logo()
{
printf "${bred}"
printf '''
        __                     ____                      
  _____/ /_  ____ _____  _____/ __ \__  ______ ___  ____ 
 / ___/ __ \/ __ `/ __ \/ ___/ / / / / / / __ `__ \/ __ \
/ /__/ / / / /_/ / /_/ (__  ) /_/ / /_/ / / / / / / /_/ /
\___/_/ /_/\__,_/\____/____/_____/\__,_/_/ /_/ /_/ .___/    Installer
 '''
 printf "${green}==================== ${blue}Developed By: ${yellow}@marcos_iaf${bred} / / " 
 printf "\n${bred}                                               /_/ ${reset}"   
}


main_installer(){
    printf "\n${green}Installing required dependencies...${reset}"
    sudo apt-get -qq install peco -y
    sudo apt-get -qq install jq -y
    sudo apt-get -qq install pv -y 
    printf "\n${green}Dependencies installed succesfully...${reset}"
    printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
    printf "\n${green}Finishing up...${reset}"
    sudo cp chaosDump.sh /usr/local/bin/chaosdump
    printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
    printf "\n\n${yellow}Now you can run chaosDump from anywhere using command${bblue}chaosdump${reset}"
   printf "\n\n${yellow}[${bred}!${yellow}] Setup Finished Succesfully!!${yellow}[${bred}!${yellow}]${reset}"
}


##############################################################
#							                                 #
#                  SCRIPT START		                         #
#							                                 #
##############################################################
logo
main_installer