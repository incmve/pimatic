## No longer maintained.


## Pimatic for Docker
"pimatic is a home automation framework that runs on node.js. It provides a common extensible platform for home control and automation tasks."

This Dockerfile will create a container based on Debian, installs NodeJS (v4.x) and pimatic via NPM.
Issues with pimatic v0.9.43 seems to be resolved so the main branch is the lastest.

# Versions
* Latest - installs the lastest release version of pimatic
* 0.9.42 - Specifically installs pimatic 0.9.42
* nodeV8 - installs the lastest pimatic but with node V8 (Experimental)

# Setup

* pimatic auto start and listenens on port 80
* Default login admin:admin
* Default config in /home/pimatic/pimatic-app/config.json

```
docker run -p 3000:3000 --name pimatic -d -v /volume1/Docker/Pimatic/config.json:/home/pimatic/pimatic-app/config.json:rw incmve/pimatic-docker
```

NOTE!
On first boot have patience!
It takes some time to install SQLite.
Look at the log file /home/pimatic/pimatic-app/pimatic-daemon.log for ```[pimatic] info: Listening for HTTP-request on port 80...```

On my Synology I mapped the config.json outside the container.
```
/volume1/Docker/Pimatic/config.json:/home/pimatic/pimatic-app/config.json
```
# USB
If you want to use Homeduino or MaxCul you have to install the drivers package(http://www.jadahl.com/drivers/DSM_6.1/) and run the container with high privileges 

