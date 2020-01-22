#!/bin/sh

############SET THIS VARS############
script_dir=/opt/nmap-vulners-es
es_host=localhost
#####################################

current_time=$(date "+%Y.%m.%d")
xml_dir=$script_dir/xml_files/$current_time

cd $script_dir || { echo 'Wrong script dir (set vars in run.sh)' ; exit 1; }

cd /usr/share/nmap/scripts

wget -O vulners.nse https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse && nmap --script-updatedb

mkdir $script_dir/xml_files
mkdir $xml_dir

#Get files list
get_filename(){
    echo $1 | tr $script_dir -
}

#Genearate nmap XML output
while IFS= read -r line
do
  nmap -sV -oX $xml_dir/$line".xml" -oN - -v1 "$@" --script=vulners.nse $line
done < $script_dir/ips.txt

#Send nmap XML output to Elasticsearch
FILES="$xml_dir/*.xml"
for f in $FILES
do
    echo "Processing $f file..."
    python3 $script_dir/VulntoES.py -i $f -e $es_host -r nmap -I nmap-vuln-to-es
done

find $script_dir/xml_files/* -type d -ctime +7 -exec rm -rf {} \;
