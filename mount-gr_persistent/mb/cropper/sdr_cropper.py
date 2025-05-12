#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#
# SPDX-License-Identifier: GPL-3.0
#
# GNU Radio Python Flow Graph
# Title: sdr_cropper
# Author: root
# GNU Radio version: 3.9.4.0

from gnuradio import analog
from gnuradio import blocks
import pmt
from gnuradio import filter
from gnuradio.filter import firdes
from gnuradio import gr
from gnuradio.fft import window
import sys
import signal
from argparse import ArgumentParser
from gnuradio.eng_arg import eng_float, intx
from gnuradio import eng_notation




class sdr_cropper(gr.top_block):

    def __init__(self, center_freq_file=0, crp_channel_freq=-5e3, crp_channel_width=0.6e3, file_name_in="testfiles/baudot.bin", file_name_out="testfiles/baudot-cropped.bin", samp_rate_file=44100, samp_rate_out=8e3):
        gr.top_block.__init__(self, "sdr_cropper", catch_exceptions=True)

        ##################################################
        # Parameters
        ##################################################
        self.center_freq_file = center_freq_file
        self.crp_channel_freq = crp_channel_freq
        self.crp_channel_width = crp_channel_width
        self.file_name_in = file_name_in
        self.file_name_out = file_name_out
        self.samp_rate_file = samp_rate_file
        self.samp_rate_out = samp_rate_out

        ##################################################
        # Blocks
        ##################################################
        self.mmse_resampler_xx_0_1_0_0 = filter.mmse_resampler_cc(0, samp_rate_file/samp_rate_out)
        self.low_pass_filter_0_0_0 = filter.fir_filter_ccf(
            1,
            firdes.low_pass(
                1,
                samp_rate_out,
                crp_channel_width * 0.5,
                crp_channel_width * 0.1,
                window.WIN_HAMMING,
                6.76))
        self.blocks_multiply_xx_0_0_0_0 = blocks.multiply_vcc(1)
        self.blocks_file_source_0_0 = blocks.file_source(gr.sizeof_gr_complex*1, file_name_in, False, 0, 0)
        self.blocks_file_source_0_0.set_begin_tag(pmt.PMT_NIL)
        self.blocks_file_sink_0_0_0 = blocks.file_sink(gr.sizeof_gr_complex*1, file_name_out, False)
        self.blocks_file_sink_0_0_0.set_unbuffered(False)
        self.analog_sig_source_x_0_0 = analog.sig_source_c(samp_rate_file, analog.GR_COS_WAVE, center_freq_file - crp_channel_freq, 1, 0, 0)



        ##################################################
        # Connections
        ##################################################
        self.connect((self.analog_sig_source_x_0_0, 0), (self.blocks_multiply_xx_0_0_0_0, 1))
        self.connect((self.blocks_file_source_0_0, 0), (self.blocks_multiply_xx_0_0_0_0, 0))
        self.connect((self.blocks_multiply_xx_0_0_0_0, 0), (self.mmse_resampler_xx_0_1_0_0, 0))
        self.connect((self.low_pass_filter_0_0_0, 0), (self.blocks_file_sink_0_0_0, 0))
        self.connect((self.mmse_resampler_xx_0_1_0_0, 0), (self.low_pass_filter_0_0_0, 0))


    def get_center_freq_file(self):
        return self.center_freq_file

    def set_center_freq_file(self, center_freq_file):
        self.center_freq_file = center_freq_file
        self.analog_sig_source_x_0_0.set_frequency(self.center_freq_file - self.crp_channel_freq)

    def get_crp_channel_freq(self):
        return self.crp_channel_freq

    def set_crp_channel_freq(self, crp_channel_freq):
        self.crp_channel_freq = crp_channel_freq
        self.analog_sig_source_x_0_0.set_frequency(self.center_freq_file - self.crp_channel_freq)

    def get_crp_channel_width(self):
        return self.crp_channel_width

    def set_crp_channel_width(self, crp_channel_width):
        self.crp_channel_width = crp_channel_width
        self.low_pass_filter_0_0_0.set_taps(firdes.low_pass(1, self.samp_rate_out, self.crp_channel_width * 0.5, self.crp_channel_width * 0.1, window.WIN_HAMMING, 6.76))

    def get_file_name_in(self):
        return self.file_name_in

    def set_file_name_in(self, file_name_in):
        self.file_name_in = file_name_in
        self.blocks_file_source_0_0.open(self.file_name_in, False)

    def get_file_name_out(self):
        return self.file_name_out

    def set_file_name_out(self, file_name_out):
        self.file_name_out = file_name_out
        self.blocks_file_sink_0_0_0.open(self.file_name_out)

    def get_samp_rate_file(self):
        return self.samp_rate_file

    def set_samp_rate_file(self, samp_rate_file):
        self.samp_rate_file = samp_rate_file
        self.analog_sig_source_x_0_0.set_sampling_freq(self.samp_rate_file)
        self.mmse_resampler_xx_0_1_0_0.set_resamp_ratio(self.samp_rate_file/self.samp_rate_out)

    def get_samp_rate_out(self):
        return self.samp_rate_out

    def set_samp_rate_out(self, samp_rate_out):
        self.samp_rate_out = samp_rate_out
        self.low_pass_filter_0_0_0.set_taps(firdes.low_pass(1, self.samp_rate_out, self.crp_channel_width * 0.5, self.crp_channel_width * 0.1, window.WIN_HAMMING, 6.76))
        self.mmse_resampler_xx_0_1_0_0.set_resamp_ratio(self.samp_rate_file/self.samp_rate_out)



def argument_parser():
    parser = ArgumentParser()
    parser.add_argument(
        "--center-freq-file", dest="center_freq_file", type=eng_float, default=eng_notation.num_to_str(float(0)),
        help="Set center_freq_file [default=%(default)r]")
    parser.add_argument(
        "--crp-channel-freq", dest="crp_channel_freq", type=eng_float, default=eng_notation.num_to_str(float(-5e3)),
        help="Set crp_channel_freq [default=%(default)r]")
    parser.add_argument(
        "--crp-channel-width", dest="crp_channel_width", type=eng_float, default=eng_notation.num_to_str(float(0.6e3)),
        help="Set crp_channel_width [default=%(default)r]")
    parser.add_argument(
        "--file-name-in", dest="file_name_in", type=str, default="testfiles/baudot.bin",
        help="Set testfiles/baudot.bin [default=%(default)r]")
    parser.add_argument(
        "--file-name-out", dest="file_name_out", type=str, default="testfiles/baudot-cropped.bin",
        help="Set testfiles/baudot-cropped.bin [default=%(default)r]")
    parser.add_argument(
        "--samp-rate-file", dest="samp_rate_file", type=eng_float, default=eng_notation.num_to_str(float(44100)),
        help="Set samp_rate_file [default=%(default)r]")
    parser.add_argument(
        "--samp-rate-out", dest="samp_rate_out", type=eng_float, default=eng_notation.num_to_str(float(8e3)),
        help="Set samp_rate_out [default=%(default)r]")
    return parser


def main(top_block_cls=sdr_cropper, options=None):
    if options is None:
        options = argument_parser().parse_args()
    tb = top_block_cls(center_freq_file=options.center_freq_file, crp_channel_freq=options.crp_channel_freq, crp_channel_width=options.crp_channel_width, file_name_in=options.file_name_in, file_name_out=options.file_name_out, samp_rate_file=options.samp_rate_file, samp_rate_out=options.samp_rate_out)

    def sig_handler(sig=None, frame=None):
        tb.stop()
        tb.wait()

        sys.exit(0)

    signal.signal(signal.SIGINT, sig_handler)
    signal.signal(signal.SIGTERM, sig_handler)

    tb.start()

    tb.wait()


if __name__ == '__main__':
    main()
