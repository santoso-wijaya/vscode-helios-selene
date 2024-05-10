#!/usr/bin/env bash

# Compiles and regenerates vscode *-color-theme.json files from Liquid templates.

# TODO: This only works in my own workspace, as base16cs-cli isn't deployed yet.
BASE16CS=../base16cs
CWD=$(PWD)

pushd ${BASE16CS}

cargo run -p base16cs-cli -- \
  --palette ${CWD}/palettes/selenized-light.yaml \
  -d ${CWD}/themes/common \
  -d ${CWD}/themes/selenized \
  -t ${CWD}/themes/selenized/light-color-theme.json.liquid \
  > ${CWD}/themes/Selenized\ Light-color-theme.json

cargo run -p base16cs-cli -- \
  --palette ${CWD}/palettes/selenized-dark.yaml \
  -d ${CWD}/themes/common \
  -d ${CWD}/themes/selenized \
  -t ${CWD}/themes/selenized/dark-color-theme.json.liquid \
  > ${CWD}/themes/Selenized\ Dark-color-theme.json

popd