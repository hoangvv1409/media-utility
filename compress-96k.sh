#!/bin/bash

#resize mp3

FILES="*.mp3"

for F in $FILES

do
	newname=`basename "$F"` 
	echo "... processing $newname"
	ffmpeg -loglevel "error" -i "$F" -acodec libmp3lame -ab 128k "$newname.mp3" \
	&& echo "... removing $F" && rm "$F"
	echo "done"

done

