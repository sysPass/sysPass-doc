#!/bin/bash

X_LANG=${1:-es}

make -e SPHINXOPTS="-D language='$X_LANG' -t lang_$X_LANG" -e LANG="$X_LANG" html
