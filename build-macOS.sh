cp dockerfiles/Dockerfile-macOS Dockerfile

docker build -t mb-gnuradio-image .

rm Dockerfile

docker run --name mb-gnuradio \
    -v "$(pwd)"/mount-gr_persistent:/home/gnuradio/persistent/ \
    -it mb-gnuradio-image