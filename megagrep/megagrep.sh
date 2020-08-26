#!/bin/sh
# Made by John Beckmann
# Greps ASCII, Microsoft Word & Excel, and PDF documents recursively and prints colored output of the relative file path, line number, and line for instances where the regular expression is found
# Required External Libraries
	# unoconv
	# pdfgrep 

declare -A fileTypes
fileTypes[docx]="text"
fileTypes[doc]="text"
fileTypes[xlsx]="csv"
fileTypes[xls]="csv"
		
			
# Confirm only one argument was provided 
if [ $# != 1 ]; then
	printf "\nERROR: $# arguments were specified\n"
	printf "This script accepts exactly one argument (the regular expression to be grepped)\n"
	printf "Try again...\n\n"
	exit
fi

searchKey=$1

printf "\n"
# Grep text files
grep --color=auto -rinI "$searchKey" . && \
printf "\n\n"

# Grep PDF files
pdfgrep -rin "$searchKey" . && \
printf "\n\n"

# Grep Microsoft Word & Excel documents
for ext in "${!fileTypes[@]}"
do
	find . -type f -name "*.$ext" -print0 | 
	while read -r -d '' file
	do 
		unoconv -f ${fileTypes[$ext]} --stdout "$file" | 
		grep --color=always -in "$searchKey" | 
		while read found
		do				
			if [[ $found ]];then
				# Print output
				# Add color for the file name and it's following colon to match the grep output color scheme
				#  --color=always flag in the previous grep allows piped output to keep its color formatting so we don't need to add color to $found
				printf "\e[35m$file\e[36m:$found\n"
			fi
		done
	done
done
printf "\n"
