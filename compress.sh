#!/bin/bash

#resize mp3
if [ -z $1 ]; then
	echo "usage: $0 <bit-rate:[96k, 128k, ...]>"
	exit 1;
fi

FILES="*.mp3"
suffix=".mp3"

for F in $FILES

do
	newname=`basename "$F"` 
	echo "... processing $newname"
	ffmpeg -loglevel "error" -i "$F" -acodec libmp3lame -ab $1 "$newname$suffix" \
	&& echo "... removing" && rm "$F" \
	&& echo "... renaming" && {
		mv $newname$suffix $newname;
	} \
	&& echo "done"

done

