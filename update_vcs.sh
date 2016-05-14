#!/bin/sh
#
#  update_vcs.sh
#
#  Copyright 2016 Frank Lanitz <frank@frank.uvena.de>
#
#  A small script to sync all vcs projects from a given folder with their
#  remote resources.
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

set -e

path=$1

echo "Checking from: $path"

cd $path

for i in $(ls $path)
do
    echo "Checking now: $i"

    # git

    if [ -e "$i/.git" ]
    then
        if grep --quiet svn-remote "$i/.git/config";
        then
            (cd "$i"; git svn fetch; git gc --quiet)
        elif [ -d "$i/.git/refs/remotes/origin" ]; then
            (cd "$i"; git fetch --all; git gc --quiet)
        fi
    fi

    # mercurial

    if [ -e "$i/.hg" ]
    then
        (cd "$i"; hg pull;)
    fi

    #svn
    if [ -e "$i/.svn" ]
    then
        (cd "$i"; svn update;)
    fi

done
