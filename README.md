# GNU Radio Docker Environment

Just another custom docker environment for GNU Radio. Tested on M1 Macs & Ubuntu and GNU Radio 3.9.x. Custom dependencies are included.

``gnuradio - companion - docker - macos - linux`` 

[![shields.io](https://img.shields.io/badge/license-Apache2-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.txt)

Maintainer: [Maximilian Bundscherer](https://bundscherer-online.de)

## Overview

First of all, I want to mention that I used [this GitHub Gist](https://gist.github.com/daniestevez/81c2eecd3f087baebcd1327ef9d2692c) and [this GitHub Repo](https://github.com/igorauad/gnuradio-docker-env) as a starting point, which was an invaluable help. I have therefore put the orginal doc in `oldDoc/`.

I built on this work because I use a slightly different workflow for my projects and because I work on both Macs and Linux servers.

## Let's get started

### Run on macOS

- Start XQuartz `xhost + 127.0.0.1` (opens XQuartz UI)
- Start container and connect to it `docker start -i mb-gnuradio`
- Run `gnuradio-companion`
- Read ``More selection`` below

### Run on Ubuntu

- Start container and connect to it `docker start -i mb-gnuradio`
- Run `gnuradio-companion`
- Read ``More selection`` below

### Install

#### XQuartz Installation (only macOS)

- [XQuartz](https://www.xquartz.org/) is required to run X11 applications in a Docker container. This is necessary because, for example, `gnuradio-companion` uses the graphical user interface.
- Restart mac after installation of XQuartz
- Test and configure XQuartz
    - `xhost + 127.0.0.1` (opens XQuartz UI)
    - Open settings in XQuartz UI and allow connections from network clients in the security tab
    - `docker run -e DISPLAY=host.docker.internal:0 gns3/xeyes` (runs docker container with xeyes connected to XQuartz - for testing ui)

#### XQuartz Config (only Ubuntu)

- Configure XQuartz to allow connections from docker
    - `xhost +local:docker`
    - `docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro gns3/xeyes` (runs docker container with xeyes connected to XQuartz - for testing ui)

#### Docker Image and Container (on Ubuntu and macOs)

- Clone this repo
- Build docker image
    - Build docker image `docker build -t mb-gnuradio-image .`
    - Run docker container (macOS)
    ```
    docker run --name mb-gnuradio \
        -v "$(pwd)"/mount-gr_prefix:/root/gr_prefix/ \
        -v "$(pwd)"/mount-gnuradio:/root/gr_prefix/src/gnuradio/ \
        -v "$(pwd)"/mount-gr_build:/root/gr_prefix/src/gnuradio/build/ \
        -it mb-gnuradio-image
    ```
    - Run docker container (Ubuntu)
    ```
    docker run --name mb-gnuradio \
        -v "$(pwd)"/mount-gr_prefix:/root/gr_prefix/ \
        -v "$(pwd)"/mount-gnuradio:/root/gr_prefix/src/gnuradio/ \
        -v "$(pwd)"/mount-gr_build:/root/gr_prefix/src/gnuradio/build/ \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -e DISPLAY=$DISPLAY \
        --device /dev/bus/usb \
        -it mb-gnuradio-image
    ```
    - Stop running container
- Prepare container
    - Start container and connect to it `docker start -i mb-gnuradio`
    - Install dependencies `apt install vim swig vim-gtk libsndfile1-dev -y` (``libsndfile1-dev`` audo-wav-file, ``vim-gtk`` editor)
    - Clone GNU Radio `git clone https://github.com/gnuradio/gnuradio`
    - Checkout desired version (in this case **3.9.x**)
        - `cd gnuradio`
        - `git checkout maint-3.9`
        - `git submodule update --init --recursive`
- Install and compile GNU Radio
    - `mkdir build`
    - `cd build`
    - `cmake -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 ..`
    - `make -j4`
    - `make install`
    - `ldconfig`
- Config GNU Radio
    - `vim /root/.bashrc`
    - Add lines (macOS)
    ```
    export DISPLAY=host.docker.internal:0
    export GRC_BLOCKS_PATH=/usr/local/share/gnuradio/grc/blocks
    export PYTHONPATH=/usr/local/lib/python3/dist-packages/
    ```
    - Add lines (Ubuntu) (`:10.0` is output of `echo $DISPLAY`)
    ```
    export DISPLAY=:10.0
    export GRC_BLOCKS_PATH=/usr/local/share/gnuradio/grc/blocks
    export PYTHONPATH=/usr/local/lib/python3/dist-packages/
    ```
    - Stop running container

#### Dependencies Installation

##### GR-OSMOSDR

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

##### GR-SIGMF

- Install dependencies `apt install rapidjson-dev -y`
- Start container and connect to it `docker start -i mb-gnuradio`
- Clone gr-sigmf `git clone https://github.com/skysafe/gr-sigmf`
- `cd gr-sigmf`
- `mkdir build`
- `cd build`
- `cmake ..`
- `make`
- `make install`
- `ldconfig`
- Stop running container

## More

### Audio Output

- Use UDP Sink in GNU Radio and `nc -l -u 0.0.0.0 7360 | play -t raw -esigned-integer -b 16 -r 48000 -` on your host
- (alternative) Use Wave-File Sink in GNU Radio

### Editor

- Use `/usr/bin/gvim` as editor in GNU Radio