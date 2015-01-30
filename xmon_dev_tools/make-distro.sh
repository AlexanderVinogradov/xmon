#!/bin/bash

path=$1
version=$2

if [[ $1 == "" || $2 == "" ]]
then
	echo "Wrong params"
else
	echo "Stoping daemons on this machine"
	$path/sbin/xmon-ctl stop-service

	echo "Clearing logs"
	rm -fv $path/log/*

	echo "Making temp dir"
	mkdir -p /tmp/xmon_compilation_temp_dir
	mkdir -p /tmp/xmon_compilation_temp_dir/$version

	echo "Copying files"
	cp -rv $path/* /tmp/xmon_compilation_temp_dir/$version/

	echo "Making version file"
	echo $version > /tmp/xmon_compilation_temp_dir/$version/version

	echo "Preparing files"
	mv /tmp/xmon_compilation_temp_dir/$version/bin/xmonad /tmp/xmon_compilation_temp_dir/$version/bin/xmonad.pl
	mv /tmp/xmon_compilation_temp_dir/$version/bin/xmonmd /tmp/xmon_compilation_temp_dir/$version/bin/xmonmd.pl
	mv /tmp/xmon_compilation_temp_dir/$version/bin/xmonsd /tmp/xmon_compilation_temp_dir/$version/bin/xmonsd.pl
	mv /tmp/xmon_compilation_temp_dir/$version/sbin/xmon-ctl /tmp/xmon_compilation_temp_dir/$version/sbin/xmon-ctl.pl

	echo "Compiling files"
	cd /tmp/xmon_compilation_temp_dir/$version/bin
	echo "Compiling xmonad"
	perlcc -B -o xmonad xmonad.pl
	echo "Compiling xmonmd"
	perlcc -B -o xmonmd xmonmd.pl
	echo "Compiling xmonsd"
	perlcc -B -o xmonsd xmonsd.pl
	cd /tmp/xmon_compilation_temp_dir/$version/sbin
	echo "Compiling xmon-ctl"
	perlcc -B -o xmon-ctl xmon-ctl.pl
	cd /
	
	echo "Removing source files"
	rm -fv /tmp/xmon_compilation_temp_dir/$version/bin/xmonad.pl
	rm -fv /tmp/xmon_compilation_temp_dir/$version/bin/xmonmd.pl
	rm -fv /tmp/xmon_compilation_temp_dir/$version/bin/xmonsd.pl
	rm -fv /tmp/xmon_compilation_temp_dir/$version/sbin/xmon-ctl.pl

	echo "Compressing files"
	cd /tmp/xmon_compilation_temp_dir/$version
	tar cvjpf /tmp/xmon_compilation_temp_dir/xmon-core-$version.tar.bz2 *

	echo "Removing temp dir"
	cd /
	rm -rfv tmp/xmon_compilation_temp_dir/$version
fi

