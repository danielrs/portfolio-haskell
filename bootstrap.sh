#! /bin/bash

haskellPlatform=https://haskell.org/platform/download/7.10.2/haskell-platform-7.10.2-a-unknown-linux-deb7.tar.gz

# PACKAGES
apt-get update
apt-get install -y git
apt-get install -y vim

# Node.js
apt-get install curl
curl -sL https://deb.nodesource.com/setup_5.x | bash -
apt-get install --yes nodejs

# Bower
npm install -g bower

# LIBRARIES NEEDED BY HASKELL APPS
apt-get install -y libgmp-dev

# HASKELL PLATFORM
mkdir haskell-platform
cd haskell-platform

wget -O haskell-platform.tar.gz $haskellPlatform
tar -xzvf haskell-platform.tar.gz
./install-haskell-platform.sh

cd ../
rm -rf haskell-platform

# Set some environment variables
echo 'export PATH="$PATH:/home/vagrant/.cabal/bin"' >> /home/vagrant/.bashrc
