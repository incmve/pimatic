############################################################
# Dockerfile to build Pimatic container images
# Based on Debian
############################################################

# Set the base image
FROM debian

# File Author / Maintainer
MAINTAINER  "incmve <https://github.com/incmve>"

################## VARIABLES ######################
ENV TZ Europe/Amsterdam
# Set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

################## BEGIN INSTALLATION ######################
# Install NodeJS v4.x
RUN apt-get update \
&& apt-get --yes install curl build-essential apt-utils git dialog wget libudev-dev locales nano ftp-upload \
&& curl -sL https://deb.nodesource.com/setup_4.x | bash - \
&& apt-get --yes install nodejs \
&& mkdir /home/pimatic/ \
&& mkdir /home/pimatic/pimatic-app && touch /home/pimatic/pimatic-app/.npmignore \
&& cd /home/pimatic/ && npm install pimatic@0.9.42 --prefix pimatic-app --production \
&& cp /home/pimatic/pimatic-app/node_modules/pimatic/config_default.json /home/pimatic/pimatic-app/config.json \
&& cd /home/pimatic/pimatic-app/node_modules/pimatic && npm link && wget https://raw.github.com/pimatic/pimatic/master/install/pimatic-init-d && cp pimatic-init-d /etc/init.d/pimatic \
&& chmod +x /etc/init.d/pimatic \
&& chown root:root /etc/init.d/pimatic \
&& update-rc.d pimatic defaults \
&& sed -i "s/\"password\": \"\"/\"password\": \"admin\"/g" /home/pimatic/pimatic-app/config.json \
&& ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
 locale-gen



# Expose port
EXPOSE 80

WORKDIR /home/pimatic/pimatic-app/
CMD service pimatic start && bash
