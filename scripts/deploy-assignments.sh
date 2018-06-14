#!/bin/bash

roster=$(cat roster.txt)
homeReg='\/.*[0-9]'

cat roster.txt | while read student
do
	homeDir=$(getent passwd $student | grep -o $homeReg <<< $(getent passwd $student))
	#echo $homeDir
	cp ${1} ${homeDir}/assignments
done

cat roster.txt | while read student
do
	homeDir=$(getent passwd $student | grep -o $homeReg <<< $(getent passwd $student))
	#echo $homeDir
	#echo $student
	chmod go+rx ${homeDir}/assignments/*
done
