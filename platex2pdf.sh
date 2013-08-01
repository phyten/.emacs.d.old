#!/usr/bin/zsh
export name=$1
platex --kanji=utf8 $1
dvipdfm ${name%.*}
