from _util import _print
t = _print("Loading os")
import os
import socket
HOSTNAME = socket.gethostname()
import datetime

t = _print(f"{os.getenv('PMIX_RANK')}: Loading tensorflow", t)
from tensorflow import keras
import tensorflow as tf

t = _print(f"{os.getenv('PMIX_RANK')}: Loading argparse", t)
import argparse

psr = argparse.ArgumentParser(description="input dataframe file")
psr.add_argument("--infile", default="infile",
                 help="a file of filenames indexed with world rank")
args = vars(psr.parse_args())
t = _print(f"{os.getenv('PMIX_RANK')}: {args}", t)

with open (os.getenv('PMIX_RANK'), 'w') as f:
    f.write('{} {} PMIX_RANK, {} ZE_AFFINITY_MASK, {} HOSTNAME'.format(
        datetime.datetime.now(),
        os.getenv('PMIX_RANK'),
        os.environ['ZE_AFFINITY_MASK'],
        HOSTNAME)
    )
    f.close()


os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
print('{} PMIX_RANK, {} ZE_AFFINITY_MASK, {} HOSTNAME'.format(
    os.getenv
    ('PMIX_RANK'), os.environ['ZE_AFFINITY_MASK'], HOSTNAME))


t = _print('{}: using tensorflow {}'.format(os.getenv('PMIX_RANK'), tf.__version__), t)


with open(args['infile']) as infile:
    lines = [line.rstrip() for line in infile]
    t = _print("{}: infile={}".format(os.getenv('PMIX_RANK'),
                                 lines[int(os.getenv('PMIX_RANK'))]), t)


strategy = tf.distribute.MirroredStrategy()
t = _print('{}: Number of devices: {}'.format(
    os.getenv('PMIX_RANK'), strategy.num_replicas_in_sync), t)

with strategy.scope():
    t = _print("{}: defining and compiling model".format(os.getenv('PMIX_RANK')), t)
    # your model is defined here
    # your model is compiled here

t = _print("{}: calling model.fit".format(os.getenv('PMIX_RANK')))
# define call backs
# call model.fit

t = _print("{}: done calling model.fit".format(os.getenv('PMIX_RANK')), t)
