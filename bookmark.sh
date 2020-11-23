#!/bin/sh
# Add a new ip address to the whitelist

PWD=`pwd`

# Ask the user what they want the bookmark to be named.
printf "\n\n"
read -p "What would you like to name this Environment Variable? (\"exit\" to quit): " BOOKMARK

if [[ $BOOKMARK == "exit" ]]; then
	printf "\nExiting. Goodbye...\n\n"
	exit
fi


# Confirm the user wants to create the bookmark.
read -p "Are you sure you want to create \"$BOOKMARK\"? (y/n): " ANSWER

if [[ $ANSWER != [yY] && $ANSWER != [yY][eE][sS] ]]; then						
	printf "\nNever mind then. Exiting...\n\n\n"
else
	printf "\n\nCreating an environment variable for \"$BOOKMARK\" in \"$HOME/.bashrc\"...\n\n"

	printf "\nexport $BOOKMARK=\"$PWD\"\n" >> $HOME/.bashrc || exiting 666

	printf "Success!\n"
	printf "Please run the following command in your console to make your bookmark accessible:\n\n"
	printf "source $HOME/.bashrc\n\n\n"					
fi


# Exit the script with the error code given by the first argument.
exiting()
{
    errorCode=$1
	printf "\nSorry, something went awry...\nExiting"
	for (( i=1; i<=3; i++ ))
	do  
		printf "." 
		sleep 1 
	done
	printf "\n\n"
	exit $errorCode
}
