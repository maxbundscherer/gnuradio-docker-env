cp dockerfiles/Dockerfile-ubuntuHPC Dockerfile

docker build -t mb-gnuradio-image .

rm Dockerfile

mkdir mount-gr_persistent
chmod 777 -R mount-gr_persistent

docker run --name mb-gnuradio \
    -v "$(pwd)"/mount-gr_persistent:/home/gnuradio/persistent/ \
    -it mb-gnuradio-image