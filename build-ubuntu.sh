cp dockerfiles/Dockerfile-ubuntu Dockerfile

docker build -t mb-gnuradio-image .

rm Dockerfile

docker run --name mb-gnuradio \
    -v "$(pwd)"/mount-gr_persistent:/home/gnuradio/persistent/ \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=$DISPLAY \
    --device /dev/bus/usb \
    -it mb-gnuradio-image