#!/usr/bin/env bash

set -ex

tarball=$1
specfile=$2
files=$3

echo "::group::Prepare rpm directory structure"
tmpdir=`mktemp -p /github/workspace -d`
dir=$tmpdir/rpmbuild
mkdir -p "$dir/BUILD"
mkdir -p "$dir/RPMS"
mkdir -p "$dir/SOURCES"
mkdir -p "$dir/SPECS"
mkdir -p "$dir/SRPMS"
echo "::endgroup::"

echo "::group::Move tarball to rpm buildroot"
cp "$tarball" "$dir/SOURCES/"
echo "::endgroup::"

echo "::group::Copy source files to rpm buildroot"
for file in $files; do
    cp "$file" "$dir/SOURCES/"
done
echo "::endgroup::"

echo "::group::Build source rpm"
rpmbuild --define "_topdir $dir" -bs "$specfile"
echo "::endgroup::"

echo "::group::Set output srpm path"
chmod -R a+rwx "$tmpdir"
path=`ls $dir/SRPMS/*.rpm`
path=${path#/github/workspace/}
file=`basename $path`
echo "path=$path" >> $GITHUB_OUTPUT
echo "file=$file" >> $GITHUB_OUTPUT
echo "::endgroup::"
