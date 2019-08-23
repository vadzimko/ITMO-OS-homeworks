#!/bin/bash

throw_error() {
    echo "An error occurred: $1"
    exit 1
}

if [[ -z $1 ]]; then
    throw_error "First argument should be filename"
fi

file="$1"
trash_dir="$HOME/.trash"
log="$HOME/.trash.log"

if ! [[ -d $trash_dir ]]; then
	mkdir $trash_dir
fi

if ! [[ -f $log ]]; then
    exit 0
fi

untrash() {
    if ! [[ -d $trash_dir ]]; then
        throw_error "Trash directory does not exist"
    fi

    local dest=$1
	local link=$2

    src="$trash_dir/$link"
    if ! [[ -f $src ]]; then
        throw_error "Trash directory has been changed"
    fi

    if [[ -d $dest ]]; then
        throw_error "Unable to restore file, there is directory with such name"
    fi

	if ! [[ -d $(dirname $dest) ]]; then
		dest=$HOME
		echo "Restoring to $dest..."
	fi

	ln $src $dest 2>/dev/null || throw_error "Problems with source directory (file has been already restored?)"
	rm -f $src
	sed -in "/$2/d" $log
}

IFS=$(echo -en "\n")
for line in $(grep $file $log); do
    file=$(echo $line | awk -F " : " '{print $1}')
    link=$(echo $line | awk -F " : " '{print $2}')
    while true; do
        echo "Untrash file $file? (y/n)"
		read -n 1 -s answer; echo
		if [[ $answer == 'y' ]]; then
			untrash $file $link
			break
		elif [[ $answer == 'n' ]]; then
			break
		else
			echo "Please use y or n"
		fi
	done
done