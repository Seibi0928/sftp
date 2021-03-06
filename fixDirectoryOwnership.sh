#!/bin/bash
set -e

userConfFinalPath="/var/run/sftp/users.conf"

function fix_ownership_for_user() {
  IFS=':' read -a param <<< $@
  user="${param[0]}"
  pass="${param[1]}"

  # If there are any files in the dir (otherwise the chown will give error)
  if [ "$(ls -A /home/$user/)" ]; then
    shopt -s dotglob
    echo chown -R $user /home/$user/*
    chown -R $user /home/$user/*
    shopt -u dotglob
  fi
}

if [ -f "$userConfFinalPath" ]; then
  # Fix ownership of each user's home directory subdirectories every time the container is started.
  # (The home directory itself must continue to be owned by root for the chroot to work.)
  while IFS= read -r user_line || [[ -n "$user_line" ]]; do
    fix_ownership_for_user "$user_line"
  done < "$userConfFinalPath"
fi
