#!/bin/bash

#resize mp3
if [ -z $1 ] || [ -z $2 ] ; then
	echo "usage: $0 <bit-rate:[96k, 128k, ...]> <folder>"
	exit 1;
fi

FILES="$2/*.mp3"
suffix=".mp3"

for F in $FILES

do
	newname=`basename "$F"` 
	echo "... processing $2/$newname"
	ffmpeg -loglevel "error" -i "$F" -acodec libmp3lame -ab $1 "$2/$newname$suffix" \
	&& echo "... removing" && rm "$F" \
	&& echo "... renaming" && {
		mv "$F$suffix" "$2/$newname";
	} \
	&& echo "done" || echo "fail"

done

