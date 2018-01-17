#!/bin/bash

roster=$(cat roster.txt)
homeReg='\/.*[0-9]'

cat roster.txt | while read student
do
	homeDir=$(getent passwd $student | grep -o $homeReg <<< $(getent passwd $student))
	echo "Copying assignment for ${student}"
	cp ${1} ${homeDir}/assignments

	echo "Changing file permissions for ${student}"
	echo
	chmod go+rx ${homeDir}/assignments/*
done
