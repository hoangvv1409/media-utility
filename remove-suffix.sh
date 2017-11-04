#!/bin/bash
FILES="*.mp3"

for F in $FILES

do
	echo "... processing $F"
	suffix=".mp3"
	newname=${F%$suffix}
	mv "$F" "$newname"\
	&& echo "done"

done
