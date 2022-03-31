#!/bin/bash

# ChaosDump v1.0
# Author : Rohit (@marcos_iaf)
# https://twitter.com/marcos_iaf
# https://github.com/720922/chaosDump

##############################################################
#							                   #
#                  CONFIG VARS		                   #
#							                   #
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
url='https://chaos-data.projectdiscovery.io/index.json'
dir_path=~/.config/chaosDP


##############################################################
#							                   #
#                  FUNCTIONS		                         #
#							                   #
##############################################################

logo()
{
printf "${bred}"
printf '''
        __                     ____                      
  _____/ /_  ____ _____  _____/ __ \__  ______ ___  ____ 
 / ___/ __ \/ __ `/ __ \/ ___/ / / / / / / __ `__ \/ __ \
/ /__/ / / / /_/ / /_/ (__  ) /_/ / /_/ / / / / / / /_/ /
\___/_/ /_/\__,_/\____/____/_____/\__,_/_/ /_/ /_/ .___/ 
 '''
 printf "${green}==================== ${blue}Developed By: ${yellow}@marcos_iaf${bred} / / " 
 printf "\n${bred}                                               /_/ ${reset}"   

# '''
printf "${reset}"
printf "\n${yellow}===========The powerful\b\b\b\b\b\b\b\bmost powerful Chaos DB dumper==========\n${reset}"|pv -qL $[55+(-2 + RANDOM%5)]

}

pause(){

        read -p "The selected process has completed. Press The 'Enter' Key, and select an option." fackEnterKey
    }

create_prog_list(){
printf "\n${yellow}[${bred}+${yellow}]${green} Select the program from the databse...${reset}"
# sleep 1
prog_list=$(cat $dir_path/index.json|jq '.[].name'|awk '{print $2}' FS=\")
selected_prog=$(echo "$prog_list"|peco|xargs)
prog_url=$(cat $dir_path/index.json |jq --arg prog "$selected_prog" -r '.[] | select(.name==$prog)|.URL')
printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
}

info(){
create_prog_list
printf "\n${yellow}[${bred}+${yellow}]${green} Looking for the program in the databse..."
printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
if [ -z "$selected_prog" ]
then
printf "\n\n${yellow}[${bred}!${yellow}] No program selected !!${yellow}[${bred}!${yellow}]${reset}"
else 
prog_details=$(cat $dir_path/index.json |jq --arg prog "$selected_prog" -r '.[] | select(.name==$prog)')
prog_details_values=$(echo "${prog_details}"|sed 's/[}{",]//g'|awk '{print $2}');
name=$(echo ${prog_details_values}|awk '{print $1}')
program_url=$(echo ${prog_details_values}|awk '{print $2}')
count=$(echo ${prog_details_values}|awk '{print $4}')
changes=$(echo ${prog_details_values}|awk '{print $5}')
is_new=$(echo ${prog_details_values}|awk '{print $6}')
if [ ! -z $(echo ${prog_details_values}|awk '{print $7}') ]
then
platform=$(echo ${prog_details_values}|awk '{print $7}')
else
platform="N/A"
fi
bounty=$(echo ${prog_details_values}|awk '{print $8}')
last_updated=$(echo ${prog_details_values}|awk '{print $9}')
printf "\n
╔══════════════╦════════════════════════════════════════════════════════════╗
║  Program     ║      ${name}                                   
╠══════════════╬════════════════════════════════════════════════════════════╣
║ name         ║ ${name}                                                              
║ program_url  ║ ${program_url}                                        
║ count        ║ ${count}                                                             
║ change       ║ ${changes}                                                                
║ is_new       ║ ${is_new}                                                            
║ platform     ║ ${platform}                                                        
║ bounty       ║ ${bounty}                                                            
║ last_updated ║ ${last_updated}                                   
╚══════════════╩════════════════════════════════════════════════════════════╝
"
fi
printf "\n\n"
pause
}

dumper(){
create_prog_list
if [ -z $selected_prog ]
then
printf "\n\n${yellow}[${bred}!${yellow}] No program selected!!${yellow}[${bred}!${yellow}]${reset}"
else
printf "\n${yellow}[${bred}+${yellow}]${green} Dumping data for ${blue}$selected_prog...${reset}"
wget -q $prog_url -O $selected_prog.zip
printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
printf "\n${yellow}[${bred}+${yellow}]${green} Extracting data...${reset}"
unzip -q $selected_prog.zip -d $selected_prog
printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
printf "\n${yellow}[${bred}+${yellow}]${green} Dumped Data saved to folder ${blue}$1${reset}"
rm $selected_prog.zip
printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
fi
printf "\n\n"
pause
}

first_run(){
      if [ ! -d $dir_path ]
      then
printf "\n${yellow}[${bred}+${yellow}]${bblue} Seems like this is your first run...${yellow}[${bgreen}#720922${yellow}]${reset}"
printf "\n${yellow}[${bred}+${yellow}]${bblue} Updating configurations for the tool${reset}"
      mkdir $dir_path 
      sleep 1
      printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
      printf "\n${yellow}[${bred}+${yellow}]${bblue} Dumping fresh records from the chaos database${reset}"
      wget $url -q -O $dir_path/index.json
      printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
      printf "\n${yellow}[${bred}+${yellow}]${bblue} Finish setting up.${reset}"
      sleep 2
      printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]\n${reset}"
fi
}

db_updater(){
      if [ -d $dir_path ] 
      then
      {
      printf "\n${yellow}[${bred}+${yellow}]${bblue} Updating configurations for the tool${reset}"
      # mkdir $dir_path 
      sleep 1
      printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
      printf "\n${yellow}[${bred}+${yellow}]${green} Dumping fresh records from the chaos database${reset}"
      wget $url -q -O $dir_path/index.json
      printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]${reset}"
      printf "\n${yellow}[${bred}+${yellow}]${bblue} Finish setting up.${reset}"
      sleep 2
      printf "${yellow}[${bgreen}\xE2\x9C\x94${yellow}]\n${reset}"
      }
      else
      first_run
    fi
}

menu(){
      clear
      logo
      first_run
      printf "%s\n${blue}-----------------------------------------------------${reset}"
    printf "%s\n${bgreen}\t\tChaosDump Menu ${reset}"
    printf "%s\n${blue}-----------------------------------------------------${reset}\n"
    echo "1. Dump Subdomains"
    echo "2. Fetch Stats"
    echo "3. Update DataSet"
    echo "4. Exit" 
}

read_options(){
      local choice
      read -p "Enter choice [ 1 - 4 ] " choice
      case ${choice} in

        1) dumper ;;
        2) info ;;
        3) db_updater ;;
        4) exit 0;; #This will exit out of the application
		*) printf "%s\n${red}Error...Option Not Valid, Please Choose Another${reset}" && sleep 1
	esac


    }



##############################################################
#							                   #
#                  SCRIPT START		                   #
#							                   #
##############################################################
while true
      do
        menu
        read_options
      done
