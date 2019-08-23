#!/bin/bash

throw_error() { 
    echo "An error occurred: $1"
    exit 1
}

file="$PWD/$1"
trash_dir="$HOME/.trash"
log="$HOME/.trash.log"

get_link_name() { 
	date=$(date +%F_%T)
	rand=$(cat /dev/random | LC_CTYPE=C tr -dc "[a-zA-Z0-9]" | head -c 8)
	name="trash_"$date"_"$rand
	echo $name
}


if ! [[ -f $file ]]; then
    throw_error "There is no such file"
fi

if ! [[ -d $trash_dir ]]; then
	mkdir $trash_dir
fi
get_link_name
link_name=$(get_link_name)
ln $file "$trash_dir/$link_name" && rm -f $file || throw_error "Unable to delete file"
echo "$file : $link_name" >> $log