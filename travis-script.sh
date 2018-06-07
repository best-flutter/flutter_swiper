#!/bin/bash

echo "$PWD"
export ROOT="$PWD"
export PATH=~/development/flutter/bin:$PATH

echo 'Formating code'
flutter format . || exit $?