# Azure Notebooks Git Starter
This project makes it easy to set up a personal development environment with Git and GitHub on Azure Notebooks.

The goal of this project is to allow the developer to easily prepare Azure Notebooks for interacting with a remote repository.
## Important Notes on Security 🔒
Easily authenticating to an origin repository requires saving the keys to ``~/library/.ssh`` as only the library folder persists between sessions. Please make sure that you are working in a **private** project. You should protect your keys with a strong password when they are created.
## Getting Started
Start with a **private** Azure Notebooks project.

Open the terminal in your project and run the command below to get started:
```bash
source <(curl -s https://raw.githubusercontent.com/ml4den/azure-notebooks-git-starter/master/setup.sh)
```
## Other Notes
It is assumed that notebook projects and repositories have a one-to-one relationship. As such, this script will attempt to clone to the root of the ``~/library`` directory if the user selects the clone option.
