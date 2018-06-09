#!/bin/bash
set -ex

export PATH=~/development/flutter/bin:$PATH
export ROOT="$PWD"

if [[ "$SHARD" == "dartfmt" ]]; then
 echo 'Formating code'
 cd $ROOT
 flutter format . || exit $?
else
  # tests shard
  cd $ROOT
  flutter --no-color test --machine --start-paused test/flutter_swiper_test.dart || exit $?
fi
