# 8 tx

echo "Start Extracting"

echo
echo "[REC01]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/rec01/Recording--9222984412315324408-1747591878768749.bin" \
    --file-name-out "/home/gnuradio/tmpFiles/rec01/out-rec01-Recording--9222984412315324408-1747591878768749.bin" \
    --samp-rate-file "125122.0" \
    --center-freq-file "21117000.0" \
    --crp-channel-freq "21116500.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"

echo
echo "[REC02]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/rec02/Recording--9222984400849051008-1747591886965416.bin" \
    --file-name-out "/home/gnuradio/tmpFiles/rec02/out-rec02-Recording--9222984400849051008-1747591886965416.bin" \
    --samp-rate-file "125122.0" \
    --center-freq-file "21117000.0" \
    --crp-channel-freq "21116500.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"

echo "Stop Extracting"
exit

# 7 tx

echo "Start Extracting"

echo
echo "[MB FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/gqrx_20250515_082642_144750000_1000000_fc.raw" \
    --file-name-out "/home/gnuradio/tmpFiles/out-gqrx_20250515_082642_144872000_20000_fc.raw" \
    --samp-rate-file "1000000.0" \
    --center-freq-file "144750000.0" \
    --crp-channel-freq "144872000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"


# Six tx

echo "Start Extracting"

echo
echo "[SAAB FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/Recording--9209219564926794108-1746696190891347.bin" \
    --file-name-out "/home/gnuradio/tmpFiles/out-Recording--9209219564926794108-1746696190891347.bin" \
    --samp-rate-file "125122.0" \
    --center-freq-file "3618500.0" \
    --crp-channel-freq "3617000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"

# Fifth tx

echo
echo "[SAAB FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/Recording--9223298801690170108-1723720731137887.bin" \
    --file-name-out "/home/gnuradio/tmpFiles/out-Recording--9223298801690170108-1723720731137887.bin" \
    --samp-rate-file "250244.0" \
    --center-freq-file "439619000.0" \
    --crp-channel-freq "439620000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"

echo
echo "[RTL FILE]"
/usr/bin/python3 sdr_cropper.py \
    --file-name-in "/home/gnuradio/tmpFiles/gqrx_20240815_111850_439400000_1000000_fc.raw" \
    --file-name-out "/home/gnuradio/tmpFiles/out-gqrx_20240815_111850_439620000_20000_fc.raw" \
    --samp-rate-file "1000000.0" \
    --center-freq-file "439400000.0" \
    --crp-channel-freq "439620000.0" \
    --crp-channel-width "20000.0" \
    --samp-rate-out "20000.0"

# Fourth tx

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
 