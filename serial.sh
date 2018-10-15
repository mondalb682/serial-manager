#!/bin/sh

season=$1
episode=$2
############## you have to change the following two entries ############
location="/D/Modern_Family"
extension=".mkv"

##checking if all seasons are over
total_seasons=`ls "$location" | wc -l`
if [ $season -gt $total_seasons ]; then
	echo SEASON $season NOT FOUND
	exit 0
fi

serial_directory=`ls "$location" | head -$season | tail -1` 

total_episodes=`ls "$location"/"$serial_directory"/*$extension | wc -l`

if [ $episode -gt $total_episodes ]; then
	echo END OF CURRENT SEASON
 	sleep 2
	./serial .
	exit 0
fi

episode_name=`ls  $location/"$serial_directory"/*$extension | head -$episode | tail -1`

echo NOW PLAYING...
echo "SEASON = $season/$total_seasons"
sleep 0.5
echo "EPISODE = $episode/$total_episodes"
sleep 1

xdg-open "$episode_name"    ##double quotes for accessing files/directories with white spaces in their name, 'xdg-open' opens the file in default application
