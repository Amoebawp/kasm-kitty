# Kasm-kitty

(Slightly riced) Kitty image to work for Kasm Workspaces.


# Installation


Clone an existing workspace and change the configuration for the following :

- Friendly Name : 

  `Kitty`
  
- Description :

  `Kitty is a fast, featureful, GPU based terminal emulator.`
  
- Thumbnail URL :

  `https://sw.kovidgoyal.net/kitty/_static/kitty.svg`
  
- Docker Image :

  `savati/kasm-kitty:latest`
  
- Docker Registry :

  `https://index.docker.io/v1/`
 
 
 
Change the other settings to suit your needs.



# Kitty Help

```
┌─ ● Kitty ───────────────────────────────────────
└──┬─  New window     ➔  ctrl + enter      
   ├─  Move focus     ➔  ctrl + arrows
   ├─  Close window   ➔  ctrl + shift + X
   ├─  Cycle layouts  ➔  ctrl + shift + L
   ├─  Resize window  ➔  ctrl + shift + R
   ├─  Move window    ➔  ctrl + shift + Arrows    
   └─  Font Size      ➔  ctrl + shift + num.+/-
 ```

# Layouts

Default window layout is **Tall** - master & stack.

You can switch the layout to **Fat**, which will work the same way.


The third available layout is **Splits**.

In this mod, you can dictate where a new window will be opened.

  - To split the selected window vertically press `ctrl + v`

  - To split the selected window horizontally press `ctrl + h`

 
# Custom aliases -bash

```
alias cd..='cd ..'
alias pdw='pwd'
alias df='df -h'
alias ..='cd ..'
alias c='clear'
alias rel='source ~/.bashrc'

alias kconf='vim ~/.config/kitty/kitty.conf'
alias matrix='cmatrix'
alias clock='tty-clock -c -f ""'

#list
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alFh'
alias l='ls'
alias l.="ls -A | egrep '^\.'"
```
