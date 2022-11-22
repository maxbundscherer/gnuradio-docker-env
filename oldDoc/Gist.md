# GNU Radio in M1 Macs (with Docker Desktop)

This note describes the steps we took with the SETI Institute summer interns 2021 to install GNU Radio
in their M1 Macs (MacBook Air M1 2020 model). We used [gnuradio-docker-env](https://github.com/igorauad/gnuradio-docker-env)
as a starting point, which was of invaluable help.

There might be omissions, typos, etc., in this note, so any feedback is welcome. The procedure could also be streamlined
a lot by generating known-good images and pushing the to Docker Hub.

## XQuartz

XQuartz is needed to run X11 applications in the Docker container. The steps to set it up are:

1. Install XQuartz
2. In the XQuartz preferences, go to the "Security" tab and enable "Allow connections from network clients"
3. Reboot the machine

We found that it was important to reboot the machine for the "Allow connections from network clients" setting to be applied.

On each boot, it is necessary to launch XQuartz and then run
```
xhost + 127.0.0.1
```

in a terminal. This will allow connections from the Docker container to XQuartz. **Note:** something more involved
is recommended in the README for gnuradio-docker-env, which involves using `tcpdump` to check which IP the X11 packets
come from. We found that these always seem to come from `localhost`, so using `127.0.0.1` seems a good bet, but your
luck may vary. To debug, it's possible to use `xhost +`, which will allow connections from any IP (this is potentially
insecure).

## Docker Desktop

1. Install Docker Desktop following the [instructions](https://docs.docker.com/docker-for-mac/install/)
2. It is recommended to increase the number of CPUs and RAM available to Docker. This can be done in the preferences of
   the Docker Desktop GUI. We decided to use 8 CPUs and 6 GB of RAM for the M1 laptops (the machine has a total of 8
   cores and 8 GB of RAM).
   
On each boot, the Docker Desktop application needs to be run. Then it is possible to interact with Docker by using
the different `docker` command in a terminal.

## Testing XQuartz + Docker

Use the following to test that Docker is able to run GUI applications that display on the MacOS screen:
```
docker run -e DISPLAY=host.docker.internal:0 gns3/xeyes
```

This should show up a window with a pair of eyes that follow the mouse. If there are problems, besides the
gnuradio-docker-env README, another good resource can be
[this note](https://gist.github.com/cschiewek/246a244ba23da8b9f0e7b11a68bf3285).


## Ubuntu Docker image for GNU Radio

The [gnuradio-docker-env](https://github.com/igorauad/gnuradio-docker-env) comes with a `Dockerfile` of an Ubuntu
image with the build dependencies of GNU Radio installed. There is also a `docker-compose.yml` file, as this image is
intended to be used with docker-compose. We decided not to use docker-compose, to keep things simpler should problems
arise (mainly my fault, since I'm not experienced with docker-compose).

The steps to build the image and launch the container manually are as follow.

1. Clone the gnuradio-docker-env repo:
```
git clone https://github.com/igorauad/gnuradio-docker-env
```

2. Build the image. Inside the `gnuradio-docker-env` directory run:
```
docker build -t gnuradio .
```

(here `gnuradio` will only be used to give a name to the image).

3. Run the image to create a container:
```
docker run --name gnuradio -it gnuradio
```

(here `gnuradio` is just to give a name to the container, and `-it` are the parameters used to get a terminal session
in the container).

**Note:** when installing this with the interns we didn't give the image or container a name (my fault!). The existing
images can be renamed by doing `docker tag IMAGE_ID gnuradio` (the `IMAGE_ID` can be seen by running `docker images`).
The existing container can be renamed with `docker rename current_name gnuradio` (the current name can be seen by
running `docker container ls -a`).

## Running the container again

When we exit the container (because we close the terminal, reboot the machine or any other reason), we can run again
the existing container (plus all modifications we have made since its creation) with
```
docker start -i gnuradio
```

## Building and installing GNU Radio

1. First we install some packages that we will need:
```
sudo apt install nano swig libczmq
```

2. We decided to build GNU Radio 3.8 from source. The basic instructions are
[here](https://wiki.gnuradio.org/index.php/InstallingGR#For_GNU_Radio_3.8_or_Earlier). Installing a more modern
version of GNU Radio 3.9 is similar (although SWIG is not required for GNU Radio 3.9 and later).

3. Clone the GNU Radio repo
```
git clone https://github.com/gnuradio/gnuradio
```

4. Checkout the 3.8 tag (at this time v3.8.3.1 is the latest release, so that's what we installed)
```
cd gnuradio
git checkout v3.8.3.1
git submodule update --init --recursive
```

4. Run cmake
```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 ..
```

5. At this point watch out for the output of `cmake`. In particular, any GNU Radio components that might have
been disabled because of unmet dependencies. In fact we had to install `swig` to have Python support (which
includes `gnuradio-companion`).

6. Build with
```
make -j4
```
It takes perhaps about 30 minutes to build on the 2020 MacBook with `-j4`. Watch out, since
it's possible to get out of RAM while building, which will most likely cause the C compiler to be killed (and the
build will stop). With `-j8` you're very likely to get out of RAM with only 8 GB, so something around `-j4` seems
safer.

7. Install with
```
make install
ldconfig
```
(since we're running as root inside the Docker container, it is not necessary to use `sudo`).

## Final configuration

We needed to add a few environment variables to `/root/.bashrc`. For this, we do
```
nano /root/.bashrc
```
and add the following lines at the end of the file:
```
export DISPLAY=host.docker.internal:0
export GRC_BLOCKS_PATH=/usr/local/share/gnuradio/grc/blocks
export PYTHONPATH=/usr/local/lib/python3/dist-packages/
```
After modifying the `.bashrc` file, the easiest way to apply the settings is to log out of the
container with Ctrl+D and log in again with `docker start` as described above.

## Running GNU Radio Companion

If everything went well, at this point we can run
```
gnuradio-companion
```
inside the docker container and have a functional GNU Radio companion window on our Mac OS screen.

If something doesn't work well and the X11 + XQuartz is suspect, it's possible to install and run `xterm`, which prints
more debug information than `gnuradio-companion`.

## TODO

There are a number of things that can be done to make this Docker setup easier/better to use. We didn't cover any
of them, as we were uncertain if we could solve all the issues we found during a 2 hour hands-on session with the
interns (but we managed!).

Some of these are:

1. Turn our container into a docker image using
[docker commmit](https://docs.docker.com/engine/reference/commandline/commit/). This will allow us to have
something that can be shared more easily, and to have a way of regenerating the container if we break something.
The image can be shared in Docker hub so that other people can run this much faster (without having to build
GNU Radio on their machine).

2. Set up a [bind mount](https://docs.docker.com/storage/bind-mounts/) to share some folders between the Mac OS host
and the GNU Radio container, and/or set up a [volume](https://docs.docker.com/storage/volumes/) to store our work
(GNU Radio flowgraphs, etc.) in some container-independent and persistent space.

3. Instead of having the same container lying around, always launch the container from the image using `--rm` to
delete the container when we stop it. This can be seen as a good practice because the state of the container is
always repeatable and known in advance. Doing this requires a bind mount or volume so that we can store our work
persistently across container destructions and creations.