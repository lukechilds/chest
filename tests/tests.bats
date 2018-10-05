#!/usr/bin/env bats

load variables
load helper_functions

@test "gpg is in PATH" {
  command -v gpg
}

@test "CHEST_DIR gets auto created" {
  run ./chest
  [[ -d "$CHEST_DIR" ]]
}

@test "Running with no commands returns usage with error status" {
  run ./chest
  [[ "$status" -eq 1 ]]
  echo "${lines[0]}"
  [[ "${lines[0]}" = "chest"* ]]
}

@test "Option -e encrypts a file and sends it to the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ep "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

}

@test "Option -d decrypts a file from the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ep "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

  # Retrieve it
  remove_dummy_folders
  ./chest -dp "password" "$folder"

  # Check it's there
  ls | grep "$folder"

}

@test "Option -z compresses data before/after sending to chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ezp "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

  # Retrieve it
  remove_dummy_folders
  ./chest -dp "password" "$folder"

  # Check it's there
  ls | grep "$folder"

}

@test "Option -r removes the original file after sending to the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -erp "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

  # Check the original file is removed
  ! ls | grep "$folder"

}

@test "Option -l lists items in chest" {

  # Clear all items from chest
  rm -rf $CHEST_DIR

  # Generate random folder names
  folder1="test-folder-$(random_string 8)"
  folder2="test-folder-$(random_string 8)"

  # Create dummy folders and files
  create_dummy_folders "$folder1"
  create_dummy_folders "$folder2"

  # Send to chest
  ./chest -erp "password" "$folder1"
  ./chest -erp "password" "$folder2"

  # Check they're there
  ./chest -l | grep "$folder1"
  ./chest -l | grep "$folder2"

}

@test "Option -k sets a custom key" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -e -k "thisisakey" -p "password" "$folder"

  # Check it's there
  ./chest -l | grep "thisisakey"

}

@test "Directories with children can be added/retrieved from the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ep "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

  # Retrieve it
  remove_dummy_folders
  ./chest -dp "password" "$folder"

  # Check it's there
  ls "$folder" | grep foo
  ls "$folder" | grep bar

}
