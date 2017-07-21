#!/bin/bash
curl -os- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install 8


# export PATH=/usr/local/bin:$PATH
# export PATH=$(which node):$PATH
# ln -s `which node` /usr/bin/node

#  /bin/bash 
 ( "/.tes/tes-dev.sh" )
# /.tes/setup.sh