#!/bin/bash
#
# v0.2.1
# SpoddyCoder, 2021
# https://github.com/SpoddyCoder/dji-fpv-and-blackbox-renamer
#

# output filename parts
OUTPUT_FILENAME_PREFIX="Flight_"
GOG_POST=".GOG"
AIR_POST=".AIR"
BLB_POST=".AIR"     # makes gyroflow work flow easier

# file search terms
GOG_PRE="DJIG"
AIR_PRE="DJIU"
BLB_PRE="LOG"


# prompt user to press a key & exit tool
# $1 : message
exitPrompt() {
    echo $1
    read -p "Press any key to exit " -n 1 -r
    exit 0
}

# rename files in current directory
# $1 : "dry-run" | "go"
rename() {
    filecount=0
    lastflightnum=0
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
        if [[ $filename =~ "$AIR_PRE" ]]; then
            fileord=$(echo "$filename" | sed "s/${AIR_PRE}//g")
            flightnum=$(expr $fileord + 1)	# 0 indexed
            filepost=$AIR_POST
        fi
        if [[ $filename =~ "$BLB_PRE" ]]; then
            fileord=$(echo "$filename" | sed "s/${BLB_PRE}//g")
            flightnum=$(expr $fileord + 0)	# 1 indexed
            filepost=$BLB_POST
        fi
        if [ ! -z "$flightnum" ]; then
            filecount=$(expr $filecount + 1)
            lastflightnum=$flightnum
            newfilename="${OUTPUT_FILENAME_PREFIX}${flightnum}${filepost}.${filext}"
            if [ "$1" == "go" ]; then
                echo "Renaming: $basename -> $newfilename"
                mv "$basename" "$newfilename"
            else
                echo "Would rename: $basename -> $newfilename"
            fi
        fi
    done
}

# start
echo
echo "DJI FPV and Blackbox Renamer"
echo
rename "dry-run"
if (( $filecount == 0 )); then
    exitPrompt "No files found - have you placed this tool in the directory containing the video + blackbox files?"
fi
echo
echo "$lastflightnum flights detected"
read -p "Do you want to rename $filecount files? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    rename "go"
    echo
    exitPrompt "$filecount files renamed"
else
    echo
    exitPrompt "Cancelling"
fi
