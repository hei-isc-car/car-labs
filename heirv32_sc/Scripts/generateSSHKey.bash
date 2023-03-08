#!/bin/bash

#==============================================================================
# generates an SSH key under default user location ~/.ssh/
# and add the public key to the clipboard
#
# the email could be given when calling the script or be prompted later

email=''
filename=$(hostname)
user=$(whoami)

usage='Usage: generateSSH.bash [-e email]'

# handle options
while getopts 'e:v' flag; do
  case "${flag}" in
    e) email=${OPTARG};;
  esac
done

# if the mail is not given, prompt it
if [ -z "$email" ]
then
      echo -n "Please enter your mail: "
      read email
fi
# generates the key-couple
# cat /dev/zero create an empty file to be filled by the key
# then ssh-keygen is called with:
# -q to call it silently (no verbose)
# -N with empty string to set no-password
# -t to specify the type of key
# -C to set the user mail
cat /dev/zero | ssh-keygen -q -N "" -t ed25519 -C "${user}@${filename}" -f ~/.ssh/$filename

# then copy the public key into the clipboard
clip < ~/.ssh/${filename}.pub

# print output for user
echo -e "\nThe keyfiles are generated under ~/.ssh/"
echo -e "\nThe public key is in your clipboard, ready to be added to your Github account."