FROM local-debian-xfce-vnc

ARG UNITYHUB_VERSION

# Change to user root, as the base image has by default a non-root user 
USER 0

## Install utils to download unity public key
RUN apt update
RUN apt-get install -y wget
RUN apt-get install -y gpg

## Download unity public key
RUN wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
RUN mv /usr/share/keyrings/Unity_Technologies_ApS.gpg /etc/apt/trusted.gpg.d/

## Add repository to package manager
RUN sh -c 'echo "deb [signedby=/etc/apt/trusted.gpg.d/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
RUN sh -c 'echo "deb [signedby=/etc/apt/trusted.gpg.d/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb unstable main" > /etc/apt/sources.list.d/unityhub-beta.list'

## Install unityhub
RUN apt update
RUN if [ -z "$UNITYHUB_VERSION" ] ; then apt-get install -y unityhub ; else apt-get install -y unityhub=$UNITYHUB_VERSION ; fi

# libgconf-2-4 was on unity documentation for some issue that may happen
#RUN apt-get install -y xz-utils libgconf-2-4
RUN apt-get install -y xz-utils

# Change back to default user
USER 1000
