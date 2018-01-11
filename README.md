# Chest [![Build Status](https://travis-ci.org/lukechilds/chest.svg?branch=master)](https://travis-ci.org/lukechilds/chest)

> Bash glue to encrypt and hide files

Chest allows you to encrypt any file/folder and move it to a hidden directory on your machine. You can then retrieve it from the chest into the current working director at any point in the future.

Chest makes use of password based AES256 encryption with a strong key derivation function provided by `gpg` to make sure your data is secure.

## Usage

```
$ chest -h
chest 0.2.0

Usage: chest -e [folder|file]
       chest -d [key]

  -h            Help. Display this message and quit.
  -e            Encrypt data and send to chest.
  -d            Decrypt data from chest.
  -z            Compress (zip) data before sending to chest.
  -r            Remove original data after sending to chest.
  -l            List items in chest.
  -k [key]      Set key to save/retrieve.
  -p [password] Set password. (omit to be prompted)
```

## Installation

### macOS

```shell
brew install lukechilds/tap/chest
```

### Linux

Just clone this repo and either copy/symlink `chest` to your PATH or run the script directly with `./chest`. Requires `gpg` to be installed.

### Windows

```
¯\_(ツ)_/¯
```

## License

MIT © Luke Childs
