ZSH Command Statistics
========================

Print information about exit code and execution time after a program exits.
This is intended for use with [Antigen][1] and [Prezto][2], but that is not a requirement.

Installation
------------

Load as a module, or source the file and it is running with default settings.

### Using Antigen

```sh
antigen bundle ankaan/zsh-cmdstat
```

Settings
--------

By default the information is printed if a command was running for at least 5 second or it exited with an error code.

To change the time before the output is printed, use:

```sh
zstyle ':cmdstat:*' command-complete-timeout 30
```

To disable always showing the information when the command exited with an error, use:

```sh
zstyle ':cmdstat:*' always-on-error 'no'
```

To activate a terminal bell when the information is printed, use:

```sh
zstyle ':cmdstat:*' bell 'yes'
```

Authors
-------

  - [Anders Engström](https://github.com/ankaan)


[1]: https://github.com/zsh-users/antigen
[2]: https://github.com/sorin-ionescu/prezto/
