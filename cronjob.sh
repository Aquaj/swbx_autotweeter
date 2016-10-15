#!/bin/bash

if [ $1 -ge 60 ];
then
	printf "Please, input a smaller interval [0-60]\n";
else
	crontab -l > mycron

	printf "*/$1 * * * * bash /home/aquaj/Code/autoscreentweet/promptinput.sh\n" >> mycron

	crontab mycron
	rm mycron
fi
