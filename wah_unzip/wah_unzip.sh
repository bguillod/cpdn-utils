#!/bin/bash
#############################################################################
# 
#  Program : wah_unzip.sh
#  Author  : Benoit Guillod
#  Date    : 06/01/16
#  Purpose : Function to unzip wah output
#  Call    : ./wah_unzip.sh in_path out_path
#      where 'in_path'  contains folders of work units containing zipped files
#            'out_path' is a folder (to be created) where the same structure will be created but with unzipped netcdf files
#
#############################################################################

# define variables, paths etc
path_in=$1
path_out=$2
cur_path=`pwd`

# prepare directories
cd $path_in
mkdir -p $path_out

# unzip files
nfiles=`ls -1 | wc -l`
echo ---- Starting to unzip files from $nfiles work units ----
i=0
for f in * ; do
    cp -r $path_in/$f $path_out/$f
    cd $path_out/$f
    for ff in *.zip ; do
        unzip $ff > $path_out/unzip.out
        rm `ls -l | grep -v .zip | grep -v .nc | awk '{print $9}'` > $path_out/unzip.out
    done
    rm *.zip > $path_out/unzip.out
    i=$((i+1))
    echo -- work unit $i out of $nfiles completed --
    # cd $path_in
done
cd $cur_path
echo ---- script completed ----
