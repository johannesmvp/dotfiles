# johannesmvp/dotfiles

## v0.2
- An install script has been added (~~``Makefile``~~ ``bootstrap.sh``). Default paths are ``homedir``, ``ssh``, ``gpg`` (source) and ``~``, ``~/.ssh``, ``~/.gnupg`` (destination). Files are copied from ``$source/`` to ``$destination/`` using ``rsync``.
- For some files, local settings can be stored in ``[filename]_local``, like ``~/.gitconfig_local``. The install script appends ``[filename]_local`` to ``[filename]``. **Warning**: the contents are barely checked before appending! **Make backups!**
- ``README.md`` and ``changelog.md``

## v0.1
- Initial release
