docker run --name mb-gnuradio \
    -v "$(pwd)"/mount-gr_persistent:/home/gnuradio/persistent/ \
    -v /Volumes/MBU-Drive/Radio-Exp-Rec/Radio-Exp-05-06-24/thomasRec:/home/gnuradio/tmpFiles/ \
    -it mb-gnuradio-image

exit

docker run --name mb-gnuradio \
    -v "$(pwd)"/mount-gr_persistent:/home/gnuradio/persistent/ \
    -v /Volumes/MBU-Drive/Radio-Exp-Rec/Radio-Exp-28-03-24/ResFile:/home/gnuradio/tmpFiles/ \
    -it mb-gnuradio-image


docker run --name mb-gnuradio \
    -v "$(pwd)"/mount-gr_persistent:/home/gnuradio/persistent/ \
    -v /Volumes/MBU-Drive/Record:/home/gnuradio/tmpFiles/ \
    -it mb-gnuradio-image