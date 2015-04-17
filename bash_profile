export PS1="\u\w$ "
alias ls="ls -G"
alias ll="ls -lahG"
alias gs="git status "
alias tree="tree -C" # Use always color
alias grep="grep -rin --color"
alias bowerredo='rm -r bower_components && bower cache clean && bower install'

function clean_pyc {
    for i in $(find . -name '*.pyc'); do rm -f $i; done
}

function gh() {
  # Open up the github url for the branch you are on.
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     return 1
  fi

  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=$giturl$branch
  open $giturl
  echo $giturl
}

function addmod() {
  # Quickly stage all of the modified files.
  printf "Staging files\n=============\n"
  for output in $(git status | grep modified | sed 's/\(.*modified:\s*\)//')
  do
    read -p "Stage $output (y/N) " yn
    if [ "$yn" = "y" ] || [ "$yn" = "Y" ]; then
      git add $output
    fi
  done
}

function jira() {
  # Open up the jira issue url for the branch you are on.
  url="https://jira.paymentez.com/browse/"
  issue=$(git symbolic-ref HEAD 2>/dev/null | cut -d '/' -f 3 | cut -d '-' -f 1,2)

  if [ "$issue" == "" ]
    then
     echo "Dude, your branch has a weird name"
     return 1
  fi

  url=$url$issue
  open $url
  echo $url
}

function pivotal() {
  # Open up the jira issue url for the branch you are on.
  url="https://www.pivotaltracker.com/story/show/"
  issue=$(git symbolic-ref HEAD 2>/dev/null | cut -d '/' -f 3 | cut -d '-' -f1)

  if [ "$issue" == "" ]
    then
     echo "Dude, your branch has a weird name"
     return 1
  fi

  url=$url$issue
  open $url
  echo $url
}

export WORKON_HOME="$HOME/Envs"
source /usr/local/bin/virtualenvwrapper.sh