import numpy as np
import matplotlib
matplotlib.use("Agg")
# matplotlib.rcParams['text.usetex'] = True # latex equation
# matplotlib.rcParams['text.latex.preamble']=r"\usepackage{amsmath}" # bold symbol
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





def template_image(ax):
    ax.spines["top"].set_linewidth(0.7) # border, 'None' to remove the border
    ax.spines["bottom"].set_linewidth(0.7)
    ax.spines["left"].set_linewidth(0.7)
    ax.spines["right"].set_linewidth(0.7)
    ax.tick_params(which='major', width=0.7, length=1.5)
    ax.tick_params(which='minor', width=0.7, length=1)



ci_array = np.arange(0,2.9,0.2)
ci_array[0] = 0.1
num_ci = len(ci_array)
result = np.zeros((num_ci, 3)) # time_to_1st_spark, cp, cj

for i in np.arange(num_ci):
    for j in np.arange(3):

        ci = ci_array[i]
        data = np.loadtxt('ci%g_cj800/time_to_1st_spark.txt'%(ci))
        result[i, j] = np.mean(data[:,j], axis=0)

np.savetxt('result.txt', result, delimiter='\t', fmt='%f')





bins=20

num_rows = 3
num_cols = 5

originx=0.03
shiftx=0.03
sizex=(0.99-originx-(num_cols-1)*shiftx)/num_cols

originy=0.07
shifty=0.03
sizey=(0.98-originy-(num_rows-1)*shiftx)/num_rows

o=0
############################################################
############################################################ theta
fig, axs = plt.subplots(nrows=num_rows, ncols=num_cols, figsize=(num_cols*3,num_rows*2.6))

for j in np.arange(num_rows):
    for i in np.arange(num_cols):

        ax = axs[j,i]

        ci = ci_array[j*num_cols+i]

        data = np.loadtxt('ci%g_cj800/time_to_1st_spark.txt'%(ci))

        y,x,_=ax.hist(data[:,o], bins=bins, lw=0.5, density=False, stacked=True, color='C0', ec='k', alpha=0.9, label='')
        ax.text(0.95, 0.95, r'c$_O$ = %g $\mu$M'%(ci), fontsize=16, ha='right', va='top', color='k', transform=ax.transAxes)
        ax.text(0.95, 0.83, r'c$_p$ = %.2f $\mu$M'%(result[j*num_cols+i, 1]), fontsize=16, ha='right', va='top', color='k', transform=ax.transAxes)
        ax.text(0.95, 0.71, r'c$_j$ = %.1f $\mu$M'%(result[j*num_cols+i, 2]), fontsize=16, ha='right', va='top', color='k', transform=ax.transAxes)
        ax.text(0.95, 0.59, r'%g ms'%(result[j*num_cols+i, 0]), fontsize=16, ha='right', va='top', color='k', transform=ax.transAxes)

        ax.set_position([ originx+i*(sizex+shiftx), originy+(num_rows-1-j)*(sizey+shifty), sizex, sizey ])
        template_image(ax)

        if j==num_rows-1 and i==2:
            ax.set_xlabel(r'Time to the first spark (ms)', fontsize=18)
        # ax.set_xlim(0,Nx)
        # ax.set_xlabel(r'$\boldsymbol{x}$'))
        # ax.set_xticks([])
        # ax.set_xticklabels(['0','100','200'])
        # ax.xaxis.set_minor_locator(MultipleLocator(50))

        # ax.set_ylim(0,Ny)
        # ax.set_ylabel(r'$\boldsymbol{y}$'))
        # ax.set_yticks([])
        # ax.set_yticklabels(['0','100','200','300','400','500'])
        # ax.yaxis.set_minor_locator(MultipleLocator(50))

        
################################
file="temp.pdf"
file_final="time_to_1st_spark_all.pdf"
plt.savefig(file)

# compress pdf 
os.system('gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile='
  + file_final + ' ' + file)
os.system('rm '+ file)



















o=1
############################################################
############################################################ theta
fig, axs = plt.subplots(nrows=num_rows, ncols=num_cols, figsize=(num_cols*3,num_rows*2.6))

for j in np.arange(num_rows):
    for i in np.arange(num_cols):

        ax = axs[j,i]

        ci = ci_array[j*num_cols+i]

        data = np.loadtxt('ci%g_cj800/time_to_1st_spark.txt'%(ci))

        y,x,_=ax.hist(data[:,o], bins=bins, lw=0.5, density=False, stacked=True, color='C0', ec='k', alpha=0.9, label='')
        ax.text(0.95, 0.95, r'%.2f $\mu$M'%(result[j*num_cols+i, 1]), fontsize=16, ha='right', va='top', color='k', transform=ax.transAxes)

        ax.set_position([ originx+i*(sizex+shiftx), originy+(num_rows-1-j)*(sizey+shifty), sizex, sizey ])
        template_image(ax)

        if j==num_rows-1 and i==2:
            ax.set_xlabel(r'c$_p$ ($\mu$M)', fontsize=18)
        # ax.set_xlim(0,Nx)
        # ax.set_xlabel(r'$\boldsymbol{x}$'))
        # ax.set_xticks([])
        # ax.set_xticklabels(['0','100','200'])
        # ax.xaxis.set_minor_locator(MultipleLocator(50))

        # ax.set_ylim(0,Ny)
        # ax.set_ylabel(r'$\boldsymbol{y}$'))
        # ax.set_yticks([])
        # ax.set_yticklabels(['0','100','200','300','400','500'])
        # ax.yaxis.set_minor_locator(MultipleLocator(50))

        
################################
file="temp.pdf"
file_final="cp_all.pdf"
plt.savefig(file)

# compress pdf 
os.system('gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile='
  + file_final + ' ' + file)
os.system('rm '+ file)


















o=2
############################################################
############################################################ theta
fig, axs = plt.subplots(nrows=num_rows, ncols=num_cols, figsize=(num_cols*3,num_rows*2.6))

for j in np.arange(num_rows):
    for i in np.arange(num_cols):

        ax = axs[j,i]

        ci = ci_array[j*num_cols+i]

        data = np.loadtxt('ci%g_cj800/time_to_1st_spark.txt'%(ci))

        y,x,_=ax.hist(data[:,o], bins=bins, lw=0.5, density=False, stacked=True, color='C0', ec='k', alpha=0.9, label='')
        ax.text(0.5, 0.95, r'%.2f $\mu$M'%(result[j*num_cols+i, 2]), fontsize=16, ha='center', va='top', color='k', transform=ax.transAxes)

        ax.set_position([ originx+i*(sizex+shiftx), originy+(num_rows-1-j)*(sizey+shifty), sizex, sizey ])
        template_image(ax)

        if j==num_rows-1 and i==2:
            ax.set_xlabel(r'c$_p$ ($\mu$M)', fontsize=18)
        # ax.set_xlim(0,Nx)
        # ax.set_xlabel(r'$\boldsymbol{x}$'))
        # ax.set_xticks([])
        # ax.set_xticklabels(['0','100','200'])
        # ax.xaxis.set_minor_locator(MultipleLocator(50))

        # ax.set_ylim(0,Ny)
        # ax.set_ylabel(r'$\boldsymbol{y}$'))
        # ax.set_yticks([])
        # ax.set_yticklabels(['0','100','200','300','400','500'])
        # ax.yaxis.set_minor_locator(MultipleLocator(50))

        
################################
file="temp.pdf"
file_final="cj_all.pdf"
plt.savefig(file)

# compress pdf 
os.system('gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile='
  + file_final + ' ' + file)
os.system('rm '+ file)
