#!/bin/bash
# Note
# -profile:v baseline -level 3.0 : suitable for every devices
# -f "mp4" : output format
# -nostdin : solve problem of printing "Enter command: <target>|all <time>|-1 <command>[ <argument>]" to stdout
# do not put anything after "\"

#resize mp4
if [ -z "$1" ] || [ -z "$2" ] ; then
	echo "usage: $0 <resolution> <folder/path2file>
    --resolution: [352x240 (240p)/ 480x360 (360p)/ 858x480 (480p)/ 1280x720 (720p)/ 1920x1080 (1080p)]"

	exit 1;
fi

tempSuffix=".tmpmp4"
resolution=$1
# standardize resolution value
if [[ $resolution == *"p" ]]; then 
	res=${resolution%$"p"}
	case $res in
		"240") resolution="352x240"; res_short="240p";; 
		"360") resolution="480x360"; res_short="360p";; 
		"480") resolution="858x480"; res_short="480p";; 
		"720") resolution="1280x720"; res_short="720p";; 
		"1080") resolution="1920x1080"; res_short="1080p";; 
	esac
else
	case $resolution in
		"352x240") res_short="240p";; 
		"480x360") res_short="360p";; 
		"858x480") res_short="480p";; 
		"1280x720") res_short="720p";; 
		"1920x1080") res_short="1080p";; 
	esac
fi

if [[ -d $2 ]]; then
    # echo "$2 is a directory"
	folder=$2
	FILES="$folder/*.mp4"

	for F in $FILES
	do
		echo "... processing $F"
		ffmpeg -y -loglevel "error" \
                -i "$F" \
                -profile:v baseline -level 3.0 \
                -s "$resolution" \
                -start_number 0 \
				-f mp4 \
                "$F$tempSuffix" -nostdin \
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
            -profile:v baseline -level 3.0 \
            -s "$resolution" \
            -start_number 0 \
			-f mp4 \
            "$fullPath$tempSuffix" -nostdin\
	&& echo "... removing" && rm "$fullPath" \
	&& echo "... renaming" && {
		mv "$fullPath$tempSuffix" "$fullPath";
	} \
	&& echo "done" || echo "fail"
else
    echo "$2 is not valid"
    exit 1
fi




