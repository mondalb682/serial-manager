#!/bin/sh

season=$1
episode=$2
############## you have to change the location ############
location="/D/Modern_Family"

allextentions=( mkv .mp4 .MP4 .MKV .avi .AVI .wmv .WMV .mov .MOV .flv .FLV .m4v .M4V )
numberofextentions=${#allextentions[@]}

##checking if all seasons are over
total_seasons=`ls "$location" | wc -l`
if [ $season -gt $total_seasons ]; then
	echo SEASON $season NOT FOUND
	exit 0
fi

serial_directory=`ls "$location" | head -$season | tail -1` 

total_episodes=0
i=-1
while [ $total_episodes -eq 0 -a $i -lt $numberofextentions ]
do	
	i=`expr $i + 1`
	total_episodes=`ls --sort=version "$location"/"$serial_directory"/*"${allextentions[i]}" | wc -l`
done

if [ $episode -gt $total_episodes ]; then
	echo END OF CURRENT SEASON
 	sleep 2
	./serial .
	exit 0
fi

##--sort=version sorts in order of name including the number
episode_name=`ls --sort=version "$location"/"$serial_directory"/*"${allextentions[i]}" | head -$episode | tail -1`

echo NOW PLAYING...
echo "SEASON = $season/$total_seasons"
sleep 0.5
echo "EPISODE = $episode/$total_episodes"
sleep 1

xdg-open "$episode_name"    ##double quotes for accessing files/directories with white spaces in their name, 'xdg-open' opens the file in default application
