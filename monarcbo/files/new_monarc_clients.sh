#!/bin/sh

spool_dir="/var/spool/monarc/created"

if [ "$(ls -A $spool_dir)" ] ; then
	for file in "$spool_dir"/* ; do
		cat "$file"
		mv "$file" /var/tmp/monarc/created/
	done
fi
