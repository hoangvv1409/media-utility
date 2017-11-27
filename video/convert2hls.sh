#!/bin/bash

if [ -z $1 ] || [ -z $2 ] ; 
then 
	echo "usage: $0 <folder> <segment-second>
	--segment-seconds: [10/20/...]";
	exit 1;
fi;
# --resolution: [352x240 (240p)/ 480x360 (360p)/ 858x480 (480p)/ 1280x720 (720p)/ 1920x1080 (1080p)]
folder=$1
segment_second=$2

# standardize segment second value
if [[ $segment_second == *"s" ]]; then
	segment_second=${segment_second%$"s"} 
fi;
# # standardize resolution value
# if [[ $resolution == *"p" ]]; then 
# 	res=${resolution%$"p"}
# 	case $res in
# 		"240") resolution="352x240"; res_short="240p";; 
# 		"360") resolution="480x360"; res_short="360p";; 
# 		"480") resolution="858x480"; res_short="480p";; 
# 		"720") resolution="1280x720"; res_short="720p";; 
# 		"1080") resolution="1920x1080"; res_short="1080p";; 
# 	esac
# else
# 	case $resolution in
# 		"352x240") res_short="240p";; 
# 		"480x360") res_short="360p";; 
# 		"858x480") res_short="480p";; 
# 		"1280x720") res_short="720p";; 
# 		"1920x1080") res_short="1080p";; 
# 	esac
# fi

function appendVariantPlaylistEntryToMasterPlaylist(){
playlist_name=$1
playlist_path=$2
playlist_bw=$(( $3 * 1000 )) # bits not bytes :)

cat << EOM >> "$playlist_name"
#EXT-X-STREAM-INF:BANDWIDTH=$playlist_bw
$PATH_PREFIX$playlist_path
EOM

}

convert(){
	folder=$1
	resolution=$2
	res_short=$3
	segment_second=$4
	FILES="$folder/*.mp4"
	for F in $FILES
	do
		filename=$(basename "$F");
		filename="${filename%.*}"
		if [ ! -d "$folder/$filename" ] ; then mkdir "$folder/$filename"; fi
		mkdir "$folder/$filename/$res_short";
		ffmpeg -y -loglevel "error" \
				-i "$F" \
				-profile:v baseline -level 3.0 \
				-s "$resolution" \
				-start_number 0 \
				-hls_time "$segment_second" \
				-hls_list_size 0 \
				-f hls \
				"$filename/$res_short/$filename.m3u8";

	done

}

RES_ARR=("240p" "360p" "480p" "720p" "1080p")
for res_short in ${RES_ARR[*]}
do
	res=${res_short%$"p"}
	case $res in
		"240") resolution="352x240";; 
		"360") resolution="480x360";; 
		"480") resolution="858x480";; 
		"720") resolution="1280x720";; 
		"1080") resolution="1920x1080";; 
	esac

	convert "$folder" "$resolution" "$res_short" "$segment_second";
done
