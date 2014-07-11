import os
import pdb
import platform
import warnings
import ctypes as ct
import numpy as np
from cudamat import check_error

if platform.system() == 'Windows':
    _cudalearn = ct.cdll.LoadLibrary('libcudalearn.dll')
else:
    _cudalearn = ct.cdll.LoadLibrary(os.path.join(os.path.dirname(__file__) or os.path.curdir, 'libcudalearn.so'))

_cudalearn.mult_by_sigmoid_deriv.restype = ct.c_int

def mult_by_sigmoid_deriv(target, acts):
    """
    target = target * acts * (1 - acts)

    Useful for doing backprop in neural networks with logistic units.
    """

    check_error(_cudalearn.mult_by_sigmoid_deriv(target.p_mat, acts.p_mat))
