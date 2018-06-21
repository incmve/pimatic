FROM debian:latest

# Author
MAINTAINER incmve

####### PIMATIC installaton #######
RUN mkdir /home/pimatic-app
RUN /usr/bin/env node --version
RUN cd /home && npm install pimatic --prefix pimatic-app --production


####### Instal globally #######
RUN cd /home/pimatic-app/node_modules/pimatic && npm link

####### Copy the default config to our installation #######
RUN cp /home/pimatic-app/node_modules/pimatic/config_default.json /home/pimatic-app/config.json

####### Config the autostart #######
RUN wget https://raw.githubusercontent.com/pimatic/pimatic/v0.9.x/install/pimatic-init-d && cp pimatic-init-d /etc/init.d/pimatic
RUN chmod +x /etc/init.d/pimatic
RUN chown root:root /etc/init.d/pimatic
RUN update-rc.d pimatic defaults
RUN sed -i "s/\"password\": \"\"/\"password\": \"abcd1234\"/g" /home/pimatic-app/config.json

####### Link the persistent config.json file and start the pimatic service #######
CMD service pimatic start && bash

# Expose pimatic port e.g. 80
EXPOSE 80

