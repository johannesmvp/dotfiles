#!/bin/bash

# change to the current directory
REPOSITORY="$( dirname "${BASH_SOURCE[0]}" )"
# VARIABLES
## Source folders
BASE=$REPOSITORY/homedir
BASE_SSH=$REPOSITORY/ssh
BASE_GPG=$REPOSITORY/gpg

## Destination folders
TARGET=~
TARGET_SSH=$TARGET/.ssh
TARGET_GPG=$TARGET/.gnupg

## Application parameters
RSYNC='rsync --backup --itemize-changes --checksum --recursive'

# COPY FILES
echo "Copying dotfiles.."

## Check source permissions
for i in "$BASE" "$BASE_SSH" "$BASE_GPG" ; do
	if [ ! -d $i ] && [ ! -r $i ] ; then
		echo "error: check source permissions ($i)"
		exit 2
	fi
done


## Homedir files
### Check permissions
if [ ! -d "$TARGET" ] || [ ! -w "$TARGET" ] ; then
	echo "error: check destination permissions ($TARGET)"
	exit 3
fi
### Copy
$RSYNC "$BASE/" "$TARGET/"

# Check/migrate for .profile_local
if [ -r "$TARGET/.profile_local" ] && [ ! -r "$TARGET/.bash_profile_local" ] ;  then
    $RSYNC "$TARGET/.profile_local" "$TARGET/.bash_profile_local"
fi

### Append _local
#### -> .gitconfig
if [ -r "$TARGET/.gitconfig_local" ] ; then
	echo "$TARGET/.gitconfig_local >> $TARGET/.gitconfig"
	cat "$TARGET/.gitconfig_local" >> "$TARGET/.gitconfig"
fi
#### -> .gitignore_global
if [ -r "$TARGET/.gitignore_global_local" ] ; then
	echo "$TARGET/.gitignore_global_local >> $TARGET/.gitignore_global"
	cat "$TARGET/.gitignore_global_local" >> "$TARGET/.gitignore_global"
fi
#### -> .vim
if [ -r "$TARGET/.vimrc_local" ] ; then
	echo "$TARGET/.vimrc_local >> $TARGET/.vimrc"
	cat "$TARGET/.vimrc_local" >> "$TARGET/.vimrc"
fi

## SSH / authorized keys
### Check target permissions
if [ ! -d "$TARGET_SSH" ] || [ ! -w "$TARGET_SSH" ] ; then
	mkdir -p "$TARGET_SSH" >/dev/null 2>&1
	if [ ! -d "$TARGET_SSH" ] || [ ! -w "$TARGET_SSH" ] ; then
		echo "error: check destination permissions ($TARGET_SSH)"
		exit 3
	fi
fi

### Copy files
$RSYNC "$BASE_SSH/" "$TARGET_SSH/"

#### _local authorized_keys
if [ -r "$TARGET_SSH/authorized_keys_local" ] ; then
	echo "$TARGET_SSH/authorized_keys_local >> $TARGET_SSH/authorized_keys"
	cat "$TARGET_SSH/authorized_keys_local" >> "$TARGET_SSH/authorized_keys"
fi

## GPG
### Check target permissions

if [ ! -d "$TARGET_GPG" ] || [ ! -w "$TARGET_GPG" ] ; then
	mkdir -p "$TARGET_GPG" >/dev/null 2>&1
	if [ ! -d "$TARGET_GPG" ] || [ ! -w "$TARGET_GPG" ] ; then
		echo "error: check destination permissions ($TARGET_GPG)"
		exit 3
	fi
fi

### Copy files
$RSYNC "$BASE_GPG/" "$TARGET_GPG/"

### _local gpg.conf
if [ -r "$TARGET_GPG/gpg.conf_local" ] ; then
	echo "$TARGET_GPG/gpg.conf_local >> $TARGET_GPG/gpg.conf"
	cat "$TARGET_GPG/gpg.conf_local" >> "$TARGET_GPG/gpg.conf"
fi


# That's it!
echo "Done!"
