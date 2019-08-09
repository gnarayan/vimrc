## Colorize the ls output ##
alias ls='ls -G'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias bc='bc -l'
alias mount='mount |column -t'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

## this one saved by butt so many times ##
alias wget='wget -c'

## set some other defaults ##
alias df='df -H'
alias du='du -ch'
