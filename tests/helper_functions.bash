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

teardown() {
  # Remove any leftover temp folders
  rm -rf test-folder-*
}
