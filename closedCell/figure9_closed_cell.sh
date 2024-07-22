reset
set term pdfcairo enhanced color size 6,4 font 'Helvetica,12' background rgb "#ffffff"
set output "ci_vs_totalCa.pdf"
set multiplot

originx=0.01
originy=0.015

sizex1=0.32 # linescan
sizex2=0.4 # ci vs totalCa
shiftx1=-0.04 # between linescans
shiftx2=0.02

sizey1=0.18 # linescan
sizey2=0.49 # ci vs totalCa
shifty1=-0.02
shifty2=-0.0

set border 0
unset xtics
unset xlabel
unset ytics
unset ylabel
unset key

set xrange [2:10]
set yrange [0:102]

# set cbrange [1:3]
set colorbox noborder 
# set cblabel "F/F_0" offset -1,0

set size sizex1,sizey1

# set palette defined (0 '#3B37A3', 0.2 '#52B8D3', 0.4 '#51AA1A', 0.6 '#FFF35C', 0.8 '#D12921', 1 '#D12921' ) 
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )
path="Hill7_alpha0.2_beta0.004_cstar1.1/"
###############################################################
set origin originx, originy+5*(sizey1+shifty1)
set label 1 "{/:Bold A}" at graph -0.1,0.9 font ",18"
set object 11 rect from graph 0.84,0.75 to graph 0.96,0.94 fc rgb "#ffffff" fs solid 0 border rgb '#ffffff' front
set label 11 "0.1" center at graph 0.9,0.85 front # tc rgb '#ffffff'
set cbtics nomirror 1 in offset -1.2
set cbrange [1:2]

plot path."ci0.1/fluoxt.txt" every :16 u ($1/1000):2:($3/4.4) w image


unset label 1
#########################
set origin originx, originy+4*(sizey1+shifty1)
set object 11
set label 11 "0.2"
set cbrange [1:4]
plot path."ci0.2/fluoxt.txt" every :16 u ($1/1000):2:($3/6.4) w image

#########################
set origin originx, originy+3*(sizey1+shifty1)
set object 11
set label 11 "0.4"
set cbrange [1:3]
plot path."ci0.4/fluoxt.txt" every :16 u ($1/1000):2:($3/10.0) w image

#########################
set origin originx, originy+2*(sizey1+shifty1)
set object 11
set label 11 "0.5"
set cbrange [1:2]

# set colorbox user origin originx-0.007, originy+2*(sizey1+shifty1)+0.031 size 0.02,sizey1-0.06 noborder
# set cbtics nomirror 1 offset -4.8,0 scale 0.3
# set cblabel "F/F_0" offset -8,0

plot path."ci0.5/fluoxt.txt" every :16 u ($1/1000):2:($3/14) w image

#########################
set origin originx, originy+1*(sizey1+shifty1)
set object 11
set label 11 "0.6"
set cbrange [1:1.4]
set cbtics nomirror 0.2 in offset -1.2
plot path."ci0.6/fluoxt.txt" every :16 u ($1/1000):2:($3/20) w image

#########################
set origin originx, originy+0*(sizey1+shifty1)
set object 11
set label 11 "0.8"
set label 12 "[Ca^{2+}]_{i,0} (μM)" right at graph 0.95,-0.12
set label 1 "2 s" at 3,-20
set arrow 1 from 2.5,-7 to 4.5,-7 nohead lw 3
set label 2 "50 μm" at 1.2,12 rotate by 90
set arrow 2 from 1.7,15 to 1.7,65 nohead lw 3
set cbrange [1:1.2]
set cbtics nomirror 0.1 in offset -1.2

plot path."ci0.8/fluoxt.txt" every :16 u ($1/1000):2:($3/26) w image


unset arrow
unset label 12
unset label 1
unset label 2

path="Hill7_alpha0.2_beta0.004_"
###############################################################
set origin originx+1*(sizex1+shiftx1), originy+5*(sizey1+shifty1)
set label 1 "{/:Bold B}" at graph -0.1,0.9 font ",18"
set object 11
set label 11 "0.4"
set cbrange [1:1.2]
set cbtics nomirror 0.2
plot path."cstar0.4/ci0.4/fluoxt.txt" every :16 u ($1/1000):2:($3/22) w image

unset label 1
#########################
set origin originx+1*(sizex1+shiftx1), originy+4*(sizey1+shifty1)
set label 11 "0.8"
set cbrange [1:1.2]
set cbtics nomirror 0.2

plot path."cstar0.8/ci0.4/fluoxt.txt" every :16 u ($1/1000):2:($3/20.6) w image

#########################
set origin originx+1*(sizex1+shiftx1), originy+3*(sizey1+shifty1)
set object 11
set label 11 "1.0"
set cbrange [1:3]
set cbtics nomirror 1
plot path."cstar1/ci0.4/fluoxt.txt" every :16 u ($1/1000):2:($3/11.2) w image

#########################
set origin originx+1*(sizex1+shiftx1), originy+2*(sizey1+shifty1)
set object 11
set label 11 "1.6"
set cbrange [1:4]
set cbtics nomirror 1
plot path."cstar1.6/ci0.4/fluoxt.txt" every :16 u ($1/1000):2:($3/8.4) w image

#########################
set origin originx+1*(sizex1+shiftx1), originy+1*(sizey1+shifty1)
set object 11
set label 11 "2.2"
set cbrange [1:3]
set cbtics nomirror 1
plot path."cstar2.2/ci0.4/fluoxt.txt" every :16 u ($1/1000):2:($3/8) w image

#########################
set origin originx+1*(sizex1+shiftx1), originy+0*(sizey1+shifty1)
set object 11
set label 11 "2.6"
set label 12 "c* (μM)" right at graph 0.95,-0.12
set cbrange [1:2]
set cbtics nomirror 1
plot path."cstar2.6/ci0.4/fluoxt.txt" every :16 u ($1/1000):2:($3/7.8) w image

unset object 11
unset label 11
unset label 12

set border 3
set tics nomirror out 
set xtics nomirror
set ytics nomirror
set mxtics 2
set mytics 2

set size sizex2,sizey2
set style textbox opaque noborder
###############################################################
set origin originx+2*(sizex1+shiftx1)+shiftx2, originy+sizey2+shifty2
set xrange [7:12]
set xtics 2
set xlabel '[Ca^{2+}]_{tot} (×10^{-9} μmol)'
set yrange [0:1.2]
set ytics 0.4
set ylabel 'Averaged [Ca^{2+}]_i (μM)'
set label 1 "{/:Bold C}" at graph -0.3,1.02 font ",18"
set key spacing 1.4 at 10.8,1.2

plot 	"meanCai_vs_totalCa_ci.txt" u ($2*16120/1e6):( ($1<=0.15||$1>=0.64)?$3:1/0 ) w lp pt 5 ps 0.4 t 'Constant [Ca^{2+}]_i',\
		'' u ($2*16120/1e6):( ($1>=0.15&&$1<=0.65)?$3:1/0 ) w lp lc 2 pt 7 ps 0.4 dt 2 t 'Ca^{2+} waves'
###############################################################
set origin originx+2*(sizex1+shiftx1)+shiftx2, originy
set xrange [0:3]
set xtics 1
set xlabel 'c* (μM)'
set yrange [0.1:0.9]
set ytics 0.2
set ylabel 'Averaged [Ca^{2+}]_i (μM)'
set label 1 "{/:Bold D}"
set key spacing 1.4 at 3,0.9

plot 	"meanCai_vs_totalCa_cstar.txt" u 1:( ($1<=0.6||$1>=2.4)?$3:1/0 ) w lp pt 5 ps 0.4 t 'Constant [Ca^{2+}]_i',\
		'' u 1:( ($1>=0.6&&$1<=2.4)?$3:1/0 ) w lp lc 2 pt 7 ps 0.4 dt 2 t 'Ca^{2+} waves'



unset multiplot		



