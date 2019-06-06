#       ____  ___  __  ______
#      / __ \/ _ \/ / / / __/
#     / /_/ / ___/ /_/ /\ \
#     \____/_/   \____/___/
# ==================================================================
#   Lightly simple utility to jump between projects from anywhere.
#   No more cd ../../../../ nonsense!
# ==================================================================
_OPUS_DEFAULT_PROJECT_FOLDER=~/.opus_projects/
_OPUS_INTERNAL_PROJECTS_FOLDER=${FOLDER_FOR_OPUS:-$_OPUS_DEFAULT_PROJECT_FOLDER}

function opus() {
  if [ ${#1} -le 1 ]; then
    _OPUS_INTERNAL_ACTION="help"
  else
    _OPUS_INTERNAL_ACTION="work"
    _OPUS_INTERNAL_PROJECT=$1
  fi

  while getopts ":c:d:h" opt; do
    case $opt in
      c)
        _OPUS_INTERNAL_ACTION="create"
        _OPUS_INTERNAL_PROJECT=$2
        _OPUS_INTERNAL_PROJECT_PATH=$3
        break
        ;;
      d)
        _OPUS_INTERNAL_ACTION="delete"
        _OPUS_INTERNAL_PROJECT=$2
        break
        ;;
      h)
        _OPUS_INTERNAL_ACTION="help"
        break
        ;;
    esac
  done
  case $_OPUS_INTERNAL_ACTION in
    work)
      cd -P $_OPUS_INTERNAL_PROJECTS_FOLDER/$_OPUS_INTERNAL_PROJECT
      ;;
    create)
      mkdir -p $_OPUS_INTERNAL_PROJECTS_FOLDER/
      ln -s $_OPUS_INTERNAL_PROJECT_PATH $_OPUS_INTERNAL_PROJECTS_FOLDER/$_OPUS_INTERNAL_PROJECT
      ;;
    delete)
      rm $_OPUS_INTERNAL_PROJECTS_FOLDER/$_OPUS_INTERNAL_PROJECT
      ;;
    help)
      _opus_help
      ;;
  esac
}

function _opus_help() {
  _seperator="=================================================================="
  echo -e "      ____  ___  __  ______\n     / __ \/ _ \/ / / / __/\n    / /_/ / ___/ /_/ /\ \  \n    \____/_/   \____/___/"
  echo $_seperator
  echo -e "  Lightly simple utility to jump between projects from anywhere.\n  No more cd ../../../../ nonsense!"
  echo -e "$_seperator\n"
  echo -e "START A PROJECT\n$ opus -c project_name /path/to/project\n"
  echo -e "WORK ON A PROJECT\n$ opus project_name\n"
  echo -e "REMOVE A PROJECT\n$ opus -d project_name\n"
}

_opus() {
  _arguments '1: :($(ls -1 $_OPUS_INTERNAL_PROJECTS_FOLDER))'
}

compdef _opus opus