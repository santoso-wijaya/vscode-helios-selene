#!/usr/bin/env bash

# Compiles vscode *-color-theme.json files and compares with existing files.

SOURCEDIR=$(pwd)
THEMESDIR=${SOURCEDIR}/themes

SCRIPTDIR=$(dirname "$0")
OUTDIR=/tmp/themes

mkdir -p ${OUTDIR}
rm -rf ${OUTDIR}/*
echo Compiling themes files in ${OUTDIR}/ ...
${SCRIPTDIR}/regen.sh ${OUTDIR} >/dev/null

echo Diffing files in ${THEMESDIR}/ ...
for themefile in ${OUTDIR}/*.json; do
	checkfile=${THEMESDIR}/$(basename "$themefile")
	diff $checkfile $themefile || exit 1
	echo "ok"
done

# Clean up and exit.
rm -rf ${OUTDIR}
exit 0
