reset
set term pdfcairo enhanced color size 6,4.3 font 'Helvetica,12' background rgb "#ffffff"
set output "Hill_DAD.pdf"

set multiplot 

path1="DAD/Hill4_alpha0.2_beta0.001_cstar1.4/"
path2="DAD/Hill5_alpha0.2_beta0.001_cstar1.4/"
path3="DAD/Hill6_alpha0.2_beta0.001_cstar1.4/"

originx=0.035
originx3=-0.01 # statistics
sizex1=0.47 # image
sizex2=0.523 
sizex3=0.275 # statistics
sizex32=0.245 # statistics
shiftx=0
shiftx3=0 # statistics

originy=-0.02
sizey1=0.24 # image
sizey2=0.24
sizey3=0.29 # statistics
shifty1=-0.01 #image
shifty2=-0.01
shifty3=0.04 # statistics


set border 0
unset xtics
unset xlabel
unset ytics
unset ylabel
unset key
unset colorbox

set size sizex1,sizey1
xstart=14.05
set xrange [xstart:(xstart+4)]
set yrange [0:105]
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )
set cbrange [1:4]
############################################################ H = 4
set origin originx, originy+2*(sizey1+shifty1)+sizey3+shifty3

set label 2 'H = 4' right at graph 0.95,0.9 tc rgb "#ffffff" front

plot path1."fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image

############################################################ H = 5
set origin originx, originy+1*(sizey1+shifty1)+sizey3+shifty3

set label 2 'H = 5' right at graph 0.95,0.9 tc rgb "#ffffff" front
set colorbox user origin 0.038,originy+1*(sizey1+shifty1)+sizey3+shifty3+0.042 size 0.015,sizey1-0.08 noborder
set cbtics 2 offset -4.2 nomirror scale 0.7
set mcbtics 2
set cblabel 'F/F_0' offset -7.8

plot path2."fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image


unset colorbox
############################################################ H = 6
set origin originx, originy+0*(sizey1+shifty1)+sizey3+shifty3
set label 1 "{/:Bold A}" at graph -0.1,3.5 font ",18"
set label 2 'H = 6' right at graph 0.95,0.9 tc rgb "#ffffff" front
set arrow 3 from xstart+0.05,-5 to xstart+0.55,-5 nohead lw 2
set label 3 '0.5 s' at xstart+0.12,-13
set arrow 4 from xstart-0.05,20 to xstart-0.05,70 nohead lw 2
set label 4 '50 μm' at xstart-0.2,25 rotate by 90

plot path3."fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image

unset arrow
unset label
set border 2
set mytics 2
set ytics nomirror out
set size sizex2,sizey2
############################################################ Vm
set origin originx+sizex1+shiftx, originy+2*(sizey2+shifty2)+sizey3+shifty3

set yrange [-100:60]
set ytics 40 offset 0.5,0
set ytics add('   0'0)
set ylabel "V_m (mV)" offset 1.0,0
set label 1 "{/:Bold B}" at graph -0.25,1 font ",18"
set key right at xstart+4,60

x=7
plot 	path1."wholecell.txt" u ($1/1000):x w l t 'H = 4',\
		path2."wholecell.txt" u ($1/1000):x w l lc 2 t 'H = 5',\
		path3."wholecell.txt" u ($1/1000):x w l lc 4 lw 1 t 'H = 6'

unset key
############################################################ ci
set origin originx+sizex1+shiftx, originy+1*(sizey2+shifty2)+sizey3+shifty3

set yrange [0:3.5]
set ytics 1
set ytics add('   0'0)
set ylabel "[Ca^{2+}]_i (μM)"
set label 1 "{/:Bold C}"
set object 1 rect from (xstart+0.25),0.15 to (xstart+2),0.4 fc rgb "#F0F0F0" fs solid 0 border rgb "grey50" back lw 0.5
set arrow 1 from xstart+1.2,0.42 to xstart+2,2 filled size screen 0.015,12 lc 9

x=2
plot 	path1."wholecell.txt" u ($1/1000):x w l t '',\
		path2."wholecell.txt" u ($1/1000):x w l lc 2 t '',\
		path3."wholecell.txt" u ($1/1000):x w l lc 4 lw 1 t ''

unset object
unset arrow 1
############################################################ cj
set origin originx+sizex1+shiftx, originy+0*(sizey2+shifty2)+sizey3+shifty3

set yrange [400:900]
set ytics 200
set ylabel "[Ca^{2+}]_{JSR} (μM)"
set label 1 "{/:Bold D}"
set arrow 2 from xstart+0.05,390 to xstart+0.55,390 lw 2 nohead
set label 2 "0.5 s" at xstart+0.1,350
set arrow 3 from xstart+0.6,843 to xstart+4,843 nohead lw 0.5 dt 4

x=5
plot 	path1."wholecell.txt" u ($1/1000):x w l t '',\
		path2."wholecell.txt" u ($1/1000):x w l lc 2 t '',\
		path3."wholecell.txt" u ($1/1000):x w l lc 4 lw 1 t ''


unset label
unset arrow
set border 15 lw 0.5
########################################################### inset ci
set origin 0.773,0.62
set size 0.25,0.2
set yrange [0.15:0.4]
set ytics 0.2 offset 0.5 scale 0.6
set mytics 4
unset ylabel
set xrange [(xstart+0.25):(xstart+2)]
set arrow 1 from xstart+0.25,0.13 to xstart+0.75,0.13 nohead lw 2
set label 1 '0.5 s' at xstart+0.25,0.1

x=2
plot 	path1."wholecell.txt" u ($1/1000):x w l t '',\
		path2."wholecell.txt" u ($1/1000):x w l lc 2 t '',\
		path3."wholecell.txt" u ($1/1000):x w l lc 4 lw 1 t ''




unset label
unset arrow
set border 3 lw 1
set tics out front
set xrange [-0.8:3.5]
set xtics 1 offset 0,1.7 nomirror out scale 0
set xtics add('4'0, '5'1, '6'2, '7'3)
set mxtics 1
set xlabel "H" offset 0,1.7
set style line 1 lc rgb "#8E8E8E" lw 1


set style histogram errorbars gap 1 linewidth 1
set style data histograms
set style fill solid 1  noborder
set boxwidth 0.8 relative

set size sizex32,sizey3
########################################################### latency
set origin originx3+0*(sizex3+shiftx3),originy

set yrange [0:2]
set ytics 1
set ytics add('0'0)
set mytics 2
set ylabel "Latency (s)" offset 1,0
set label 1 "{/:Bold E}" at graph -0.4,1 font ",18"

path="DAD/latency_cstar1.4.txt"

plot 	path u 0:($2/1000.0-0):($3/1000.0) w yerrorbars ls 1 lc 2 ps 0 title "",\
		path u 0:($2/1000.0):xtic(1) w boxes ls 1 lc 2 title ""

set size sizex3,sizey3
########################################################### takeoff ci
set origin originx3+1*(sizex32+shiftx3),originy

set yrange [0.17:0.26]
set ytics 0.03
set mytics 3
set ylabel "[Ca^{2+}]_i (μM)" offset 1
set label 1 "{/:Bold F}"

path="DAD/citakeoff_cstar1.4.txt"

plot 	path u 0:($2-0):3 w yerrorbars ls 1 lc 2 ps 0 title "",\
		path u 0:2:xtic(1) w boxes ls 1 lc 2 title ""

########################################################### takeoff cj
set origin originx3+1*(sizex3+shiftx3)+1*(sizex32+shiftx3),originy

set yrange [600:900]
set ytics 100
set mytics 2
set ylabel "[Ca^{2+}]_{JSR} (μM)"
set label 1 "{/:Bold G}" at graph -0.7,1 font ",18"

path="DAD/cjtakeoff_cstar1.4.txt"

plot 	path u 0:($2-0):3 w yerrorbars ls 1 lc 2 ps 0 title "",\
		path u 0:2:xtic(1) w boxes ls 1 lc 2 title ""



set size sizex32,sizey3
########################################################### frequency
set origin originx3+2*(sizex3+shiftx3)+1*(sizex32+shiftx3),originy

set yrange [0:1]
set ytics 1
set ytics add('0'0)
set mytics 5
set ylabel "frequency"
set label 1 "{/:Bold H}" at graph -0.5,1 font ",18"

path="DAD/frequency_cstar1.4.txt"

plot 	path u 0:($3/$2):xtic(1) w boxes ls 1 lc 2 title ""


unset multiplot



