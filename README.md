# pwntainer

Docker container to use with binary exploitation challenges.

Inspired by skysider's [pwndocker](https://github.com/skysider/pwndocker) and
stavhaygn's [pwn-ubuntu](https://github.com/stavhaygn/pwn-ubuntu) containers.

I only added the tools in which I'm comfortable in navigating and utilizing to
not add excessive bloat to the container. I'll probably add more as I find more useful things
to add.

## Included Tools

- gdb
- pwndbg, GEF, and PEDA
  - can run each via `gdb-pwndbg`, `gdb-gef`, or `gdb-peda`
- pwntools
- ropper
- ROPgadget
- z3
- unicorn engine
- keystone engine
- capstone engine
- angr
- seccomp-tools
- radare2

## Building

```
git clone git@github.com:jsfleming/pwntainer
cd pwntainer
make
```

Add the script [sigbreak](sigbreak) to somewhere visible on your `PATH`.

## Usage

Simply run `sigbreak` in a directory of your choice to spin up a container and
mount those files inside. You can attach to the container if it's already running by
running `sigbreak` in the same directory. To stop the container, run `sigbreak stop` in
that directory.

## Maintenance

To add extra tools or files to the container, simply edit the [Dockerfile](Dockerfile)
and run `make` to re-build the image.

## Caveats

`sigbreak` will attach to a container with the same name as the current directory, so running
it in `/home/me/project/` or `/home/me/project/project` will attach to the same container. The
folder mounted in the container will be from whichever directory `sigbreak` was executed
in first.
