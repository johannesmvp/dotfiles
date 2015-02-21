#!/bin/sh

# Folder containing the files
BASE="homedir"
BASE_SSH="ssh"
BASE_GPG="gpg"

TARGET="~"
TARGET_SSH="~/.ssh"
TARGET_GPG="~/.gnupg"

RSYNC='rsync --backup --update --itemize-changes --checksum'

echo "Copying dotfiles.."

#profile:
$RSYNC $BASE/.profile $TARGET/.profile
$RSYNC $BASE/.bash_prompt $TARGET/.bash_prompt
$RSYNC $BASE/.bash_aliases $TARGET/.bash_aliases

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
mkdir -p $TARGET_GPG && \
$RSYNC $BASE_GPG/gpg.conf $TARGET_GPG/gpg.conf

if [ -r $TARGET_GPG/gpg.conf_local ] ; then
	echo "cat $TARGET_GPG/gpg.conf_local >> $TARGET_GPG/gpg.conf"
	cat $TARGET_GPG/gpg.conf_local >> $TARGET_GPG/gpg.conf
fi

#ssh:
mkdir -p $TARGET_SSH && \
$RSYNC $BASE_SSH/authorized_keys $TARGET_SSH/authorized_keys

if [ -r $TARGET_SSH/authorized_keys_local ] ; then
	echo "cat $TARGET_SSH/authorized_keys_local >> $TARGET_SSH/authorized_keys"
	cat $TARGET_SSH/authorized_keys_local >> $TARGET_SSH/authorized_keys
fi

echo "Done!"
