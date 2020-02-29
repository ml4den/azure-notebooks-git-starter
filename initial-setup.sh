#!/bin/bash

cd ~/library

read -p "Enter your name: " uname
read -p "Enter your email: " umail

printf "\n"

ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C $umail
echo Copy the public key to your GitHub settings:
printf '%64s\n' | tr ' ' -
cat ~/.ssh/id_rsa.pub
printf '%64s\n' | tr ' ' -
cp -R ~/.ssh ~/library/

echo "Set up a Git repository?"
PS3='Please select one of the options above: '
options=("git clone" "git init" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "git clone")
            if [ "$(ls -A ~/library)" ]; then
                 echo -e "\e[33mThe ~/library directory should be empty before cloning.\e[0m"
            else
                read -p "Enter repository HTTPS or SSH location: " repo
                git clone $repo
                echo "Configuring git for $uname and $umail..."
                git config --local user.name $uname
                git config --local user.email $umail
                printf "\n"
                git config -l
                printf "\n"
                break
            fi
            ;;
        "git init")
            printf "\n"
            git init
            echo "Configuring git for $uname and $umail..."
            git config --local user.name $uname
            git config --local user.email $umail
            printf "\n"
            git config -l
            printf "\n"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
