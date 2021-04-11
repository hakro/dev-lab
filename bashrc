parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;32m\] @ \[\033[01;31m\]DevLab\[\033[00m\]: \[\033[01;32m\]\w\[\033[00m\]\$\n\[\033[33m\]\$(parse_git_branch)\[\033[00m\]-> "
