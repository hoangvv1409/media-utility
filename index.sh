#!/bin/bash

for folder in $(ls -d */)

do 
	`./compress.sh 96k ${folder%%/} >> compress.log` \
	&& echo "done $folder";

done;
