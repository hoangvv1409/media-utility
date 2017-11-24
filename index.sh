#!/bin/bash
## current folder
nohup ./compress.sh 96k . >> compress-log.txt && echo "done $folder"

## sub folders
for folder in $(ls -d */)

do 
	nohup ./compress.sh 96k ${folder%%/} >> compress-log.txt \
	&& echo "done $folder"

done
