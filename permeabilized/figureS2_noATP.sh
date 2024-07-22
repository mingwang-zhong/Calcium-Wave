reset

set term pdfcairo enhanced color size 4,3 font 'Helvetica,11' background rgb "#ffffff"

set output "wave_NoATP.pdf"
set multiplot 

set border 0
unset tics


set yrange [0:105]
set colorbox noborder
set cbtics 1 nomirror scale 0.6 offset -0.6
set cblabel "F/F_0"
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )

path1="Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/ci0.175/fluoxt.txt"
path2="Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/ci0.2/fluoxt.txt"
path3="Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/ci0.225/fluoxt.txt"
path4="Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/ci0.3/fluoxt.txt"

originx=0.05
sizex=0.95
originy=0.01
sizey=0.28
shifty=0.04

set size sizex,sizey

set arrow 1 from 38,-5 to 39,-5 nohead lw 2
set arrow 2 from 37.93,10 to 37.93,50 nohead lw 2
set label 1 "1 s" at 38.35,-14
set label 2 "40 μm" at 37.7,7 rotate by 90

set xrange [38:45]
set cbrange [1:4]
set label 3 "0.3 μM" at graph 0.05,0.8 tc rgb "#ffffff" front
set origin originx,originy
plot path4 u ($1/1000):2:($3/7.5) every :8 w image t ""

unset arrow
unset label 1
unset label 2

set xrange [5.4:13.4]
set label 3 "0.225 μM" 
set origin originx,originy + (sizey-shifty)
plot path3 u ($1/1000):2:($3/7.2) every :8 w image t ""

set xrange [5:13]
set label 3 "0.2 μM"
set origin originx,originy + (sizey-shifty)*2
plot path2 u ($1/1000):2:($3/6) every :8 w image t ""

set xrange [4:12]
set label 3 "0.175 μM"
set origin originx,originy + (sizey-shifty)*3
plot path1 u ($1/1000):2:($3/5) every :8 w image t ""


unset multiplot
set term qt

