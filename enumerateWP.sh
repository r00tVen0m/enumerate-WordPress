#!/bin/bash

#Check for given arguments
if [ $# -eq 0 ] 
then
	echo -e "You Need to Specify the target URL and Option\n"
	echo -e "Option: version,theme,users,plugine\n"
	echo -e "Usage:"
	echo -e "\t$0 <URL> <Option>"
	exit 1 

fi
target=$1
options=$2

function get_theme {
     	      get_theme=$(curl -s -X GET $target | sed 's/href=/\n/g' | sed 's/src=/\n/g' | grep 'themes' | cut -d"'" -f2| sort | uniq)    
		echo "$get_theme"
}
function get_plugine {
              get_plugine=$(curl -s -X GET $target | sed 's/href=/\n/g' | sed 's/src=/\n/g' | grep 'wp-content/plugins/*' | cut -d"'" -f2)
	      echo "$get_plugine" 
}
function get_users {

                get_users=$(curl $target/wp-json/wp/v2/users | jq)
		echo "$get_users"
}
function get_version {

               get_version=$(curl -s -X GET $target | grep '<meta name="generator"')
		echo "$get_version" 
}            

if [[ $options == "theme" ]];then
	echo "[+] Start Enumeration Theme.... "
	get_theme


elif [[ $options == "plugine" ]];then
	echo "[+] Start Enumeration Plugine.... "
	get_plugine

elif [[ $options == "users" ]];then
	echo "[+] Start Enumeration Users.... "
	get_users	

elif [[ $options == "version" ]];then
	echo "[+] Start Enumeration Version.... "
	get_version
else
	echo -e "[-] Please Put Argument\n"
	
	exit 1
fi
