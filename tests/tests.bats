#!/usr/bin/env bats

load variables
load helper_functions

@test "Check gpg is in PATH" {
  command -v gpg
}

@test "Check chest dir gets created" {
  run ./chest
  [[ -d "$CHEST_DIR" ]]
}

@test "Running with no commands should return usage with error status" {
  run ./chest
  [[ "$status" -eq 1 ]]
  echo "${lines[0]}"
  [[ "${lines[0]}" = "Usage"* ]]
}

@test "Send a folder to the chest" {

  # Generate random folder name
  folder="test-folder-$(random_string 8)"

  # Create dummy folder and files
  create_dummy_folders "$folder"

  # Send to chest
  ./chest -ep "password" "$folder"

  # Check it's there
  ./chest -l | grep "$folder"

}
