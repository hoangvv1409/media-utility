#!/bin/bash

for folder in $(ls -d */)

do 
	nohup ./compress.sh 96k ${folder%%/} >> compress-log.txt \
	&& echo "done $folder"

done
