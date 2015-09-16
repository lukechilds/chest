#!/usr/bin/env bats

@test "Check gpg is in PATH" {
  command -v gpg
}

@test "Check chest dir gets created" {
  run ./chest
  chest_dir="${HOME}/.chest"
  [[ -d "$chest_dir" ]]
}

@test "Running with no commands should return usage with error status" {
  run ./chest
  [[ "$status" -eq 1 ]]
  echo "${lines[0]}"
  [[ "${lines[0]}" = "Usage"* ]]
}
