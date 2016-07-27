oh-my-fzf
=========

Provide convinient way to install [fuzzy-finder](https://github.com/junegunn/fzf.git)
and to setup related settings.

Requirements
------------
- OS - OSX and Ubuntu >= 12.04, CentOS7
- Shell - bash (zsh not supported yet)

Install
-------

```
$ git clone --depth 1 https://github.com/kghoon/oh-my-fzf.git ~/.oh-my-fzf
$ ~/.oh-my-fzf/install
```

Bash - Commands
---------------
- fe - Open the selected file with default editor
- fo - Open the selected file with open command or ```$EDITOR```
- fd - cd to selected directory
- fda - ```fd``` including hidden directory
- fdr -  cd to  selected parent directory
- cdf - cd into the directory of the selected file
- to - bookmark current directory with keyword
- Ag - Seach contents using silver searcher and open the file 


Vim - Commands and shortcuts
----------------------------
- Tags - Move to selected tag
- Ag ```\ + g``` - Search contents using ag and move to selected line.
- ```\ + r``` - Open recently used file list and open selected file.


License
-------
- MIT

