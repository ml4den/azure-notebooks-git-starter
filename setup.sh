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

printf "\n"
echo "Set up a Git repository?"
PS3='Please select one of the options above: '
options=("git clone" "git init" "Skip for now")
select opt in "${options[@]}"
do
    case $opt in
        "git clone")
            if [ "$(ls -A ~/library)" ]; then
                 echo -e "\e[33mThe ~/library directory should be empty before cloning.\e[0m"
            else
                read -p "Enter repository HTTPS or SSH location: " repo
                git clone $repo .
                printf "\n"
                echo "Configuring Git for $uname and $umail..."
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
            printf "\n"
            echo "Configuring Git for $uname and $umail..."
            git config --local user.name $uname
            git config --local user.email $umail
            printf "\n"
            git config -l
            printf "\n"
            break
            ;;
        "Skip for now")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# Copy the keys to persistent storage
cp -R ~/.ssh ~/library/

# Create a startup file to be used for restoring the keys in new sessions
echo "Creating ~/library/startup.sh"
printf "cp -R ~/library/.ssh ~/\nchmod 400 ~/.ssh/id_rsa\n" > ~/library/startup.sh
echo -e "\033[32mPlease add startup.sh your environment setup to avoid using your ssh keys:\033[m"
echo -e "\033[32mAzure Notebooks -> Project Settings -> Environment -> Shell Script\033[m"

# TODO: add .ssh, startup.sh and .ipynb_checkpoints to gitignore
