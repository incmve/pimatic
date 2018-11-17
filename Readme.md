# Pimatic for Docker
"pimatic is a home automation framework that runs on node.js. It provides a common extensible platform for home control and automation tasks."

This Dockerfile will create a container based on Debian, installs NodeJS (v4.x) and pimatic (v0.9.42) via NPM


## Setup

* pimatic auto start and listenens on port 80
* Default login admin:admin
* Default config in /home/pimatic/pimatic-app/config.json




NOTE!
On first boot have patience!
It takes some time to install SQLite.
Look at the log file /home/pimatic/pimatic-app/pimatic-daemon.log for ```[pimatic] info: Listening for HTTP-request on port 80...```
