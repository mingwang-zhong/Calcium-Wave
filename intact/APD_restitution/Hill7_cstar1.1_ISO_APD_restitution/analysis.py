import numpy as np
import numba as nb
import matplotlib
# matplotlib.use("Agg")
matplotlib.rcParams['text.usetex'] = True # latex equation
matplotlib.rcParams['text.latex.preamble']=r"\usepackage{amsmath}" # bold symbol
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from mpl_toolkits.axes_grid1.inset_locator import inset_axes
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter,
                               AutoMinorLocator)
from mpl_toolkits.axes_grid1.anchored_artists import AnchoredSizeBar
from matplotlib.colors import ListedColormap, LinearSegmentedColormap
import matplotlib.font_manager as fm
import os
import sys
import cv2




num_run = 20
Vm90 = -72.3 # voltage at APD_90

APD_hyper = np.zeros((num_run,3))
DI_hyper = np.zeros((num_run,3))

for i in np.arange(num_run):

    start_s2 = i*20+5380
    data = np.loadtxt('../Hill7_cstar1.1_ISO_APD_restitution_0.5s/S2_%d/wholecell.txt'%(start_s2))
    end_s1 = np.where( data[5200:None, 6]<Vm90 )[0][0] + 5200
    DI_hyper[i,0] = start_s2 - end_s1
    end_s2 = np.where( data[(start_s2+50):None, 6]<Vm90 )[0][0] + start_s2+50
    APD_hyper[i,0] = end_s2 - start_s2

    start_s2 = i*20+10400
    data = np.loadtxt('../Hill7_cstar1.1_ISO_APD_restitution_1s/S2_%d/wholecell.txt'%(start_s2))
    end_s1 = np.where( data[10200:None, 6]<Vm90 )[0][0] + 10200
    DI_hyper[i,1] = start_s2 - end_s1
    end_s2 = np.where( data[(start_s2+50):None, 6]<Vm90 )[0][0] + start_s2+50
    APD_hyper[i,1] = end_s2 - start_s2

    start_s2 = i*20+12360
    data = np.loadtxt('S2_%d/wholecell.txt'%(start_s2))
    end_s1 = np.where( data[12200:None, 6]<Vm90 )[0][0] + 12200
    DI_hyper[i,2] = start_s2 - end_s1
    end_s2 = np.where( data[(start_s2+50):None, 6]<Vm90 )[0][0] + start_s2+50
    APD_hyper[i,2] = end_s2 - start_s2




APD_stable = np.zeros((num_run,3))
DI_stable = np.zeros((num_run,3))

for i in np.arange(num_run):

    start_s2 = i*20+5280
    data = np.loadtxt('../Hill12_cstar3.5_APD_restitution_0.5s/S2_%d/wholecell.txt'%(start_s2))
    end_s1 = np.where( data[5200:None, 6]<Vm90 )[0][0] + 5200
    DI_stable[i,0] = start_s2 - end_s1
    end_s2 = np.where( data[(start_s2+50):None, 6]<Vm90 )[0][0] + start_s2+50
    APD_stable[i,0] = end_s2 - start_s2

    start_s2 = i*20+10300
    data = np.loadtxt('../Hill12_cstar3.5_APD_restitution_1s/S2_%d/wholecell.txt'%(start_s2))
    end_s1 = np.where( data[10200:None, 6]<Vm90 )[0][0] + 10200
    DI_stable[i,1] = start_s2 - end_s1
    end_s2 = np.where( data[(start_s2+50):None, 6]<Vm90 )[0][0] + start_s2+50
    APD_stable[i,1] = end_s2 - start_s2

    start_s2 = i*20+12300
    data = np.loadtxt('../Hill12_cstar3.5_APD_restitution/S2_%d/wholecell.txt'%(start_s2))
    end_s1 = np.where( data[12200:None, 6]<Vm90 )[0][0] + 12200
    DI_stable[i,2] = start_s2 - end_s1
    end_s2 = np.where( data[(start_s2+50):None, 6]<Vm90 )[0][0] + start_s2+50
    APD_stable[i,2] = end_s2 - start_s2


np.savetxt('APD_DI_stableRyR.txt', np.hstack((DI_stable, APD_stable)), fmt='%g', delimiter='\t')
np.savetxt('APD_DI_hyperRyR.txt', np.hstack((DI_hyper, APD_hyper)), fmt='%g', delimiter='\t')

####################################################################################
#################################################################################### figure
####################################################################################

fig, ax = plt.subplots(figsize=(4,3))

ax.set_position([0.15, 0.15, 0.84, 0.84 ])
for axis in ['top','bottom','left','right']:
    ax.spines[axis].set_linewidth(0.5)
ax.tick_params(which='major', width=0.5, length=3)
ax.tick_params(which='minor', width=0.5, length=2)
plt.rcParams["font.family"] = "serif"

ax.plot(DI_stable[:,0], APD_stable[:,0], '-s', lw=0.7, ms=3, mfc='C0', mec='C0', label=r'PCL = 0.5 s' )
ax.plot(DI_stable[:,1], APD_stable[:,1], '-o', lw=0.7, ms=3, mfc='C1', mec='C1', label=r'PCL = 1 s' )
ax.plot(DI_stable[:,2], APD_stable[:,2], '-^', lw=0.7, ms=3, mfc='C2', mec='C2', label=r'PCL = 2 s' )

ax.set_xlabel(r'DI $(ms)$')
# ax.set_xlim([-10, 200])
# ax.set_xticks(np.arange(0,2001,500))

ax.set_ylabel(r'APD$_{90}$ $(ms)$')
# ax.set_yticks(np.arange(0,2001,500))

ax.set_title(r'Control, H = 12')

ax.legend(loc='best', frameon=False)

file="temp.pdf"
file_final="APD_restitution_stableRyR.pdf"
plt.savefig(file)

# compress pdf 
import os
os.system('gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile='
  + file_final + ' ' + file)
os.system('rm '+ file)

####################################################################################
#################################################################################### figure
####################################################################################

fig, ax = plt.subplots(figsize=(4,3))

ax.set_position([0.15, 0.15, 0.84, 0.84 ])
for axis in ['top','bottom','left','right']:
    ax.spines[axis].set_linewidth(0.5)
ax.tick_params(which='major', width=0.5, length=3)
ax.tick_params(which='minor', width=0.5, length=2)
plt.rcParams["font.family"] = "serif"

ax.plot(DI_hyper[:,0], APD_hyper[:,0], '-s', lw=0.7, ms=3, mfc='C0', mec='C0', label=r'PCL = 0.5 s' )
ax.plot(DI_hyper[:,1], APD_hyper[:,1], '-o', lw=0.7, ms=3, mfc='C1', mec='C1', label=r'PCL = 1 s' )
ax.plot(DI_hyper[:,2], APD_hyper[:,2], '-^', lw=0.7, ms=3, mfc='C2', mec='C2', label=r'PCL = 2 s' )

ax.set_xlabel(r'DI $(ms)$')
ax.set_xlim([-10, 430])
# ax.set_xticks(np.arange(0,2001,500))

ax.set_ylabel(r'APD$_{90}$ $(ms)$')
# ax.set_yticks(np.arange(0,2001,500))

ax.set_title(r'Caffeine+ISO, H = 7')

ax.legend(loc='best', frameon=False)

file="temp.pdf"
file_final="APD_restitution_hyperRyR.pdf"
plt.savefig(file)

# compress pdf 
import os
os.system('gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile='
  + file_final + ' ' + file)
os.system('rm '+ file)
