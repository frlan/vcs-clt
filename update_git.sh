#!/bin/sh

set -e

cd /daten/quellen/

for i in git/*; do
    [ -e "$i/.git" ] || continue
    if grep --quiet svn-remote "$i/.git/config"; then
        (cd "$i"; git svn fetch; git gc --quiet) &
    elif [ -d "$i/.git/refs/remotes/origin" ]; then
        (cd "$i"; git fetch; git gc --quiet) &
    else
        case "$i" in
          xgit/icewm-upstream)
            (cd "$i"; git cvsimport ${cvs_options} \
              -d:pserver:anonymous@icewm.cvs.sourceforge.net:/cvsroot/icewm \
              icewm-1.2) &
            ;;
          git/jedmodes)
            (cd "$i"; git cvsimport ${cvs_options} \
        -d:pserver:anonymous@jedmodes.cvs.sourceforge.net:/cvsroot/jedmodes \
              mode) &
            ;;
        esac
    fi
done

wait
