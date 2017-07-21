#!/bin/bash

function ensure_ssh_key {
    if [ ! -f ~/.ssh/id_rsa ]; then
        mkdir -p ~/.ssh/
        # echo $(ls ${TES_DIR}/.ssh)
        if [ ! -f ${TES_DIR}/.ssh/id_rsa ]; then
            echo 'generating ssh keys'
            ssh-keygen -t rsa -b 4096 -q -N "";
        else
            echo 'copying ssh keys'
            cp -nr ${TES_DIR}/.ssh/. ~/.ssh
        fi
    else 
        echo 'found ssh keys'
    fi
    chmod 600 ~/.ssh/id_rsa
}

function ensure_ssh {
    if [ -z "$SSH_AUTH_SOCK" ] ; then
        eval `ssh-agent -s`
        ssh-add
    fi
}

function install_repos {
    npm config set registry http://npm.tescloud.com
    repos="app-authentication app-payments-ui app-resource-sale app-resource-user-dashboard app-user-profile service-author-sales-api service-layout-template service-page-composer service-payment-gateway service-recommendation-api service-registration service-resource-api service-rz rz service-seller-tiers service-site-assets service-social-functions"
    mkdir -p "${TES_DIR}/team-dashboards"
    currentDir=$(pwd)
    for repo in $repos ; do
        cd "${TES_DIR}/team-dashboards"
        git clone "git@github.com:tes/$repo.git"
        cd $repo
        nvm install && npm install;
    done
    cd $currentDir
    nvm use $NODE_VERSION
}

function bosco_setup {
    nvm use $NODE_VERSION
    mkdir -p ~/.config/bosco
    cp -n /.tes/bosco.json ~/.config/bosco/bosco.json
    cd "${TES_DIR}/team-dashboards"
    bosco morning -y
}

function login {
    ensure_ssh_key
    ensure_ssh
    if [ ! -d "$TES_DIR/team-dashboards" ]; then
        install_repos
    fi
    if [ ! -f ~/.config/bosco/bosco.json ]; then
        bosco_setup
    fi
}

declare -pf >> ~/.bashrc
echo "login" >> ~/.bashrc
