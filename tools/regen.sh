#!/usr/bin/env bash

# Compiles and regenerates vscode *-color-theme.json files from Liquid templates.

RENDER=base16cs-render

# First: install base16cs-render binary from base16cs crate.
if ! ${RENDER} --help &>/dev/null; then
	cargo install base16cs --features=cli
fi

SOURCEDIR=$(pwd)
PALETTESDIR=${SOURCEDIR}/palettes
THEMESDIR=${SOURCEDIR}/themes
OUTDIR="${1:-$THEMESDIR}"

echo "Compiling Selenized Light color theme..."
${RENDER} \
	--palette ${PALETTESDIR}/selenized-light.yaml \
	-d ${THEMESDIR}/common \
	-d ${THEMESDIR}/selenized \
	-t ${THEMESDIR}/selenized/light-color-theme.json.liquid \
	>${OUTDIR}/Selenized_Light-color-theme.json

echo "Compiling Selenized Dark color theme..."
${RENDER} \
	--palette ${PALETTESDIR}/selenized-dark.yaml \
	-d ${THEMESDIR}/common \
	-d ${THEMESDIR}/selenized \
	-t ${THEMESDIR}/selenized/dark-color-theme.json.liquid \
	>${OUTDIR}/Selenized_Dark-color-theme.json

echo "Compiling Solarized Light color theme..."
${RENDER} \
	--palette ${PALETTESDIR}/solarized-light.yaml \
	-d ${THEMESDIR}/common \
	-d ${THEMESDIR}/solarized \
	-t ${THEMESDIR}/solarized/light-color-theme.json.liquid \
	>${OUTDIR}/Solarized_Light-color-theme.json

echo "Compiling Solarized Dark color theme..."
${RENDER} \
	--palette ${PALETTESDIR}/solarized-dark.yaml \
	-d ${THEMESDIR}/common \
	-d ${THEMESDIR}/solarized \
	-t ${THEMESDIR}/solarized/dark-color-theme.json.liquid \
	>${OUTDIR}/Solarized_Dark-color-theme.json
