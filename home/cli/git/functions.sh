#! /bin/env bash

function inc-minor-version() {
  git tag -l 'v*' --sort=-v:refname |
    head -n 1 |
    awk -F. '{print v$1"."$2"."$3+1}' |
    xargs -I {} sh -c 'git tag -m "{}" {} && git push gitlab {}'
}

function delete-tags-by-pattern() {
  pattern=$1 # e.g.: 'v42*'
  git tag -l "$pattern" --sort=-v:refname |
    xargs -I {} /bin/sh -c 'git tag -d {} && git push gitlab --delete {}'
}
