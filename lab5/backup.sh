#!/bin/bash

throw_error() {
    echo "An error occurred: $1"
    exit 1
}

date_diff_days() { 
    d1=$(gdate -d "$1" +%s)
    d2=$(gdate -d "$2" +%s)
    echo $(( (d1 - d2) / 86400 ))
}

if [[ -n $1 ]]; then
    throw_error "Unexpected argument"
fi

curr_dir=$PWD
src_dir="$curr_dir/source"
log="$curr_dir/backup-report.txt"

prefix="Backup"
old_directory=$(ls $curr_dir | grep -E "^$prefix-[0-9]{4}-[0-9]{2}-[0-9]{2}$" | cut -d '-' -f 2-4 | head -n 1)
now=$(date +"%Y-%m-%d")

if ! [[ -z "$old_directory" ]]; then
	days_diff=$(date_diff_days $now $old_directory)
fi

dest_dir="$curr_dir/$prefix-$old_directory"
if [[ -z "$old_directory" || "$days_diff" -ge 7 ]]; then
	dest_dir="$curr_dir/$prefix-$now"
	mkdir $dest_dir || throw_error "Unable to create $dest_dir"
	echo "New backup directory has been created \"$prefix-$now\"" >> $log
fi

for file in $(ls $src_dir); do
    if [[ -d "$src_dir/$file" ]]; then
        continue
    fi

    src_file="$src_dir/$file"
	dest_file="$dest_dir/$file"
	if ! [[ -f $dest_file ]]; then
	    cp $src_file $dest_dir
		echo "$src_file" >> $log
	else
		first=$(wc -c < "$dest_file" )
		second=$(wc -c < "$src_file")
		if [[ $first -eq $second ]]; then
			continue
		fi
		mv $dest_file "$dest_file.$now"
		cp $src_file $dest_dir
		echo "New version of file $file found. Previous version has been renamed to $file.$now" >> $log
	fi
done

