'''
from __future__ import print_function

import sys
import os
import time
from argparse import ArgumentParser

import numpy as np
np.random.seed(1234)  # for reproducibility

# specifying the gpu to use
# import theano.sandbox.cuda
# theano.sandbox.cuda.use('gpu1') 
import theano
import theano.tensor as T

import lasagne

import cPickle as pickle
import gzip

import quantized_net
import lfc

#from pylearn2.datasets.mnist import MNIST
#from pylearn2.utils import serial

from collections import OrderedDict
'''
import lasagne

