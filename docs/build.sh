#!/bin/bash

X_LANG=$1

make -e SPHINXOPTS="-D language='$X_LANG' -t lang_$X_LANG" -e LANG="$X_LANG" html
