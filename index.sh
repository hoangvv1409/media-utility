#!/bin/bash
if [ -z $1 ]; then
	echo "usage: $0 <mp3/mp4>"
	exit 1;
fi

if [ $1 == "mp3" ]; then
	# current folder
	nohup ./compress-mp3.sh 96k . >> compress-mp3-log.txt && echo "done ./"
	## sub folders
	for folder in $(ls -d */)

	do 
		nohup ./compress-mp3.sh 96k ${folder%%/} >> compress-mp3-log.txt \
		&& echo "done $folder"

	done
elif [ $1 == "mp4" ]; then
	# current folder
	nohup ./compress-mp4.sh 360p . >> compress-mp4-log.txt && echo "done ./"
	## sub folders
	for folder in $(ls -d */)

	do 
		nohup ./compress-mp4.sh 360p ${folder%%/} >> compress-mp4-log.txt \
		&& echo "done $folder"

	done
else
	echo "invalid option: $1"
	exit 1;
fi


