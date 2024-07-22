import numpy as np
import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams['text.usetex'] = True # latex equation
matplotlib.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"] # bold symbol
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from mpl_toolkits.axes_grid1.inset_locator import inset_axes
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter,
                               AutoMinorLocator)

# font = { 'family' : 'normal',
#         # 'weight' : 'bold',
#         'size'   : 10}	
# matplotlib.rc('font', **font)

data = np.loadtxt("wholecell.txt")

################################################################################### Vm
# fig, ax = plt.subplots(figsize=(4,2))
# ims = []
# for i in np.arange(0,25001,20):
# 	im, = ax.plot(data[0:i,0], data[0:i,6], color='black', linewidth=0.7)
# 	label1 = ax.text(25100, 57, '%.1f'%(i/1000), ha='right', va='bottom', fontsize=12)
# 	label2 = ax.text(25200, 57, 's', ha='left', va='bottom', fontsize=12)
# 	ims.append([im,label1,label2])

# ax.set_position([0.15, 0.08, 0.8, 0.85 ])
# ax.spines["top"].set_color('none') # border
# ax.spines["bottom"].set_color('none')
# # ax.spines["left"].set_color('none')
# ax.spines["right"].set_color('none')
# ax.tick_params(which='major', width=0.5, length=1.5)
# ax.tick_params(which='minor', width=0.5, length=1)

# ax.set_xlim(-200,25000)
# ax.set_xticks([])

# ax.set_ylim(-100,60)
# ax.set_ylabel(r'$V_m~(mV)$')
# ax.set_yticks(np.arange(-80,41,40))
# ax.yaxis.set_minor_locator(MultipleLocator(20))

# im_ani = animation.ArtistAnimation(fig, ims, interval=100, repeat_delay=3000, blit=True)
# Writer = animation.writers['ffmpeg']
# writer = Writer(fps=25, metadata=dict(artist='Mingwang'), bitrate=1800)
# im_ani.save('Vm.mp4', writer=writer, dpi=300)


#################################################################################### ci
# fig, ax = plt.subplots(figsize=(4,2))
# ims = []
# for i in np.arange(0,25001,20):
# 	im = ax.plot(data[0:i,0], data[0:i,1], color='black', linewidth=0.7)

# 	ims.append((im))

# ax.set_position([0.1, 0.08, 0.89, 0.85 ])
# ax.spines["top"].set_color('none') # border
# ax.spines["bottom"].set_color('none')
# # ax.spines["left"].set_color('none')
# ax.spines["right"].set_color('none')
# ax.tick_params(which='major', width=0.5, length=1.5)
# ax.tick_params(which='minor', width=0.5, length=1)

# ax.set_xlim(-200,25000)
# ax.set_xticks([])

# ax.set_ylim(0,3.5)
# ax.set_ylabel(r'$[{Ca}^{2+}]_i~(\mu M)$')
# ax.set_yticks(np.arange(0,3.1,1))
# ax.yaxis.set_minor_locator(MultipleLocator(0.5))

# im_ani = animation.ArtistAnimation(fig, ims, interval=100, repeat_delay=3000, blit=True)
# Writer = animation.writers['ffmpeg']
# writer = Writer(fps=25, metadata=dict(artist='Mingwang'), bitrate=1800)
# im_ani.save('ci.mp4', writer=writer, dpi=300)

#################################################################################### linescan

#################### prepare data
fluoxt = np.loadtxt("fluoxt.txt")
fluo = np.zeros((25000-1,128))
for i in range(0,25000-1):
	fluo[i,:] = fluoxt[(i*128):((i+1)*128),2]

np.savetxt("fluo_image.txt", fluo, fmt='%g', delimiter='\t')

#################### plot
data = np.loadtxt("fluo_image.txt")
fig, ax = plt.subplots(figsize=(4,2))
ims = []
for i in np.arange(0,25000-1,20):
	im = ax.imshow(np.transpose(data[0:i,:]/5.5), extent=[-0.5, i+0.5, -0.5, 127.5], origin='lower', cmap='coolwarm', vmin=1, vmax=3) # F0 = 4.2

	ims.append(([im]))


ax.set_position([0.15, 0.25, 0.8, 0.74 ])
ax.set_aspect('auto')
ax.spines["top"].set_color('none') # border
ax.spines["bottom"].set_color('none')
# ax.spines["left"].set_color('none')
ax.spines["right"].set_color('none')
ax.tick_params(which='major', width=0.5, length=1.5)
ax.tick_params(which='minor', width=0.5, length=1)

ax.set_xlim(-200,25000.5)
ax.set_xticks([])

ax.set_ylim(-0.5,105)
ax.set_ylabel(r'$x~(\mu m)$')
ax.set_yticks(np.arange(0,105,20))
ax.set_yticklabels(['0','20','40','60','80','100'])
ax.yaxis.set_minor_locator(MultipleLocator(10))

cax = fig.add_axes([0.3, 0.185, 0.4, 0.05])
cb = fig.colorbar(im, cax=cax, orientation='horizontal')
cb.outline.set_color('none')
cb.ax.set_xlabel(r"$F/F_0$")
cb.set_ticks([1, 2, 3])
# cb.ax.set_yticklabels(['-0.8','-0.4','0','0.3'])  # set_yticklabels if orientation is vertical
# cb.ax.yaxis.set_minor_locator(MultipleLocator(0.1))
cb.ax.tick_params(which='major', width=0.5, length=1.5)
# cb.ax.tick_params(which='minor', width=0.5, length=1)
# cb.ax.text(-0.2, 4.2, r"$F/F_0$", color='k')

im_ani = animation.ArtistAnimation(fig, ims, interval=100, repeat_delay=3000, blit=True)
Writer = animation.writers['ffmpeg']
writer = Writer(fps=25, metadata=dict(artist='Mingwang'), bitrate=1800)
im_ani.save('fluo.mp4', writer=writer, dpi=300)