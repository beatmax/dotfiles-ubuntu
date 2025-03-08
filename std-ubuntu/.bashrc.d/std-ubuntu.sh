if [ -f ~/local/shell/git-prompt.sh ]; then
  . ~/local/shell/git-prompt.sh
  if ${use_color}; then
    PS1=${PS1/\\$/\$(__git_ps1 \" (\\[\\033[00;37m\\]%s\\[\\033[00m\\])\")\\$}
  else
    PS1=${PS1/\\$/\$(__git_ps1 \" (%s)\")\\$}
  fi
fi

__ps1_jobs() { (( $1 )) && echo "[$1 jobs] "; }
PS1+='$(__ps1_jobs \j)'

if [ -f ~/local/shell/quitcd.bash_sh_zsh ]; then
 . ~/local/shell/quitcd.bash_sh_zsh
fi
