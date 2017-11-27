#!/bin/bash

#resize mp3

if [ -z "$1" ] || [ -z "$2" ] ; then
	echo "usage: $0 <bit-rate:[96k, 128k, ...]> <folder/path2file>"
	exit 1;
fi

tempSuffix=".tmpmp3"
bitrate=$1

if [[ -d $2 ]]; then
    # echo "$2 is a directory"
	folder=$2
	FILES="$folder/*.mp3"

	for F in $FILES
	do
		echo "... processing $F"
		ffmpeg -y -loglevel "error" \
				-i "$F" \
				-acodec libmp3lame \
				-ab $bitrate \
				-f mp3 \
				"$F$tempSuffix" -nostdin\
		&& echo "... removing" && rm "$F" \
		&& echo "... renaming" && {
			mv "$F$tempSuffix" "$F";
		} \
		&& echo "done" || echo "fail"

	done
elif [[ -f $2 ]]; then
	fullPath=$2
    # echo "$2 is a file"
	echo "... processing $fullPath"
	ffmpeg -y -loglevel "error" \
			-i "$fullPath" \
			-acodec libmp3lame \
			-ab $bitrate \
			-f mp3 \
			"$fullPath$tempSuffix" -nostdin \
	&& echo "... removing" && rm "$fullPath" \
	&& echo "... renaming" && {
		mv "$fullPath$tempSuffix" "$fullPath";
	} \
	&& echo "done" || echo "fail"
else
    echo "$2 is not valid"
    exit 1
fi



