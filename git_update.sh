#!/bin/sh
#
#  git_update.sh
#
#  Copyright 2009-2011 Frank Lanitz <frank(at)frank(dot)uvena(dot)de>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#
# This file is based on a script of Joerg Sommer original published at
# http://www.lug-jena.de/veranstaltungen/vcs-vortrag.html

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
