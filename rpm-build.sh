#!/bin/sh -ex

cd `dirname $0`
./configure
make dist
exec rpmbuild -ta *ftools*.tar.gz
