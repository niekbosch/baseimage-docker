#!/bin/bash
set -e
source /build/buildconfig
set -x

## Temporarily disable dpkg fsync to make building faster.
## Niek: This tweak is disabled for CentOS, as it uses yum instead of dpkg. I
## don't know the equivalent of this tweak for yum
#echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

## Fix some issues with APT packages.
## See https://github.com/dotcloud/docker/issues/1024
## Niek: This tweak is disabled for CentOS, as it uses yum instead of dpkg. I
## don't know the equivalent of this tweak for yum
#dpkg-divert --local --rename --add /sbin/initctl
#ln -sf /bin/true /sbin/initctl

## Replace the 'ischroot' tool to make it always return true.
## Prevent initscripts updates from breaking /dev/shm.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## https://bugs.launchpad.net/launchpad/+bug/974584
## Niek: This tweak is disabled for CentOS, as it uses yum instead of dpkg. I
## don't know the equivalent of this tweak for yum
#dpkg-divert --local --rename --add /usr/bin/ischroot
#ln -sf /bin/true /usr/bin/ischroot

## Workaround https://github.com/dotcloud/docker/issues/2267,
## not being able to modify /etc/hosts.
mkdir -p /etc/workaround-docker-2267
ln -s /etc/workaround-docker-2267 /cte
cp /build/bin/workaround-docker-2267 /usr/bin/

## Upgrade all packages.
yum update -y
