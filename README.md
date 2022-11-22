# gnuradio-docker-env

Just another custom docker environment for GNU Radio. Tested on M1 Macs and GNU Radio Version 3.9.x. gr-osmosdr is included.

``gnuradio - docker - mac - linux - ui`` 

[![shields.io](https://img.shields.io/badge/license-Apache2-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.txt)

Author: [Maximilian Bundscherer](https://bundscherer-online.de)

## Overview

First of all, I want to mention that I used [this GitHub Gist](https://gist.github.com/daniestevez/81c2eecd3f087baebcd1327ef9d2692c) and [this GitHub Repo](https://github.com/igorauad/gnuradio-docker-env) as a starting point, which was an invaluable help. I have therefore put the orginal doc in `oldDoc/`.

I built on this work because I use a slightly different workflow for my projects and because I work on both Macs and Linux servers.

## Let's get started

### Run on macOS

- Start XQuartz `xhost + 127.0.0.1` (opens XQuartz UI)
- Start container and connect to it `docker start -i mb-gnuradio`
- Run `gnuradio-companion`

### Install on macOS

#### XQuartz Installation

- [XQuartz](https://www.xquartz.org/) is required to run X11 applications in a Docker container. This is necessary because, for example, `gnuradio-companion` uses the graphical user interface.
- Restart mac after installation of XQuartz
- Test and configure XQuartz
    - `xhost + 127.0.0.1` (opens XQuartz UI)
    - Open settings in XQuartz UI and allow connections from network clients in the security tab
    - `docker run -e DISPLAY=host.docker.internal:0 gns3/xeyes` (runs docker container with xeyes connected to XQuartz)

#### Docker Image and Container

- Clone this repo
- Build docker image
    - Build docker image `docker build -t mb-gnuradio-image .`
    - Run docker container `docker run --name mb-gnuradio -it gnuradio-image`
    - Stop running container

- Prepare container
    - Start container and connect to it `docker start -i mb-gnuradio`
    - Install dependencies `apt install vim swig libczmq`
    - Clone GNU Radio `git clone https://github.com/gnuradio/gnuradio`
    - Checkout desired version (in this case **3.9.x**)
        - `cd gnuradio`
        - `git checkout maint-3.9;`
        - `git submodule update --init --recursive`
        - ` cd ..`

- Install and compile GNU Radio
    - `mkdir build`
    - `cd build`
    - `cmake -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 ..`
    - `make -j4`
    - `make install`
    - `ldconfig`

- Config GNU Radio
    - `vim /root/.bashrc`
    - Add lines
    ```
    export DISPLAY=host.docker.internal:0
    export GRC_BLOCKS_PATH=/usr/local/share/gnuradio/grc/blocks
    export PYTHONPATH=/usr/local/lib/python3/dist-packages/
    ```
    - Stop running container

#### Dependencies installation

- Add custom dependencies (gr-osmosdr)
    - Start container and connect to it `docker start -i mb-gnuradio`
    - Clone gr-osmosdr `git clone https://github.com/osmocom/gr-osmosdr`
    - `cd gr-osmosdr`
    - `mkdir build`
    - `cd build`
    - `cmake ..`
    - `make`
    - `make install`
    - `ldconfig`
    - Stop running container
