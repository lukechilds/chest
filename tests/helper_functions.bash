random_string() {
  local length="$1";
  env LC_CTYPE=C tr -dc "a-zA-Z0-9" < /dev/urandom | head -c "$length"
}

create_dummy_folders() {
  local folder="$1";
  mkdir -p "$folder"
  touch "$folder/foo"
  touch "$folder/bar"
}

remove_dummy_folders() {
  rm -rf test-folder-*
}

teardown() {
  remove_dummy_folders
}
