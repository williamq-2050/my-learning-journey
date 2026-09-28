# Some Git commands

## Set up and use a second SSH key for this GitHub account.
  - Generate the key
  ```
  GIT_EMAIL=$(git config user.email)
  ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519_github_personal
  ```

  - Copy the text below and add it to your GitHub SSH Settings
  ```
  cat ~/.ssh/id_ed25519_github_personal.pub
  ``` 

  - Add the new key to your SSH Agent
  ```
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519_github_personal
  ```

## To use the same config for all your repos
  - List global config
  ```
  git config --global --list 
  ```
  - Config is saved to ~/.gitconfig 
  ```
  cat ~/.gitconfig 
  ```
  - Set global user email and name
  ```
  git config --global user.email "<your email here>"
  git config --global user.name "Your name here"  
  ```

## Configure user email and name for a repo, other than the global
  - List local config
  ```
  git config --local --list
  ```
  - Config is saved to .git/config
  ```
  cat .git/config 
  ```
  - Set local user email and name
  ```
  cd <this_repo>
  git config user.email "<your email here>"
  git config user.name "Your name here"  
  ```
  - To remove a variable from config
  ```
  git config --unset user.name
  git config --unset user.email
  ```

## Using Bare repos
  - Clone
  ```
  git clone --no-checkout source target
  ``` 
  - Refresh bare repo
  ```
  git fetch -p
  ```
  - List latest changes
  ```
  git log --oneline --all --graph
  ```
  - Create/force a branch to latest change
  ```
  git branch mylatest <checksum from log> -f

  ```
  - [Move HEAD](https://feeding.cloud.geek.nz/posts/setting-default-git-branch-in-bare/)
  ```
  git branch nn_master origin/master
  git branch -v
  git symbolic-ref HEAD refs/heads/nn_master
  git branch master origin/master -f
  git symbolic-ref HEAD refs/heads/master
  git branch -d nn_master

  git log --oneline --all --graph
  ```



  #
[Back to main README](../README.md#a-word-about)