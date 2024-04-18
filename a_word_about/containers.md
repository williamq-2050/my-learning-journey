# Containers
[Docker Desktop](https://docs.docker.com/desktop/) is the go-to container management tool for developers, but there are already free and open-source options, here some of them:
  - Docker Desktop is free for personal use, see [pricing](https://www.docker.com/pricing/)
  - [Docker Engine](#docker-engine-on-ubuntu)
  - [Docker Engine + VSCode with Docker extension](#docker-engine-on-ubuntu--vscode)
  - [Podman](#podman-on-ubuntu)
  - [Rancher Desktop](#podman-on-ubuntu)


## Docker Engine on Ubuntu
  - Install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/), it is open source under the [Apache License, Version 2.0](https://docs.docker.com/engine/#licensing)
  - Uninstall all conflicting packages
    ```
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
    ```
  - Set up Docker's apt repository
    ```
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```
  - Install
    ```
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin    
    ```   
  - Uninstall
    ```
    sudo apt remove --autoremove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo rm /etc/apt/sources.list.d/docker.list
    sudo rm /etc/apt/keyrings/docker.asc
    sudo apt update    
    ```

## Docker Engine on Ubuntu + VSCode
  - Install VSCode + Docker extension (ms-azuretools.vscode-docker)
  - Install [Docker Engine](#docker-engine-on-ubuntu)

## Podman on Ubuntu
  - https://podman.io/docs/installation#ubuntu
  - The podman package is available in the official repositories
  - Install
    ```
    sudo apt-get update
    sudo apt-get -y install podman
    ```
  - Uninstall
    ```
    sudo apt remove --autoremove podman
    sudo apt-get update
    ```

## Rancher Desktop on Ubuntu
  - https://docs.rancherdesktop.io/getting-started/installation/#installation-via-deb-package
  - Set up Rancher's apt repository
    ```
    curl -s https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/Release.key | gpg --dearmor | sudo dd status=none of=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg
    echo 'deb [signed-by=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg] https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ ./' | sudo dd status=none of=/etc/apt/sources.list.d/isv-rancher-stable.list
    ```
  - Install 
    ```
    sudo apt update
    sudo apt install rancher-desktop
    ```
  - Uninstall  
    ```
    sudo apt remove --autoremove rancher-desktop
    sudo rm /etc/apt/sources.list.d/isv-rancher-stable.list
    sudo rm /usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg
    sudo apt update    
    ```

#
[Back to main README](../README.md#a-word-about)