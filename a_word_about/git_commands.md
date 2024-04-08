# Some Git commands

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



  #
[Back to main README](../README.md#a-word-about)