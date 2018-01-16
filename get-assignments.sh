#!/bin/bash

roster=$(cat roster.txt)
homeReg='\/.*[0-9]'
folderName=$1
assignmentName=$2
reportPath="turnin/${folderName}/report"

mkdir -p turnin/${folderName}

echo CS190 Python - Assignment Report for ${folderName} > ${reportPath}.txt
echo netID,turnedInOn,fileName,isLate,grade,comments, > ${reportPath}.csv

currentDate=$(date +%m-%d-%Y)
currentTime=$(date +%H:%M)
echo Report generated on: $currentDate at $currentTime >> ${reportPath}.txt

cat roster.txt | while read student
do
	# finds the path for the student's directory
	homeDir=$(getent passwd $student | grep -o $homeReg <<< $(getent passwd $student))

	printf ${student}, >> ${reportPath}.csv	

	# see if assignment exists
	# supress output of ls
	ls ${homeDir}/turnin/*1.ipynb  2>/dev/null 1>/dev/null

	# checks to see if the notebook exists
	if [ $? -eq 0 ]
	then
		echo ${student}: TURN IN >> ${reportPath}.txt
		printf "$currentDate ${currentTime}," >> ${reportPath}.csv

		assignment=${homeDir}/turnin/*1.ipynb
		printf "${assignment}," >> ${reportPath}.csv
		printf "false,,,\n" >> ${reportPath}.csv

		cp $assignment turnin/${folderName}
	else
		echo ${student}: !!!=== NOT TURNED IN ===!!! >> ${reportPath}.txt
		printf ",true,,,\n" >> ${reportPath}.csv
	fi
done

#vim $reportPath
