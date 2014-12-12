#!/bin/bash
set -e
source /build/buildconfig
set -x

yum clean all
rm -rf /build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
## Niek: This is for a dpkg tweak in prepare.sh which I disabled because CentOS
## uses yum instead.
#rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

rm -f /etc/ssh/ssh_host_*
