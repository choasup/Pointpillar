import _init_paths
import os
import numpy as np
from easydict import EasyDict as edict
import os.path as osp
# VARIABLES
# -- TRAIN

def make_link(dest_path, link_path):
    if os.path.islink(link_path):
        os.system('rm {}'.format(link_path))
    os.system('ln -s {} {}'.format(dest_path, link_path))

def get_output_dir():
    outdir = os.path.join(os.path.abspath(os.path.dirname(__file__)), '..', '..', 'outputs')     
    cur_dir = os.path.abspath(os.path.dirname(__file__))
   
    model_name = cur_dir.split('/')[-1]
    log_dir = os.path.join(outdir, model_name) 
    
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)
        make_link(log_dir, './log')
        print("LOG PATH:", log_dir)
    return outdir

if __name__ == '__main__':
    get_output_dir()
