# GNU Radio Docker Environment

Just another custom docker environment for GNU Radio. Tested on M1 Macs & Ubuntu and GNU Radio 3.9.x. Custom dependencies are included.

``gnuradio - companion - docker - macos - linux`` 

[![shields.io](https://img.shields.io/badge/license-Apache2-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.txt)

Maintainer: [Maximilian Bundscherer](https://bundscherer-online.de)

## Overview

First of all, I want to mention that I used [this GitHub Gist](https://gist.github.com/daniestevez/81c2eecd3f087baebcd1327ef9d2692c) and [this GitHub Repo](https://github.com/igorauad/gnuradio-docker-env) as a starting point, which was an invaluable help. I have therefore put the orginal doc in `oldDoc/`.

I built on this work because I use a slightly different workflow for my projects and because I work on both Macs and Linux servers.

Later I used this [repo](https://github.com/git-artes/docker-gnuradio). I customised my Dockerfile for the same reason.

## Let's get started

- (`sudo` password is `gnuradio`)

### Run on macOS

- Start XQuartz `xhost + 127.0.0.1` (opens XQuartz UI)
- Start container and connect to it `docker start -i mb-gnuradio`
- Run `gnuradio-companion`
- Read ``More selection`` below

### Run on Ubuntu

- Start container and connect to it `docker start -i mb-gnuradio`
- Run `gnuradio-companion`
- Read ``More selection`` below

## Install

### XQuartz Installation (only macOS)

- [XQuartz](https://www.xquartz.org/) is required to run X11 applications in a Docker container. This is necessary because, for example, `gnuradio-companion` uses the graphical user interface.
- Restart mac after installation of XQuartz
- Test and configure XQuartz
    - `xhost + 127.0.0.1` (opens XQuartz UI)
    - Open settings in XQuartz UI and allow connections from network clients in the security tab
    - `docker run -e DISPLAY=host.docker.internal:0 gns3/xeyes` (runs docker container with xeyes connected to XQuartz - for testing ui)

### XQuartz Config (only Ubuntu)

- Configure XQuartz to allow connections from docker
    - `xhost +local:docker`
    - `docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro gns3/xeyes` (runs docker container with xeyes connected to XQuartz - for testing ui)

### Docker Image and Container (on Ubuntu and macOs)

- Clone this repo
- Build docker image
    - Build docker container (macOS) `./build-macOS.sh`
    - Build docker container (Ubuntu) `./build-ubuntu.sh`
    - Build docker container (Ubuntu Server in HPC) `./build-ubuntuHPC.sh`
- Kill container after first start

## More

### GUI-Editor

- Use `/usr/bin/gvim` as editor in GNU Radio

## Deprecated

### Audio Output

- Use UDP Sink in GNU Radio and `nc -l -u 0.0.0.0 7360 | play -t raw -esigned-integer -b 16 -r 48000 -` on your host
- (alternative) Use Wave-File Sink in GNU Radio

### OutOfTreeModules (OOT)

- `gr_modtool newmod <MODULE_NAME> --srcdir /root/gr_prefix/gnuradio/gr-utils/modtool/templates/gr-newmod/`
- `cd <MODULE_NAME>`
- `gr_modtool add -t sync -l python` (Add Python QA code? y)
- `mkdir build; cd build`
- `cmake ..`
- `make` (Edit files)
- `make install`
- `ldconfig`

#### Remove

- `rm /usr/local/share/gnuradio/grc/blocks/<MODULE_NAME>_<BLOCK_NAME>.block.yml`
