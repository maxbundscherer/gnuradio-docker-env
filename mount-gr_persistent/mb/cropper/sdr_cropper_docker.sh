#In Docker!

samp_rate_file=$1
center_freq_file=$2
crp_channel_freq=$3
crp_channel_width=$4
samp_rate_out=$5

cd /home/gnuradio/persistent/auto/cropper

echo "Sample Rate File '$samp_rate_file'"
echo "Center Freq File '$center_freq_file'"
echo "Crop Channel Freq '$crp_channel_freq'"
echo "Crop Channel Width '$crp_channel_width'"
echo "Sample Rate Out '$samp_rate_out'"

echo "Start cropping..."

/usr/bin/python3 sdr_cropper.py \
    --file-name-in "in.bin" \
    --file-name-out "out.bin" \
    --samp-rate-file "$samp_rate_file" \
    --center-freq-file "$center_freq_file" \
    --crp-channel-freq "$crp_channel_freq" \
    --crp-channel-width "$crp_channel_width" \
    --samp-rate-out "$samp_rate_out"

echo "Finished cropping..."
