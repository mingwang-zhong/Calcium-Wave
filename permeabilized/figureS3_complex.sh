reset

set term pdfcairo enhanced color size 8,6 font 'Helvetica,11' background rgb "#ffffff"

set output "wave_Ttubule_nRyR.pdf"
set multiplot 

set border 0
unset tics

set cbrange [1:2]
set yrange [0:105]
unset colorbox
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )

path1="Hill7_alpha0.2_beta0.004_cstar1.1/"
path2="Hill7_alpha0.2_beta0.004_cstar1.1_tausl_partial/"
path3="Hill7_alpha0.2_beta0.004_cstar1.1_tausl/"
path4="Hill7_alpha0.2_beta0.004_cstar1.1_NryrRandom/"

path41="Hill4_alpha0.2_beta0.004_cstar1.1/"
path42="Hill4_alpha0.2_beta0.004_cstar1.1_tausl_partial/"
path43="Hill4_alpha0.2_beta0.004_cstar1.1_tausl/"
path44="Hill4_alpha0.2_beta0.004_cstar1.1_NryrRandom/"

originx=0.005
sizex=0.26
shiftx=-0.025

originy=0.01
sizey=0.14
shifty=-0.025
blocky=0.03

set size sizex,sizey


##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*7+blocky
set xrange [4:12]
set label 1 "0.1 μM" right at graph -0.04,0.85 rotate by 90 front
set label 11 'Regularly distributed CRUs' center at graph 0.5,1.13
set label 21 "{/:Bold A}" at graph -0.05,1.1 font ",14"
plot path1."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 21
unset label 11
##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*6+blocky
set xrange [5:13]
set label 1 "0.15 μM"
plot path1."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*5+blocky
set xrange [16:24]
set label 1 "0.175 μM" 
plot path1."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*4+blocky

set xrange [37:45]
set label 1 "0.3 μM" 

set label 2 '77 μm/s' right at graph 0.95,0.85 tc rgb "#ffffff" front
set arrow 2 from 42.631,101.81 to 43.69,20.095 nohead lw 1 dt (10,4) lc rgb '#ffffff' front # 71 um/s

plot path1."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""

unset arrow
unset label 1
unset label 2
####################################

##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*7+blocky
set xrange [4:12]
set label 11 'Longitudinal tubules partially coupled' center at graph 0.5,1.13
set label 21 "{/:Bold B}" at graph -0.05,1.1 font ",14"
plot path2."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 11
unset label 21
##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*6+blocky
set xrange [5:13]
plot path2."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*5+blocky
set xrange [4.4:12.4]
plot path2."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*4+blocky
xstart=20
set xrange [xstart:xstart+8]
set label 4 '94.5 μm/s' right at graph 0.72,0.85 tc rgb "#ffffff" front
set arrow 5 from 22.883,103.67 to 23.977,4.471 nohead lw 1 dt (10,4) lc rgb '#ffffff' front # 71 um/s

plot path2."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""


unset arrow
unset label 1
unset label 4
####################################

##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*7+blocky
set xrange [4:12]
set label 11 'Longitudinal tubules fully coupled' center at graph 0.5,1.13 # τ_{il}=0.963 ms
set label 21 "{/:Bold C}" at graph -0.05,1.1 font ",14"
plot path3."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 11
unset label 21
##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*6+blocky
set xrange [5:13]
plot path3."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*5+blocky
set xrange [4.4:12.4]
plot path3."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*4+blocky
xstart=22
dx=-0.07
set xrange [xstart:xstart+8]
set label 4 '184 μm/s' right at graph 0.95,0.85 tc rgb "#ffffff" front
set label 5 '160 μm/s' right at graph 0.95,0.25 tc rgb "#ffffff" front

set arrow 5 from 27.495+dx,100.465 to 27.82+dx,38.88 nohead lw 1 dt (10,4) lc rgb '#ffffff' front # 183.8 um/s
set arrow 6 from 27.435+dx,18.62 to 27.87+dx,88.095 nohead lw 1 dt (10,4) lc rgb '#ffffff' front # 159.7 um/s

plot path3."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""

unset arrow
unset label 1
unset label 4
unset label 5
####################################


##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*7+blocky
set xrange [4:12]
set label 11 'Randomly distributed number of RyRs' center at graph 0.5,1.13
set label 21 "{/:Bold D}" at graph -0.05,1.1 font ",14"
plot path4."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 11
unset label 21
##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*6+blocky
set xrange [5:13]
plot path4."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*5+blocky
set xrange [12:21]
plot path4."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*4+blocky

xstart=22
dx=-0.14
set xrange [xstart:(xstart+8)]


set arrow 2 from xstart+5.032+dx,103.6 to xstart+5.549+dx,1.752 nohead lw 1 dt (10,4) lc rgb '#ffffff' front #
set arrow 3 from xstart+5.715+dx,0.48 to xstart+4.899+dx,104.105 nohead lw 1 dt (10,4) lc rgb '#ffffff' front #
set label 4 '156 μm/s' right at graph 0.9,0.85 tc rgb "#ffffff" front
set label 5 '118 μm/s' right at graph 0.95,0.15 tc rgb "#ffffff" front

set label 6 'H = 7' left at graph 1.1,1.9 rotate by 90 font ',14'

plot path4."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""


unset arrow 2
unset arrow 3
unset label 4
unset label 5
unset label 6












##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*3
set xrange [4:12]
set label 3 "0.1 μM" right at graph -0.04,0.85 rotate by 90 front
set label 21 "{/:Bold E}" at graph -0.05,1.1 font ",14"
plot path41."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 21
unset label 11
##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*2
set xrange [5:13]
set label 3 "0.15 μM"
plot path41."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*1
set xrange [5:13]
set label 3 "0.175 μM" 
plot path41."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*0 , originy+(sizey+shifty)*0
xstart=22
set xrange [xstart:xstart+8]
set label 3 "0.3 μM" right at graph -0.04,1 rotate by 90 front

set arrow 1 from xstart,-5 to xstart+1,-5 nohead lw 2
set arrow 2 from xstart-0.12,0 to xstart-0.12,40 nohead lw 2
set label 1 "1 s" center at xstart+0.5,-14
set label 2 "40 μm" at xstart-0.5,-3 rotate by 90

plot path41."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""

unset arrow
unset label 1
unset label 2
unset label 3
####################################

##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*3
set xrange [4:12]
set label 21 "{/:Bold F}" at graph -0.05,1.1 font ",14"
plot path42."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 11
unset label 21
##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*2
set xrange [5:13]
plot path42."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*1
set xrange [4.4:12.4]
plot path42."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*1 , originy+(sizey+shifty)*0
xstart=20
set xrange [xstart:xstart+8]
set arrow 1 from xstart,-5 to xstart+1,-5 nohead lw 2
set label 1 "1 s" center at xstart+0.5,-14

plot path42."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""


unset arrow
unset label 1
unset label 4
####################################

##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*3
set xrange [4:12]
set label 21 "{/:Bold G}" at graph -0.05,1.1 font ",14"
plot path43."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 11
unset label 21
##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*2
set xrange [5:13]
plot path43."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*1
set xrange [4.4:12.4]
plot path43."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*2 , originy+(sizey+shifty)*0
xstart=22
set xrange [xstart:xstart+8]
set arrow 1 from xstart,-5 to xstart+1,-5 nohead lw 2
set label 1 "1 s" center at xstart+0.5,-14

plot path43."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""

unset arrow
unset label 1
unset label 4
unset label 5
####################################


##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*3
set xrange [4:12]
set label 21 "{/:Bold H}" at graph -0.05,1.1 font ",14"
plot path44."ci0.1/fluoxt.txt" u ($1/1000):2:($3/5) every :8 w image t ""

unset label 11
unset label 21
##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*2
set xrange [5:13]
plot path44."ci0.15/fluoxt.txt" u ($1/1000):2:($3/6) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*1
set xrange [4.4:12.4]
plot path44."ci0.175/fluoxt.txt" u ($1/1000):2:($3/6.5) every :8 w image t ""

##################
set origin originx + (sizex+shiftx)*3 , originy+(sizey+shifty)*0

xstart=22
set xrange [xstart:(xstart+8)]

set arrow 1 from xstart,-5 to xstart+1,-5 nohead lw 2
set label 1 "1 s" center at xstart+0.5,-14
set label 6 'H = 4' left at graph 1.1,1.9 rotate by 90 font ',14'

set colorbox user origin originx + (sizex+shiftx)*4 + 0.01 , originy+0.04 size 0.015,sizey-0.075 noborder
set cbtics nomirror 1 offset -1.2,0 scale 0.5
set cblabel "F/F_0" offset -1,0

plot path44."ci0.3/fluoxt.txt" u ($1/1000):2:($3/7.5) every :8 w image t ""



unset multiplot


