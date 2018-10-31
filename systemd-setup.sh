#!/bin/bash

#===================================================================
#
#
# 	setup script for first time setup of dynup as a systemd
#	service.
#
#	Reed Bell	-	rbell11235@hotmail.co.nz
#
#
#===================================================================

service_script='./dynup-template.service'
actual_script='dynup.service'
systemd_path_def="$PWD"
log_path_def="$PWD"
update_def=600
verbosity_def="0"
dynup_dir_def="$PWD"
[ ! -f $service_script  ] && echo "service script not found! Exiting" && exit -1 

# First, we check whether this has already been done before (i.e.
# systemd service already running/.service script already exists)
printf "Checking if dynup is already setup...\n"
(systemctl is-active --quiet dynup)
stat_exit=$?

# Grab parameters
if [ $stat_exit -ne 0 ]; then	
	#	Path to place service script
	printf "Input full path to place the systemd service script [default: $systemd_path_def]\n\n"
	printf "Directory:  "	
	read -e systemd_path 
	[ ! -d $systemd_path ] && echo "$systemd_path is not a valid directory! Exiting..." && exit -1
	if [ -z $systemd_path  ]; then systemd_path=$systemd_path_def;fi
	
	#	Path to logfile
	printf "Input full path to place the log file [default: $log_path_def]\n\n"
	printf "Directory:  "
	read -e log_path
	[ ! -d $log_path ] && echo "$log_path is not a valid directory! Exiting..." && exit -1
	if [ -z $log_path ]; then log_path=$log_path_def;fi

	#	FreeDNS query
	printf "Input https FreeDNS query\n\n"
	printf "Query:  "
	read -e query
	if [[ ${query} != "https:"* ]]; then echo "Query is not HTTPS or invalid. Exiting..." && exit -1; fi

	#	Update interval
	printf "Input integer update time (min) [default: $update_def]\n\n"
	printf "Update:  "
	read -e update
	if [[ $update =~ ^-?[0-9]+$ ]]; 
		then 
			: ; # 	Do nothing  
		
		else   
			echo "No valid interval entered. Using default update interval"; 
			update=$update_def	
	fi
	
	#	Verbosity
	printf "Input verbosity level (0, 1) [default: $verbosity_def]\n\n"
	printf "Verbosity:  "
	read -e verbosity
	if [ $verbosity == 1 ]; 
	then
		verbosity="-v"

	else

		echo "Using default [$verbosity_def]\n\n"
		verbosity=""

	fi
	
	#	dynup script placement	
	if [ ! -d "$HOME/bin" ]; 
	then
		printf "User bin folder not detected. Enter a location to copy dynup [default: $dynup_dir_def ]\n\n"
		printf "Directory:  "
		read dynup_dir
		if [ -z $dynup_dir ];
		then 
			dynup_dir=$dynup_dir_def 
		
		fi	

	else
		dynup_dir="$HOME/bin/"
		
	fi

else
	printf "dynup already setup with systemd! Exiting...\n"
	exit 0

fi

[ ! -f "$dynup_dir/dynup"  ] && echo "Copying dynup script to $dynup_dir" && cp "$dynup_dir_def/dynup" "$dynup_dir"

replace="ExecStart=$dynup_dir/dynup -l ${log_path}/dynup-log.log -q ${query} -f ${update} ${verbosity}"
sed "/ExecStart=/c\\${replace}" ${service_script}  > ${systemd_path}/${actual_script}
echo "Created ${actual_script} and placed into ${systemd_path}/"
