#!/bin/bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

usage() { echo "Usage: $0 -b <branch>" 1>&2; exit 1; }

while getopts "?hvb:" opt; do
    case "$opt" in
    h|\?)
        usage
        exit 0
        ;;
    v)  verbose=1
        ;;
    b)  BRANCH=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

if [ ${verbose} ]; then
    set -x
fi
if [ -z ${BRANCH} ]; then
    echo "Please provide branch name"
    exit 1
fi

SANITY_BRANCH=`echo ${BRANCH} | sed 's/\//_/'`
hasBugNumber=`echo ${SANITY_BRANCH} | grep -E ".*_[[:alnum:]]+-[[:digit:]]+" |wc -l`
if [  ${hasBugNumber} -eq 1 ]; then
    SANITY_BRANCH=`echo ${SANITY_BRANCH} | grep -oE ".*_[[:alnum:]]+-[[:digit:]]+" |head -1`
fi
echo "${SANITY_BRANCH}"