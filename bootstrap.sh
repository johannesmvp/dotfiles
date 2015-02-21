#!/bin/sh

# Folders containing the files
BASE="homedir"
BASE_SSH="ssh"
BASE_GPG="gpg"

TARGET="~"
TARGET_SSH="~/.ssh"
TARGET_GPG="~/.gnupg"

RSYNC='rsync --backup --update --itemize-changes --checksum --recursive'

echo "Copying dotfiles.."

$RSYNC $BASE/ $TARGET/

# .gitconfig_local
if [ -r $TARGET/.gitconfig_local ] ; then
	echo "$TARGET/.gitconfig_local >> $TARGET/.gitconfig"
	cat $TARGET/.gitconfig_local >> $TARGET/.gitconfig
fi

# .gitignore_global_local
if [ -r $TARGET/.gitignore_global_local ] ; then
	echo "cat $TARGET/.gitignore_global_local >> $TARGET/.gitignore_global"
	cat $TARGET/.gitignore_global_local >> $TARGET/.gitignore_global
fi

#vim_local
if [ -r $TARGET/.vimrc_local ] ; then
	echo "cat $TARGET/.vimrc_local >> $TARGET/.vimrc"
	cat $TARGET/.vimrc_local >> $TARGET/.vimrc
fi


#ssh
mkdir -p $TARGET_SSH || exit 1

$RSYNC $BASE_SSH/ $TARGET_SSH/ 

if [ -r $TARGET_SSH/authorized_keys_local ] ; then
	echo "cat $TARGET_SSH/authorized_keys_local >> $TARGET_SSH/authorized_keys"
	cat $TARGET_SSH/authorized_keys_local >> $TARGET_SSH/authorized_keys
fi


#gpg
mkdir -p $TARGET_GPG || exit 2

$RSYNC $BASE_GPG/ $TARGET_GPG/

if [ -r $TARGET_GPG/gpg.conf_local ] ; then
	echo "cat $TARGET_GPG/gpg.conf_local >> $TARGET_GPG/gpg.conf"
	cat $TARGET_GPG/gpg.conf_local >> $TARGET_GPG/gpg.conf
fi


echo "Done!"
