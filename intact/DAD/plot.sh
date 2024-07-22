# reset
# set term pdfcairo enhanced color size 44,30 font 'Helvetica,10' background rgb "#ffffff"

# set output "Vm_β0.004.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [-100:60]
# set ytics 40
# set mytics 2
# set format y ""

# Numx=11
# Numy=15
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
#	print "H = ", i+1
# #	printf('H = %g', 1+i)
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.6+0.2*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.2_beta0.004_cstar%g/wholecell.txt', 1+i, 0.6+0.2*j)
# 		plot path u ($1/1000-0.1):7 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot


# ############################################################################################################
# reset
# set term pdfcairo enhanced color size 44,30 font 'Helvetica,10' background rgb "#ffffff"

# set output "ci_β0.004.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [0:*]
# set ytics 2
# set mytics 2

# Numx=11
# Numy=15
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
#	print "H = ", i+1
# #	printf('H = %g', 1+i)
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.6+0.2*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.2_beta0.004_cstar%g/wholecell.txt', 1+i, 0.6+0.2*j)
# 		plot path u ($1/1000-0.1):2 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot

# ############################################################################################################
# reset
# set term pdfcairo enhanced color size 44,30 font 'Helvetica,10' background rgb "#ffffff"

# set output "cj_β0.004.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [*:*]
# set ytics 200
# set mytics 2

# Numx=11
# Numy=15
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
#	print "H = ", i+1
# #	printf('H = %g', 1+i)
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.6+0.2*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.2_beta0.004_cstar%g/wholecell.txt', 1+i, 0.6+0.2*j)
# 		plot path u ($1/1000-0.1):5 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot












# reset
# set term pdfcairo enhanced color size 44,30 font 'Helvetica,10' background rgb "#ffffff"

# set output "Vm_β0.001.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [-100:60]
# set ytics 40
# set mytics 2
# set format y ""


# Numx=11
# Numy=15
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
# 	print "H = ", i+1
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.6+0.2*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.2_beta0.001_cstar%g/wholecell.txt', 1+i, 0.6+0.2*j)
# 		plot path u ($1/1000-0.1):7 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot


# ############################################################################################################
# reset
# set term pdfcairo enhanced color size 44,30 font 'Helvetica,10' background rgb "#ffffff"

# set output "ci_β0.001.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [0:*]
# set ytics 2
# set mytics 2

# Numx=11
# Numy=15
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
# 	print "H = ", i+1
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.6+0.2*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.2_beta0.001_cstar%g/wholecell.txt', 1+i, 0.6+0.2*j)
# 		plot path u ($1/1000-0.1):2 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot

# ############################################################################################################
# reset
# set term pdfcairo enhanced color size 44,30 font 'Helvetica,10' background rgb "#ffffff"

# set output "cj_β0.001.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [*:*]
# set ytics 200
# set mytics 2

# Numx=11
# Numy=15
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
# 	print "H = ", i+1
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.6+0.2*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.2_beta0.001_cstar%g/wholecell.txt', 1+i, 0.6+0.2*j)
# 		plot path u ($1/1000-0.1):5 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot






# reset
# set term pdfcairo enhanced color size 44,20 font 'Helvetica,10' background rgb "#ffffff"

# set output "Vm_α0.3_β0.001.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [-100:60]
# set ytics 40
# set mytics 2
# set format y ""


# Numx=11
# Numy=8
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
# 	print "H = ", i+1
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.4+0.4*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.3_beta0.001_cstar%g/wholecell.txt', 1+i, 0.4+0.4*j)
# 		plot path u ($1/1000-0.1):7 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot


# ############################################################################################################
# reset
# set term pdfcairo enhanced color size 44,20 font 'Helvetica,10' background rgb "#ffffff"

# set output "ci_α0.3_β0.001.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [0:*]
# set ytics 2
# set mytics 2

# Numx=11
# Numy=8
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
# 	print "H = ", i+1
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.4+0.4*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.3_beta0.001_cstar%g/wholecell.txt', 1+i, 0.4+0.4*j)
# 		plot path u ($1/1000-0.1):2 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot

# ############################################################################################################
# reset
# set term pdfcairo enhanced color size 44,20 font 'Helvetica,10' background rgb "#ffffff"

# set output "cj_α0.3_β0.001.pdf"
# set multiplot 

# set border 3
# set tics out nomirror scale 0.5
# set xrange [-0.2:30]
# set xtics 10
# set mxtics 5
# set format x ""
# set yrange [*:*]
# set ytics 200
# set mytics 2

# Numx=11
# Numy=8
# originx=0
# shiftx=0.003
# sizex=0.99/Numx+shiftx
# originy=0
# shifty=0.003
# sizey=0.99/Numy+shifty

# set size sizex,sizey
# do for [i=1:Numx] {
# 	print "H = ", i+1
# 	do for [j=1:Numy] {

# 		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
# 		str=sprintf('H=%g, c*=%g', 1+i, 0.4+0.4*j)
# 		set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

# 		path = sprintf('Hill%g_alpha0.3_beta0.001_cstar%g/wholecell.txt', 1+i, 0.4+0.4*j)
# 		plot path u ($1/1000-0.1):5 every 1 w l lw 0.5 t ""

# 	}
# }

# unset multiplot



reset
set term pdfcairo enhanced color size 4,20 font 'Helvetica,10' background rgb "#ffffff"

set output "Vm_β0.004_H6.pdf"
set multiplot 

set border 3
set tics out nomirror scale 0.5
set xrange [-0.2:30]
set xtics 10
set mxtics 5
set format x ""
set yrange [-100:60]
set ytics 40
set mytics 2
set format y ""

Numx=1
Numy=8
originx=0
shiftx=0.003
sizex=0.99/Numx+shiftx
originy=0
shifty=0.003
sizey=0.99/Numy+shifty

set size sizex,sizey
i=1
do for [j=1:Numy] {

	set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
	str=sprintf('H=%g, c*=%g', 5+i, 0.76+0.04*j)
	set label 1 str at graph 0.1,1 front tc lt -1 font ",12"

	path = sprintf('Hill%g_alpha0.2_beta0.004_cstar%g/wholecell.txt', 5+i, 0.76+0.04*j)
	plot path u ($1/1000-0.1):7 every 1 w l lw 0.5 t ""

}

unset multiplot