reset
set term pdfcairo enhanced color size 7,5 font 'Helvetica,12' background rgb "#ffffff"
set output "DAD.pdf"

set multiplot 

path11="Hill2_cstar3.5/"
path12="Hill2_cstar1.1/"
path13="Hill2_cstar1.1_ISO/"
path21="Hill7_cstar3.5/"
path22="Hill7_cstar1.1/"
path23="Hill7_cstar1.1_ISO/"
path31="Hill12_cstar3.5/"
path32="Hill12_cstar1.1/"
path33="Hill12_cstar1.1_ISO/"

# path11="Hill2_cstar8.7166/"
# path12="Hill2_cstar2.4905/"
# path13="Hill2_cstar2.4905_ISO/"
# path21="Hill7_cstar3.5/"
# path22="Hill7_cstar1/"
# path23="Hill7_cstar1_ISO/"
# path31="Hill10_cstar3.137/"
# path32="Hill10_cstar0.8963/"
# path33="Hill10_cstar0.8963_ISO/"

unset colorbox
unset xtics
unset xlabel
xstart=14
set xrange [xstart:(xstart+11)]

set ytics nomirror
set style arrow 1 nohead lw 3
set style arrow 2 head filled size screen 0.02,12 ls 1 lw 1 lc rgb "#ffffff" front
set style arrow 3 head filled size screen 0.025,6,20 ls 1 lc 9
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' ) # 0.33333 '#4286de', 

originx1=0.091 # image
originx2=0.045
sizex1=0.32 # image
sizex2=0.365 # first column
sizex3=0.322 # 2nd, 3rd column
shiftx1=-0.03
shiftx2=-0.032

originy=-0.0
sizey1=0.14 # image
sizey2=0.13
shifty1=-0.04 # below image
shifty2=-0.03 # 
sizeyBlock=2*sizey2+sizey1+shifty1+shifty2
shiftyBlock=-0.01

shiftxBox=0.01
shiftyBox=0.025
sizexBox=0.01
sizeyBox=0.085
######################################################################################################
######################################################################################################
###################################################
set origin originx1, originy+2*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 

set cbrange [1:3]
# set palette defined (0 '#3B37A3', 0.15 0.322 0.722 0.827, 0.5 0.318 0.667 0.102, 0.85 '#FFF35C', 1 '#D12921' ) 
set colorbox user origin originx1+shiftxBox, originy+2*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2+shiftyBox size sizexBox,sizeyBox noborder
set cbtics nomirror 1 offset -4,0 scale 0.3
set label 3 "F/F_0" at graph -0.2,0.32 rotate by 90
set label 5 "{/:Bold Aa}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front

plot 	path11."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label
unset arrow
set border 2 linewidth 1
set mytics 2
set ytics scale 0.5
set ytics out nomirror
set format y "%g"
unset colorbox

###################################################
set origin originx2, originy+2*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex2,sizey2

set ylabel "c_i (μM)"
set yrange [0.1:0.5]
set ytics 0.2 offset 0.6
set ytics add('  0'0)
x=2

plot 	path11."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title ""

###################################################
set origin originx2, originy+2*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex2,sizey2

set ylabel "c_j (μM)"
set yrange [300:700] # [550:650]
set ytics 200
x=5

plot 	path11."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title ""

######################################################################################################
######################################################################################################

set format y ""
###################################################
set origin originx1+sizex1+shiftx1, originy+2*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 
set label 5 "{/:Bold Ab}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front
set cbrange [1:3]

plot 	path12."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label 5
set border 2 linewidth 1
set mytics 2
set ytics scale 0.5
set ytics out nomirror
unset ylabel

###################################################
set origin originx2+sizex2+shiftx2, originy+2*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex3,sizey2

set yrange [0.1:0.5]
set ytics 0.2
x=2

plot 	path11."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path12."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 1 lt 1 title ""

###################################################
set origin originx2+sizex2+shiftx2, originy+2*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex3,sizey2

set yrange [300:700] # [550:650]
set ytics 200
x=5

plot 	path11."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path12."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 1 lt 1 title ""


######################################################################################################
######################################################################################################

###################################################
set origin originx1+2*(sizex1+shiftx1), originy+2*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 

set cbrange [1:3]
set label 1 "2 s" at xstart+9.6,-25
set arrow 1 from xstart+9,-7 to xstart+11,-7 as 1
set label 2 "40 μm" at xstart+11.7,0 rotate by 90
set arrow 2 from xstart+11.2,20 to xstart+11.2,60 as 1
# set arrow 3 from 6.9,19 to 7,11 as 2
# set arrow 4 from 6.9,49 to 7,56 as 2
# set arrow 5 from 6.8,95 to 6.9,85 as 2
set label 5 "{/:Bold Ac}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front

plot 	path13."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label
unset arrow
set border 2 linewidth 1
set mytics 2
set ytics scale 0.5
set ytics out nomirror
unset ylabel

###################################################
set origin originx2+sizex2+shiftx2+sizex3+shiftx2, originy+2*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex3,sizey2

set yrange [0.1:0.5]
set ytics 0.2
x=2

plot 	path11."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path13."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 4 lt 1 title ""

###################################################
set origin originx2+sizex2+shiftx2+sizex3+shiftx2, originy+2*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex3,sizey2

set yrange [300:700] # [550:650]
set ytics 200
x=5

plot 	path11."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path13."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 4 lt 1 title ""













######################################################################################################
######################################################################################################
###################################################
set origin originx1, originy+1*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 

set cbrange [1:3]
# set palette defined (0 '#3B37A3', 0.15 0.322 0.722 0.827, 0.5 0.318 0.667 0.102, 0.85 '#FFF35C', 1 '#D12921' ) 
set colorbox user origin originx1+shiftxBox, originy+1*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2+shiftyBox size sizexBox,sizeyBox noborder
set cbtics nomirror 1 offset -4,0 scale 0.3
set label 3 "F/F_0" at graph -0.2,0.32 rotate by 90
# set label 4 "Control\t\t\t\t\t\t\t   Caffeine\t\t\t\t\t\t\tCaffeine + ISO" at graph 0.4,1.15
set label 5 "{/:Bold Ba}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front

plot 	path21."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label
unset arrow
set border 2 linewidth 1
set mytics 4
set ytics scale 0.5
set ytics out nomirror
set format y "%g"
unset colorbox

###################################################
set origin originx2, originy+1*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex2,sizey2

set ylabel "c_i (μM)"
set yrange [0:3.5]
set ytics 2 offset 0.6
set ytics add('  0'0)
x=2

plot 	path21."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title ""

###################################################
set origin originx2, originy+1*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex2,sizey2

set ylabel "c_j (μM)"
set yrange [350:900]
set ytics 200
x=5

plot 	path21."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title ""

######################################################################################################
######################################################################################################

set format y ""
###################################################
set origin originx1+sizex1+shiftx1, originy+1*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 
set label 5 "{/:Bold Bb}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front
set cbrange [1:3]

plot 	path22."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label 5
set border 2 linewidth 1
set mytics 4
set ytics scale 0.5
set ytics out nomirror
unset ylabel

###################################################
set origin originx2+sizex2+shiftx2, originy+1*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex3,sizey2

set yrange [0:3.5]
set ytics 2
x=2

plot 	path21."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path22."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 1 lt 1 title ""

###################################################
set origin originx2+sizex2+shiftx2, originy+1*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex3,sizey2

set yrange [350:900]
set ytics 200
x=5

plot 	path21."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path22."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 1 lt 1 title ""


######################################################################################################
######################################################################################################

###################################################
set origin originx1+2*(sizex1+shiftx1), originy+1*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 

set cbrange [1:3]
set label 1 "2 s" at xstart+9.6,-25
set arrow 1 from xstart+9,-7 to xstart+11,-7 as 1
set label 2 "40 μm" at xstart+11.7,0 rotate by 90
set arrow 2 from xstart+11.2,20 to xstart+11.2,60 as 1
set arrow 3 from xstart+5.9,49 to xstart+6.7,70 lw 4 as 2
# set arrow 3 from 6.9,19 to 7,11 as 2
# set arrow 4 from 6.9,49 to 7,56 as 2
# set arrow 5 from 6.8,95 to 6.9,85 as 2
set label 5 "{/:Bold Bc}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front

plot 	path23."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label
unset arrow
set border 2 linewidth 1
set mytics 4
set ytics scale 0.5
set ytics out nomirror
unset ylabel

###################################################
set origin originx2+sizex2+shiftx2+sizex3+shiftx2, originy+1*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex3,sizey2

set yrange [0:3.5]
set ytics 2
set label 1 "◼" at xstart+1.55,3 font ",9"
set label 2 "◼" at xstart+3.30,3.5 font ",9"
set label 3 "◼" at xstart+5.05,3 font ",9"
set label 4 "♦" at xstart+6.90,1 font ",6"
x=2

plot 	path21."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path23."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 4 lt 1 title ""

unset label
###################################################
set origin originx2+sizex2+shiftx2+sizex3+shiftx2, originy+1*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex3,sizey2

set yrange [350:900]
set ytics 200
x=5

plot 	path21."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path23."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 4 lt 1 title ""









######################################################################################################
######################################################################################################
###################################################
set origin originx1, originy+0*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 

set cbrange [1:3]
# set palette defined (0 '#3B37A3', 0.15 0.322 0.722 0.827, 0.5 0.318 0.667 0.102, 0.85 '#FFF35C', 1 '#D12921' ) 
set colorbox user origin originx1+shiftxBox, originy+0*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2+shiftyBox size sizexBox,sizeyBox noborder
set cbtics nomirror 1 offset -4,0 scale 0.3
set label 3 "F/F_0" at graph -0.2,0.32 rotate by 90
# set label 4 "Control\t\t\t\t\t\t\t   Caffeine\t\t\t\t\t\t\tCaffeine + ISO" at graph 0.4,1.15
set label 5 "{/:Bold Ca}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front

plot 	path31."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label
unset arrow
set border 2 linewidth 1
set mytics 4
set ytics scale 0.5
set ytics out nomirror
set format y "%g"
unset colorbox

###################################################
set origin originx2, originy+0*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex2,sizey2

set ylabel "c_i (μM)"
set yrange [0:4.5]
set ytics 2 offset 0.6
set ytics add('  0'0)
x=2

plot 	path31."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title ""

###################################################
set origin originx2, originy+0*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex2,sizey2

set ylabel "c_j (μM)"
set yrange [350:950]
set ytics 200
x=5

plot 	path31."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title ""

######################################################################################################
######################################################################################################

set format y ""
###################################################
set origin originx1+sizex1+shiftx1, originy+0*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 
set label 5 "{/:Bold Cb}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front
set cbrange [1:3]

plot 	path32."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label 5
set border 2 linewidth 1
set mytics 4
set ytics scale 0.5
set ytics out nomirror
unset ylabel

###################################################
set origin originx2+sizex2+shiftx2, originy+0*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex3,sizey2

set yrange [0:4.5]
set ytics 2
x=2

plot 	path31."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path32."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 1 lt 1 title ""

###################################################
set origin originx2+sizex2+shiftx2, originy+0*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex3,sizey2

set yrange [350:950]
set ytics 200
x=5

plot 	path31."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path32."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 1 lt 1 title ""


######################################################################################################
######################################################################################################

###################################################
set origin originx1+2*(sizex1+shiftx1), originy+0*(sizeyBlock+shiftyBlock)+2*sizey2+shifty1+shifty2
set size sizex1, sizey1

set border 0
set yrange [1:111]
unset ylabel 
unset ytics 

set cbrange [1:3]
set label 1 "2 s" at xstart+9.6,-25
set arrow 1 from xstart+9,-7 to xstart+11,-7 as 1
set label 2 "40 μm" at xstart+11.7,0 rotate by 90
set arrow 2 from xstart+11.2,20 to xstart+11.2,60 as 1
# set arrow 3 from 6.9,19 to 7,11 as 2
# set arrow 4 from 6.9,49 to 7,56 as 2
# set arrow 5 from 6.8,95 to 6.9,85 as 2
set label 5 "{/:Bold Cc}" at graph 0.85,0.75 font ",16" tc rgb "#ffffff" front

plot 	path33."fluoxt.txt" every :16 u ($1/1000):2:($3/7) w image title ""

unset label
unset arrow
set border 2 linewidth 1
set mytics 4
set ytics scale 0.5
set ytics out nomirror
unset ylabel

###################################################
set origin originx2+sizex2+shiftx2+sizex3+shiftx2, originy+0*(sizeyBlock+shiftyBlock)+sizey2+shifty2
set size sizex3,sizey2

set yrange [0:4.5]
set ytics 2
x=2

plot 	path31."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path33."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 4 lt 1 title ""

###################################################
set origin originx2+sizex2+shiftx2+sizex3+shiftx2, originy+0*(sizeyBlock+shiftyBlock)+0*(sizey2+shifty2)
set size sizex3,sizey2

set yrange [350:950]
set ytics 200
x=5

plot 	path31."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 2 lt 1 title "",\
		path33."wholecell.txt" u ($1/1000):x every 4 w l lw 1 lc 4 lt 1 title ""


######################################################################################################
######################################################################################################
set border 0
unset xtics
unset ytics
unset xlabel
unset ylabel
set xrange [0:1]
set yrange [0:1]
set origin 0,0
set size 1,1

set label 1 'Control'        center at 0.23,0.98 font ",16"
set label 2 'Caffeine'       center at 0.55,0.98 font ",16"
set label 3 'Caffeine + ISO' center at 0.84,0.98 font ",16"
set label 101 "H = 2" center at 0,0.81 font ",16" rotate by 90
set label 102 "H = 7" at 0,0.45 font ",16" rotate by 90
set label 103 "H = 12" at 0,0.12 font ",16" rotate by 90
set arrow 1 from 0.02,0    to 0.02,0.29  nohead lw 5 lc rgb '#C0C0C0'
set arrow 2 from 0.02,0.33 to 0.02,0.625 nohead lw 5 lc rgb '#C0C0C0'
set arrow 3 from 0.02,0.67 to 0.02,0.96  nohead lw 5 lc rgb '#C0C0C0'

unset key

plot 100

unset multiplot
