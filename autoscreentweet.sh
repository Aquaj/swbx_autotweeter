#!/bin/bash

while true; do
	cancel=false;

	while true; do
	    read -p "Ready for a picture ? `echo $'\n'`Enter a tweet (blank to cancel) :`echo $'\n> '`" tweet_content
	    if [ "$tweet_content" == "" ];
	    then
	    	cancel=true; 
	    	break 2;
	    fi
	    if [ ${#tweet_content} -le 108 ];
	    then
	    	printf "Current tweet is:\n\"$tweet_content cc @LorenzoCroati @FrenchTechBx\"\n";
	    else
	    	printf "Message too long ! Careful bro.\n"
	    	continue;
	    fi
	    read -p "Ready to tweet that ? [Yn]`echo $'\n '`" answer
	    case $answer in
	    	[yY][eE][sS]|[yY])
					break
					;;
	    	*)
					continue
					;;
	    esac
	done

	if ! $cancel;
	then
		while true; do
			file_path="/home/aquaj/Pictures/SWBX/SWBX_$(date +"%T")";

			printf "file: $file_path\n";

			fswebcam -d /dev/video1 -r 1920x1080 --jpeg 85 -F 5 $file_path;

			/usr/bin/eom $file_path && read -p "Publish that? [Yn] " publish
			case $publish in
	    	[yY][eE][sS]|[yY])
					/home/aquaj/.rbenv/shims/t update "$tweet_content cc @LorenzoCroati @FrenchTechBx" -f $file_path;
					break 2;
					;;
				[sS][tT][oO][pP]|[sS])
					break 2;
					;;
	    	*)
					;;
		  esac
		done
	fi
done

printf 'Everything done & okay here ! See you round !'

sleep 3s
