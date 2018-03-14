function workon() {
  cd -P ~/.workon_projects/$1
}

function startworkon() {
  mkdir -p ~/.workon_projects/
  ln -s $2 ~/.workon_projects/$1
}

function stopworkon() {
  rm ~/.workon_projects/$1
}
