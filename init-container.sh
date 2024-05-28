#!/usr/bin/env bash

# This command uses rsync to recursively copy the contents of the /.dotfiles directory to the user's home directory (~).
# The -r option ensures that the directories are copied recursively, and the -u option updates only the files that have changed.
rsync -ru /.dotfiles ~
cd ~/.dotfiles

source ./install

# zsh
# This script is used to initialize a container.
# It starts the container, sets up a trap to exit gracefully on signal 15 (SIGTERM),
# and then executes the command passed as arguments to the script.
# It also includes a loop that sleeps for 1 second and waits for the command to finish,
# ensuring that the container stays running until the command completes.

echo Container started
trap "exit 0" 15

# create a file so that we can say the container is ready
touch /tmp/ready

exec "$@"
while sleep 1 & wait $!; do :; done
echo Container started\ntrap \"exit 0\" 15\n\nexec \"$@\"\nwhile sleep 1 & wait $!; do :; done
