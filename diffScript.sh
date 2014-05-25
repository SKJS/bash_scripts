#!/bin/bash
# This script compares two files(1st and 2nd args -- required) and write down difference into two output files which are created in current or certain (3rd arg) directory
if [ "$#" = "1" -o "$#" = "0" ];
	then echo "missing arg";
	exit 1;
fi;
# if one or both of files don't exist
if ! [ -f $1 ]; then 
	echo "File $1 not found";
	exit 2;
fi;
if ! [ -f $2 ]; then 
	echo "File $2 not found";
	exit 2;
fi;

diff $1 $2 > result.txt;

#if both of files have not the same content
if [ -s result.txt ]; then
	if [ "$#" = "3" ]; then
		if ! [ -d $3 ]; then 
			echo "$3 No such directory";
			exit 2;
		fi;
		cat result.txt | grep ^'<' | sed s/^"< "// > $3/delete.txt;
		cat result.txt | grep ^'>' | sed s/^"> "// > $3/add.txt;
	else 
		cat result.txt | grep ^'<' | sed s/^"< "// > delete.txt;
		cat result.txt | grep ^'>' | sed s/^"> "// > add.txt;
	fi;
fi;

rm result.txt;
exit 0;
