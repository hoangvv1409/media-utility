### Small bash script to compress mp3/mp4 files

## Files with features
- `compress-mp3.sh <bit-rate:[96k, 128k, ...]> <folder/path2file>`: to compress every .mp3 files in supplied folder or single supplied mp3 file
- `compress-mp4.sh <resolution> <folder/file>`: 
  + `<resolution>: [352x240 (240p)/ 480x360 (360p)/ 858x480 (480p)/ 1280x720 (720p)/ 1920x1080 (1080p)]`
  + to compress every .mp4 files in supplied folder or single supplied mp4 file
- `index.sh <mp3/mp4>`: 
  + process all mp3/mp4 files in current folder
  + process all mp3/mp4 files in sub-folders of current folder
  + output will be written to compress-mp3-log.txt or compress-mp4-log.txt correspond with option
- `trigger-process.sh <folder>`: 
  + listen for created files in supplied folder and compress these files
  + output will be written to notify-logs.txt

## Run
- with result printed to stdout:  
  `$ ./file <options>`
- with result printed to files and refuse hangup signal:  
  ```
  $ nohup ./file <options> &
  $ exit
  ```
