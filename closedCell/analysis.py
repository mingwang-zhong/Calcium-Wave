import sys
import vtk
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from numpy.fft import fft, ifft, fftn, fftshift
from vtk.util.numpy_support import vtk_to_numpy
matplotlib.use("Agg")
matplotlib.rcParams['text.usetex'] = True # latex equation
matplotlib.rcParams['text.latex.preamble']=r"\usepackage{amsmath}" # bold symbol


result = np.zeros((16,4)) # row: ci, first column: total Ca, second column: ci
for i in np.arange(16):
    ci = (i+1)*0.05
    print(ci)
    wholecell = np.loadtxt("Hill7_alpha0.2_beta0.004_cstar1.1/ci%g/wholecell.txt"%(ci))
    result[i, 0] = ci
    result[i, 1] = np.mean( wholecell[2:None,38] ) # total Ca
    result[i, 2] = np.mean( wholecell[4000:None,1] ) # mean ci
    result[i, 3] = np.mean( wholecell[4000:None,4] ) # mean cj

np.savetxt("meanCai_vs_totalCa_ci.txt", result, fmt='%g', delimiter='\t')





result = np.zeros((15,4)) # row: ci, first column: total Ca, second column: ci
for i in np.arange(15):
    cstar = (i+1)*0.2
    print(cstar)
    wholecell = np.loadtxt("Hill7_alpha0.2_beta0.004_cstar%g/ci0.4/wholecell.txt"%(cstar))
    result[i, 0] = cstar
    result[i, 1] = np.mean( wholecell[2:None,38] ) # total Ca
    result[i, 2] = np.mean( wholecell[4000:None,1] ) # mean ci
    result[i, 3] = np.mean( wholecell[4000:None,4] ) # mean cj

np.savetxt("meanCai_vs_totalCa_cstar.txt", result, fmt='%g', delimiter='\t')


