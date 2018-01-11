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
  [[ "${lines[0]}" = "Usage"* ]]
}

@test "-e Encrypts a file and sends it to the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ep "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

}

@test "-d decrypts a file from the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ep "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

  # Retrieve it
  teardown
  ./chest -dp "password" "$folder"

  # Check it's there
  ls | grep "$folder"

}

@test "-z Compresses data before/after sending to chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ezp "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

  # Retrieve it
  teardown
  ./chest -dp "password" "$folder"

  # Check it's there
  ls | grep "$folder"

}

@test "-r Removes the original file after sending to the chest" {

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

@test "Directories with children can be added/retrieved form the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ep "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

  # Retrieve it
  teardown
  ./chest -dp "password" "$folder"

  # Check it's there
  ls "$folder" | grep foo
  ls "$folder" | grep bar

}
