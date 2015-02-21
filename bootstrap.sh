#!/bin/sh

# Folder containing the files
BASE=files
TARGET=~

#help:
#echo "Usage: make (item|diff)"
#echo " where (item): all, profile, git, vim, gpg, ssh"
#echo "       (diff): show changes"
#echo
#echo "Appending _local to certain files in $TARGET will have"
#echo "them appended to the dotfiles."


#profile:
echo
echo "PROFILE:"
cp --backup=numbered --verbose $BASE/.profile $TARGET/.profile
cp --backup=numbered --verbose $BASE/.bash_prompt $TARGET/.bash_prompt
cp --backup=numbered --verbose $BASE/.aliases $TARGET/.bash_aliases

#git:
echo
echo "GIT:"

# .gitconfig
cp --backup=numbered --verbose $BASE/.gitconfig $TARGET/.gitconfig

if [ -r $TARGET/.gitconfig_local ] ; then
	echo "cat $TARGET/.gitconfig_local >> $TARGET/.gitconfig"
	cat $TARGET/.gitconfig_local >> $TARGET/.gitconfig
else
 	echo "$TARGET/.gitconfig_local not found"
fi

# .gitignore_global
cp --backup=numbered --verbose $BASE/.gitignore_global $TARGET/.gitignore_global

if [ -r $TARGET/.gitignore_global_local ] ; then
	echo "cat $TARGET/.gitignore_global_local >> $TARGET/.gitignore_global"
	cat $TARGET/.gitignore_global_local >> $TARGET/.gitignore_global
else
	echo "$TARGET/.gitignore_global_local not found"
fi

#vim:
echo
echo "VIM:"
cp --backup=numbered --verbose $BASE/.vimrc $TARGET/.vimrc

if [ -r $TARGET/.vimrc_local ] ; then
	echo "cat $TARGET/.vimrc_local >> $TARGET/.vimrc"
	cat $TARGET/.vimrc_local >> $TARGET/.vimrc
else
 	echo "$TARGET/.vimrc_local not found"
fi

#gpg:
echo
echo "GPG:"
mkdir -p $TARGET/.gnupg && \
cp --backup=numbered --verbose $BASE/gpg.conf $TARGET/.gnupg/gpg.conf

if [ -r $TARGET/.gnupg/gpg.conf_local ] ; then
	echo "cat $TARGET/.gnupg/gpg.conf_local >> $TARGET/.gnupg/gpg.conf"
	cat $TARGET/.gnupg/gpg.conf_local >> $TARGET/.gnupg/gpg.conf
else
	echo "$TARGET/.gnupg/gpg.conf_local not found"
fi

#ssh:
echo
echo "SSH:"
mkdir -p $TARGET/.ssh && \
cp --backup=numbered --verbose $BASE/authorized_keys $TARGET/.ssh/authorized_keys

if [ -r $TARGET/.ssh/authorized_keys_local ] ; then
	echo "cat $TARGET/.ssh/authorized_keys_local >> $TARGET/.ssh/authorized_keys"
	cat $TARGET/.ssh/authorized_keys_local >> $TARGET/.ssh/authorized_keys
else
 	echo "$TARGET/.ssh/authorized_keys_local not found"
fi

#diff:
echo
echo "DIFF:"
#diff -qs --new-file $BASE/.profile $TARGET/.profile
#diff -qs --new-file $BASE/.bash_prompt $TARGET/.bash_prompt
#diff -qs --new-file $BASE/.aliases $TARGET/.bash_aliases	

#diff -qs --new-file $BASE/.gitconfig $TARGET/.gitconfig
#diff -qs --new-file $BASE/.gitignore_global $TARGET/.gitignore_global

#diff -qs --new-file $BASE/.vimrc $TARGET/.vimrc

#diff -qs --new-file $BASE/gpg.conf $TARGET/.gnupg/gpg.conf

#diff -qs --new-file $BASE/authorized_keys $TARGET/.ssh/authorized_keys
