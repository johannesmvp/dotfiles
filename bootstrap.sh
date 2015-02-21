#!/bin/sh

# Folder containing the files
BASE=files
TARGET=~

RSYNC='rsync --backup --update --itemize-changes --checksum'

#profile:
$RSYNC $BASE/.profile $TARGET/.profile
$RSYNC $BASE/.bash_prompt $TARGET/.bash_prompt
$RSYNC $BASE/.aliases $TARGET/.bash_aliases

#git:
# .gitconfig
$RSYNC $BASE/.gitconfig $TARGET/.gitconfig

if [ -r $TARGET/.gitconfig_local ] ; then
	echo "$TARGET/.gitconfig_local >> $TARGET/.gitconfig"
	cat $TARGET/.gitconfig_local >> $TARGET/.gitconfig
fi

# .gitignore_global
$RSYNC $BASE/.gitignore_global $TARGET/.gitignore_global

if [ -r $TARGET/.gitignore_global_local ] ; then
	echo "cat $TARGET/.gitignore_global_local >> $TARGET/.gitignore_global"
	cat $TARGET/.gitignore_global_local >> $TARGET/.gitignore_global
fi

#vim:
$RSYNC $BASE/.vimrc $TARGET/.vimrc

if [ -r $TARGET/.vimrc_local ] ; then
	echo "cat $TARGET/.vimrc_local >> $TARGET/.vimrc"
	cat $TARGET/.vimrc_local >> $TARGET/.vimrc
fi

#gpg:
mkdir -p $TARGET/.gnupg && \
$RSYNC $BASE/gpg.conf $TARGET/.gnupg/gpg.conf

if [ -r $TARGET/.gnupg/gpg.conf_local ] ; then
	echo "cat $TARGET/.gnupg/gpg.conf_local >> $TARGET/.gnupg/gpg.conf"
	cat $TARGET/.gnupg/gpg.conf_local >> $TARGET/.gnupg/gpg.conf
fi

#ssh:
mkdir -p $TARGET/.ssh && \
$RSYNC $BASE/authorized_keys $TARGET/.ssh/authorized_keys

if [ -r $TARGET/.ssh/authorized_keys_local ] ; then
	echo "cat $TARGET/.ssh/authorized_keys_local >> $TARGET/.ssh/authorized_keys"
	cat $TARGET/.ssh/authorized_keys_local >> $TARGET/.ssh/authorized_keys
fi
