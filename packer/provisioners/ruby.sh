#!/bin/bash --login
printf "Installing Ruby Dependencies **********************************************************"
sudo apt-get install -y build-essential bison openssl libreadline-dev curl git-core git zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool libpcap-dev libsqlite3-dev libgmp-dev

# We clone CSI here instead of csi.sh so ruby knows what version of ruby to install
# per the latest value of .ruby-version in the repo.
printf "Cloning CSI Repo **********************************************************************"
sudo /bin/bash --login -c "cd / && git clone https://github.com/ninp0/csi.git"

printf "Installing ${ruby_version} ************************************************************"
source /etc/profile.d/rvm.sh
ruby_version=$(cat /csi/.ruby-version)
ruby_gemset=$(cat /csi/.ruby-gemset)
sudo /bin/bash --login -c "source /etc/profile.d/rvm.sh && rvm install ${ruby_version} && rvm use ${ruby_version} && rvm gemset create ${ruby_gemset} && rvm --default ${ruby_version}@${ruby_gemset} && rvm use ${ruby_version}@${ruby_gemset}"
