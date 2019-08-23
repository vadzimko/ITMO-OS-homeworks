#!/bin/bash

curr_dir=$PWD
backup_dir="$curr_dir/"$(ls $curr_dir | grep -o -E "^Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}$" | tail -n 1)
dest_dir="$curr_dir/restore"

if ! [[ -d $backup_dir ]]; then
    exit 0
fi

if [[ -d $dest_dir ]]; then
    rm -r $dest_dir
fi
mkdir $dest_dir

for file in $(ls $backup_dir); do
    if echo $file | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}$"; then
        continue
    fi
    cp "$backup_dir/$file" $dest_dir
done