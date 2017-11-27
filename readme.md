### Small bash script to reduce bitrate of .mp3 file

## Files with features
- compress-mp3.sh <bitrate> <folder/file>: to compress every .mp3 files in supplied folder or single supplied mp3 file
- compress-mp4.sh <resolution> <folder/file>: to compress every .mp4 files in supplied folder or single supplied mp4 file
- index.sh <mp3/mp4>: 
  + process all mp3/mp4 files in current folder
  + process all mp3/mp4 files in sub-folders of current folder
  + output will be written to compress-mp3-log.txt or compress-mp4-log.txt correspond with option
- trigger-process.sh <folder>: 
  + listen for created files in supplied folder and compress these files
  + output will be written to notify-logs.txt