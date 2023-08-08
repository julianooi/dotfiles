#! /usr/bin/zsh
# must be run using .
# eg: . gwtg.sh

dir=$(git worktree list | fzf | cut -d ' ' -f1)
cd $dir

