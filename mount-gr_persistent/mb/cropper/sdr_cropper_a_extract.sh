# First

echo "Start Extracting"

echo
echo "[RTL FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/gqrx_20240605_092523_144675000_1000000_fc.raw" \
    --file-name-out "/home/gnuradio/tmpFiles/out-gqrx_20240605_092523_144855000_20000_fc.raw" \
    --samp-rate-file "1000000.0" \
    --center-freq-file "144675000.0" \
    --crp-channel-freq "144855000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"  

echo "Stop Extracting"

exit

# Third tx

echo
echo "[RTL FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/gqrx_20240514_060802_431250000_1000000_fc.raw" \
    --file-name-out "/home/gnuradio/tmpFiles/out-rtl_gqrx_20240514_060802_431023000_20000_fc.raw" \
    --samp-rate-file "1000000.0" \
    --center-freq-file "431250000.0" \
    --crp-channel-freq "431023000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"  

echo
echo "[HackRF FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/gqrx_20240514_075730_431250000_1000000_fc.raw" \
    --file-name-out "/home/gnuradio/tmpFiles/out-hackrf_gqrx_20240514_075730_431023000_20000_fc.raw" \
    --samp-rate-file "1000000.0" \
    --center-freq-file "431250000.0" \
    --crp-channel-freq "431023000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"  

# Second tx

echo
echo "[RTL FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/rtl_gqrx_20240328_144934_431250000_1800000_fc.raw" \
    --file-name-out "/home/gnuradio/tmpFiles/out-rtl_gqrx_20240328_144934_431018000_20000_fc.raw" \
    --samp-rate-file "1800000.0" \
    --center-freq-file "431250000.0" \
    --crp-channel-freq "431018000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"  
 
echo
echo "[HackRF FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/hackrf_gqrx_20240328_144935_431250000_8000000_fc.raw" \
    --file-name-out "/home/gnuradio/tmpFiles/out-hackrf_gqrx_20240328_144935_431018000_20000_fc.raw" \
    --samp-rate-file "8000000.0" \
    --center-freq-file "431250000.0" \
    --crp-channel-freq "431018000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"  
 