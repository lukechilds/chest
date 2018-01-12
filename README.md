# Chest [![Build Status](https://travis-ci.org/lukechilds/chest.svg?branch=master)](https://travis-ci.org/lukechilds/chest)

> Bash glue to encrypt and hide files

Chest allows you to encrypt any file/folder and move it to a hidden directory on your machine. When needed you can retrieve it from the chest into the current working directory.

Chest makes use of password based AES256 encryption with a strong key derivation function provided by `gpg` to make sure your data is secure.

Your chest can easily by synced between machines via any third party cloud storage providers such as Dropbox or Google Drive etc.

<p align="center">
	<img src="https://rawgit.com/lukechilds/chest/master/demo/terminal.svg" width="720">
</p>

## Why

I wanted something that was:

- Highly secure to store stuff like Bitcoin private keys
- Easily accessible from the CLI (quickly encrypt/decrypt)
- Can handle directories or files
- Sync-able between machines
- usable interactively or scriptable
- Password based (keys are in my brain, not on my machine)
- Keeps me completely in control of my data
- Allows me to choose whether to store locally or replicate to the cloud/VPS etc
- Simple and easy to understand source code
- No crazy dependencies

Chest ticks all those boxes. It's under 300 lines of fairly simple Bash, and about 90% of that are just CLI helper methods. The core encryption logic is easily understandable and is only a handful of lines.

It's basically a shell script wrapper around `tar | gpg` so you don't have to hand type commands like:

```shell
# Encrypt secret-folder
tar -cvzf - "secret-folder" | gpg -c --cipher-algo AES256 > "secret-folder.tar.gz.gpg"

# Decrypt secret-folder
gpg -d "secret-folder.tar.gz.gpg" | tar -xvzf -
```

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

## Options

#### `CHEST_DIR`

The directory all of your encrypted data will be stored in.

Defaults to `~/.chest`.

```shell
export CHEST_DIR="$HOME/.chest"
```

#### `CHEST_CLEAR_PASSWORD_CACHE`

By default, `gpg` will cache passwords for as long as the `gpg` agent is running. This means you don't need to keep re-entering the same password to decrypt the same file. This is useful for certain use cases but for storing highly sensitive data is probably not what you want. By default we reload the `gpg` agent each time you enter a password to ensure they aren't cached.

You can diable this by setting `CHEST_CLEAR_PASSWORD_CACHE` to `false`.

Defaults to `true`.

```shell
export CHEST_CLEAR_PASSWORD_CACHE="true"
```

## Tips

### Cloud Backup/Sync

As long as you're using strong passwords, it's safe to replicate your Chest to the cloud. Everything will be encrypted before it leaves your machine and the keys are safely stored in your brain.

For example to set this up with Dropbox, you could either do:

```shell
ln -s ~/.chest ~/Dropbox/chest
```

or

```shell
export CHEST_DIR="$HOME/Dropbox/chest"
```

Now your encrypted files will be safely replicated around the world on Dropbox's servers to prevent against data loss.

You can also do this across multiple machines to keep your Chest in sync between them.

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
