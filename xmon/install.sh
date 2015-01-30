#!/bin/bash

if [[ $1 == "" ]]
then
	echo "Wrong params"
else
	echo "making directory"
	mkdir -p $1

	echo "Copying files"
	cp -rv * $1/
        
	echo "Settting up install variables"
	mkdir -p /var/xmon
        echo $1 > /var/xmon/install_dir

	echo "Deleting install files"
	rm -fv $1/install.sh
	rm -fv $1/*.tar.bz2
fi


