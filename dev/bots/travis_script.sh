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

  flutter test test/control_test.dart || exit $?
  flutter test test/flutter_swiper_test.dart || exit $?
  flutter test test/pagination_test.dart || exit $?

fi
