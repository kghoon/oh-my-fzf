# fuzzy grep open via ag with line number
Ag() {
  local file
  local line

  read -r file line <<<"$(ag --ignore-dir node_modules --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}
