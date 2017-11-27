#!/bin/bash
if [ -z $1 ]; then
	echo "usage: $0 <folder>"
	exit 1;
fi

nohup inotifywait -m -r \
  -e create \
  --timefmt "%F %T" \
  --format "%w:%e:%f:%T" \
  $1 |
while IFS=':' read directory event file createdAt
do
  fullPath="$directory$file"
  baseName=$(basename "$fullPath") #basename=filename + ext
  path=${fullPath%$baseName} # path = fullPath - basename
  ext="${baseName##*.}" # Trim the longest match from the beginning
  filename="${baseName%.*}"  # Trim the shortest match from the end
  
  if [ "$ext" == "mp3" ]; then
    ./compress-mp3.sh 96k "$fullPath"
  elif [ "$ext" == "mp4" ]; then
    ./compress-mp4.sh 360p "$fullPath"
  else
    echo "not process: $fullPath:$createdAt"
  fi
done >> notify-logs.txt &