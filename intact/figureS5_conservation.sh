reset
set term pdfcairo enhanced color size 6,4 font 'Helvetica,12' background rgb "#ffffff"
set output "CaConservation.pdf"

set multiplot
set border 3


# path="DAD/Hill6_alpha0.2_beta0.001_cstar1/wholecell.txt"
path="Hill7_cstar1.1_conserved/wholecell.txt"



originx=0.03
originy=0.01
sizex=1-originx
sizey=0.49
shifty=-0.01
set size sizex, sizey
set xrange [10:20]
set xtics 2 out nomirror
set mxtics 2
set mytics 2

set origin originx,originy+sizey+shifty
set format x ''
set yrange [-100:60]
set ytics 40 out nomirror
set ytics add('   0'0)
set ylabel 'V_m (mV)'
set label 1 "{/:Bold A}" at graph -0.1,1 font ',16'

plot path u ($1/1000):7 w l lc 1 lw 2 t ''

set origin originx,originy
set format x '%g'
set xlabel 'Time (s)'

set yrange [-0.05:0.15]
set ytics 0.1 out nomirror
set mytics 2
set ylabel '(×10^{-15} μmol)'
set key spacing 1.5 right at 20,0.17
set label 1 "{/:Bold B}"

plot 	path u ($1/1000):29 w l lw 3 lc 2 t 'Change of the total amount of Ca^{2+} in 1 ms per CRU',\
		path u ($1/1000):30 w l lw 1 lc 1 t 'Amount of Ca^{2+} entering/leaving the cell in 1 ms per CRU'

