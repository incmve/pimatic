############################################################
# Dockerfile to build Pimatic container images
# Based on Debian
############################################################

# Set the base image
FROM debian

# File Author / Maintainer
MAINTAINER  "incmve <https://github.com/incmve>"

################## BEGIN INSTALLATION ######################
# Install NodeJS v4.x
RUN apt-get update \
&& apt-get --yes install curl build-essential apt-utils git dialog wget libudev-dev \
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
&& sed -i "s/\"password\": \"\"/\"password\": \"admin\"/g" /home/pimatic/pimatic-app/config.json

ENV TZ Europe/Amsterdam

# Expose port
EXPOSE 80

WORKDIR /home/pimatic/pimatic-app/
CMD service pimatic start && bash
