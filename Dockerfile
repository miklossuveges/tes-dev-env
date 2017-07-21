FROM ubuntu

# switch to bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# mandatory packages
RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qq --fix-missing && \
    apt-get install -qqy --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
        build-essential \
        python \
        git \
        procps samba samba-vfs-modules \
        openssh-server \
        less nano

# docker install
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update -qq && apt-get install -qqy --no-install-recommends docker-ce

# nvm node install
ENV NODE_VERSION 8.2.0
ENV NVM_DIR /usr/local/nvm
RUN curl -fso - https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION

# npm install
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH "$PATH:$NVM_DIR/versions/node/v$NODE_VERSION/bin"
RUN npm i -g pm2 nodemon bosco


# init tes dev
ADD ./scripts/ /.tes/
ADD ./config/ /.tes/
# ADD ./.ssh/ /root/.ssh/
ENV TES_DIR /tes
# ENV SSH_DIR /root/.ssh
RUN /.tes/setup.sh

# cleanup
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
