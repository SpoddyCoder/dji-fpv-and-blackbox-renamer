#!/bin/bash

FLIGHT_PREFIX="Flight_"
GOG_PRE="DJIG"
GOG_POST=".GOG"
AIR_PRE="DJIU"
AIR_POST=".AIR"
BLB_PRE="LOG"
BLB_POST=""
testmode=true

echo
echo "SpoddyCoder DJI FPV and Blackbox Renamer"
if [ "$#" -eq 0 ]; then
	echo "Test Mode (use 'go' flag to run for real)"
	tesmode=true
fi
if [ "$#" -ne 0 ]; then
	if [ "$1" == "go" ]; then
		echo "Live Mode - renaming files"
		testmode=false
	else
		echo "Error: invalid arguments"
		exit 1
	fi
fi

echo
for file in ./*; do

	flightnum=""
	basename=$(basename "$file")
	filext=$(echo "${basename##*.}")
	filename=$(echo "${basename%%.*}")
	if [[ $filename =~ "$GOG_PRE" ]]; then
		fileord=$(echo "$filename" | sed "s/${GOG_PRE}//g")
		flightnum=$(expr $fileord + 1)	# 0 indexed
		filepost=$GOG_POST
	fi
	if [[ $filename == *"$AIR_PRE"* ]]; then
		fileord=$(echo "$filename" | sed "s/${AIR_PRE}//g")
		flightnum=$(expr $fileord + 1)	# 0 indexed
		filepost=$AIR_POST
	fi
	if [[ $filename == *"$BLB_PRE"* ]]; then
		fileord=$(echo "$filename" | sed "s/${BLB_PRE}//g")
		flightnum=$(expr $fileord + 0)	# 1 indexed
		filepost=$BLB_POST
	fi
	if [ ! -z "$flightnum" ]; then
		newfilename="${FLIGHT_PREFIX}${flightnum}${filepost}.${filext}"
		echo "Renaming: $basename -> $newfilename"
		if [ "$testmode" == "false" ]; then
			mv "$basename" "$newfilename"
		fi
	fi

done

echo
echo "Finished"
exit 0
