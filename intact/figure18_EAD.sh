reset
set term pdfcairo enhanced color size 5.5,3.5 font 'Helvetica,10' background rgb "#ffffff"
set output "Hill_EAD.pdf"
set multiplot


originx=-0.02
sizex1=0.37 # H effect
shiftx1=0.03 # H effect

sizex2=0.64 # time trace

originy1=0.0
sizey1=0.47 # H effect
shifty1=0.03

originy2=0
sizey2=0.335 # time trace
shifty2=0.0




set border 2
set tics out nomirror
unset xlabel
unset xtics

xstart=20
set xrange [xstart:(xstart+4.1)]
set key spacing 1.2
set style arrow 1 head filled size screen 0.015,20 lw 1 lc rgb 'gray50'

path8='DAD/Hill8_alpha0.2_beta0.001_cstar1.2/wholecell.txt'
path10='DAD/Hill10_alpha0.2_beta0.001_cstar1.2/wholecell.txt'
path12='DAD/Hill12_alpha0.2_beta0.001_cstar1.2/wholecell.txt'


set size sizex2,sizey2
##############################################################
set origin originx+sizex1+shiftx1, originy2+2*(sizey2+shifty2)

set yrange [-100:60]
set ytics 40 offset 0.6
set ytics add('   0'0)
set mytics 2
set ylabel 'V_m (mV)' offset 1.2
set label 1 "{/:Bold C}" at graph -0.15,1 font ",14"

x=7

plot 	path8 u ($1/1000):x every 2 w l lc 1 lw 1 t 'H = 8  ',\
		path10 u ($1/1000):x every 2 w l lc 2 lw 1 t 'H = 10',\
		path12 u ($1/1000):x every 2 w l lc 4 lw 1 t 'H = 12'


unset key



##############################################################
set origin originx+sizex1+shiftx1, originy2+1*(sizey2+shifty2)

set yrange [0:5.5]
set ytics 1 offset 0.6
set ytics add('   0'0)
set mytics 2
set ylabel '[Ca^{2+}]_i (μM)'
set label 1 "{/:Bold D}"

set object 1 rect from xstart+2.09,0 to xstart+2.2,5.5 fc rgb "#F0F0F0" fs solid 0 border rgb "gray50" lw 1 back
set object 2 rect from xstart+2.15,0.5 to xstart+2.3,1 fc rgb "#F0F0F0" fs solid 0 border rgb "gray50" lw 1 back
set arrow 1 from xstart+2.03,4.5 to xstart+1.7,4.5 as 1
set arrow 2 from xstart+2.3,1 to xstart+2.8,2 as 1
set label 2 '0.5' right at xstart+2.87,1 tc rgb 'gray50'

x=2

plot 	path8 u ($1/1000):x every 2 w l lc 1 lw 1 t 'H = 8',\
		path10 u ($1/1000):x every 2 w l lc 2 lw 1 t 'H = 10',\
		path12 u ($1/1000):x every 2 w l lc 4 lw 1 t 'H = 12'

##############################################################
set origin originx+sizex1+shiftx1, originy2+0*(sizey2+shifty2)

set yrange [300:1000]
set ytics 400 offset 0.6
set mytics 4
set ylabel '[Ca^{2+}]_{JSR} (μM)'
set label 1 "{/:Bold E}"

set object 1 rect from xstart+2.09,350 to xstart+2.3,800 fc rgb "#F0F0F0" fs solid 0 border rgb "gray50" lw 1 back
set arrow 1 from xstart+2.35,450 to xstart+2.8,450 as 1
set arrow 2 from xstart+0.1,300 to xstart+0.3,300 nohead lw 2 lc rgb '#000000'
set label 2 '0.2 s' center at xstart+0.2,260 tc rgb '#000000'
x=5

plot 	path8 u ($1/1000):x every 2 w l lc 1 lw 1 t 'H = 8',\
		path10 u ($1/1000):x every 2 w l lc 2 lw 1 t 'H = 10',\
		path12 u ($1/1000):x every 2 w l lc 4 lw 1 t 'H = 12'


unset label
unset ylabel
unset object
unset arrow
set border 15 lc rgb "gray50"
############################################################## inset of cj
set origin 0.77,0.32-sizey2+0.02
set size 0.219,0.25


set xrange [(xstart+2.09):(xstart+2.3)]
set yrange [350:750]
set ytics 200 offset 0.6
set mytics 4

x=5

plot 	path8 u ($1/1000):x w l lc 1 lw 1 t 'H = 8',\
		path10 u ($1/1000):x w l lc 2 lw 1 t 'H = 10',\
		path12 u ($1/1000):x w l lc 4 lw 1 t 'H = 12'


############################################################## inset of ci
set origin 0.5,0.1+sizey2
set size 0.2,0.25


set xrange [(xstart+2.09):(xstart+2.2)]
set yrange [0:5.5]
set ytics 1 offset 0.6
set mytics 2

x=2

plot 	path8 u ($1/1000):x w l lc 1 lw 1 t 'H = 8',\
		path10 u ($1/1000):x w l lc 2 lw 1 t 'H = 10',\
		path12 u ($1/1000):x w l lc 4 lw 1 t 'H = 12'


############################################################## inset of ci
set origin 0.789,0.05+sizey2
set size 0.2,0.25


set xrange [(xstart+2.15):(xstart+2.3)]
set yrange [0.5:1]
set ytics 1 offset 0.6
set mytics 10

x=2

plot 	path8 u ($1/1000):x w l lc 1 lw 1 t 'H = 8',\
		path10 u ($1/1000):x w l lc 2 lw 1 t 'H = 10',\
		path12 u ($1/1000):x w l lc 4 lw 1 t 'H = 12'


##############################################################
############################################################## H effect

set size sizex1,sizey1
set border 3 lc -1
set xtics out

set xrange [1:12]
set xtics 4 offset 0,0.3 nomirror
set mxtics 2
set xlabel 'H' offset 0,0.6
pathH="Hill_effect/result_H_all.txt"
#################################### diastolic ci
set origin originx, originy1+1*(sizey1+shifty1)

set ylabel 'Diastolic [Ca^{2+}]_i (μM)' offset 2.5,0
set yrange [0.16:0.24]
set ytics 0.04 offset 0.3
set mytics 2
set label 1 "{/:Bold A}" at graph -0.3,1.0 font ",14"
set label 2 'DAD' center at 5.5,0.234
set label 3 'EAD' center at 9.5,0.234
set object 1 rect from 2.5,0.15 to 8.5,0.25 fc rgb "#CCFFE5" fs solid 1 border rgb "#CCFFE5" back
set object 2 rect from 8.5,0.15 to 10.5,0.25 fc rgb "#95E9BF" fs solid 1 border rgb "#95E9BF" back

plot 	pathH u 1:($5-$6):($5+$6) w filledcurve fc rgb "#aa629FA8" t "",\
		pathH u 1:5 w l lc 2 lw 1 t ''


#################################### diastolic cj
set origin originx, originy1+0*(sizey1+shifty1)

set ylabel 'Diastolic [Ca^{2+}]_{JSR} (μM)' offset 1.7,0
set yrange [600:1000]
set ytics 200
set mytics 2
set label 1 "{/:Bold B}"
set label 2 'DAD' center at 5.5,970
set label 3 'EAD' center at 9.5,970
set object 1 rect from 2.5,600 to 8.5,1000 fc rgb "#CCFFE5" fs solid 1 border rgb "#CCFFE5" back
set object 2 rect from 8.5,600 to 10.5,1000 fc rgb "#95E9BF" fs solid 1 border rgb "#95E9BF" back

plot 	pathH u 1:($7-$8):($7+$8) w filledcurve fc rgb "#aa629FA8" t "",\
		pathH u 1:7 w l lc 2 lw 1 t ''



unset multiplot