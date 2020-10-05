############################################################
# Dockerfile to build Pimatic container images
# Based on Debian
############################################################

# Set the base image
FROM node:8.0.0

# File Author / Maintainer
MAINTAINER  "incmve <https://github.com/incmve>"

################## VARIABLES ######################
ENV TZ Europe/Amsterdam
# Set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

################## BEGIN INSTALLATION ######################
RUN apt-get update \
&& apt-get --yes install procps jq curl build-essential apt-utils git dialog wget libudev-dev locales nano ftp-upload \
&& mkdir /home/pimatic/ \
&& mkdir /home/pimatic/pimatic-app && touch /home/pimatic/pimatic-app/.npmignore \
&& cd /home/pimatic/ && npm install pimatic --prefix pimatic-app --production \
&& cp /home/pimatic/pimatic-app/node_modules/pimatic/config_default.json /home/pimatic/pimatic-app/config.json \
&& cd /home/pimatic/pimatic-app/node_modules/pimatic && npm link && wget https://raw.github.com/pimatic/pimatic/master/install/pimatic-init-d && cp pimatic-init-d /etc/init.d/pimatic \
&& chmod +x /etc/init.d/pimatic \
&& chown root:root /etc/init.d/pimatic \
&& update-rc.d pimatic defaults \
&& cd /home/pimatic/pimatic-app/node_modules/ \
&& npm install sqlite3 --force \
&& sed -i "s/\"password\": \"\"/\"password\": \"admin\"/g" /home/pimatic/pimatic-app/config.json \
&& ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
 locale-gen

# Expose port
EXPOSE 80

WORKDIR /home/pimatic/pimatic-app/
CMD service pimatic restart && bash
