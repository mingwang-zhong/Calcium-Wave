
reset
set term pdfcairo enhanced color size 7,4 font 'Helvetica,12' background rgb "#ffffff"
set output "cstarH_β0.001.pdf"
set multiplot 


originx=-0.02
originy=0.06
originy0=0.3

sizex1=0.36 # cstar vs H
sizex2=0.60 # linescan, Vm
shiftx1=0.02

sizey1=0.64 # cstar vs H
sizey2=0.17 # Vm or ci
sizey3=0.1 # I_Na

shifty=-0.05 # between linescan and Vm
blocky=0.0

###################################################################################
set origin originx, originy0
set size sizex1, sizey1

set border 15
set tics out scale 0.6 nomirror
set xrange [1.5:12.5]
set xtics 4 nomirror
set mxtics 4
set xlabel "H" 
set yrange [0.7:3.7]
set ytics 1 offset 0.6 nomirror
set mytics 5
set ylabel "c* (μM)" offset 1.3
set palette defined (1 '#FFFFFF', 2 '#005ab5', 3 '#E1BE6A', 4 '#40b0a6', 5 '#D41159', 6 '#66FF66',\
	 7 '#FECC66', 8 '#D35fb7', 9 '#E1BE6A', 10 '#FC6666', 11 '#994f00', 12 '#E66100') 
set cbrange [1:12]
# set cbtics add(1'Normal', 2'', 3'EAD3', 4'DAD', 5'', 6'', 7'Oscillation')
unset colorbox
unset key

set xlabel "H  "
# set label 1 "2 Hz" center at 7,3.8
set label 11 "{/:Bold A}" at graph -0.15,1.05 font ",16"


plot 	"DAD/data_beta0.001.txt" matrix u ($1+2):($2*0.2+0.8):3 w image pixels t "",\
		"<echo '6 1'" w p pt 4 ps 0.8 lw 2 lc -1,\
		"<echo '9 1.2'" w p pt 6 ps 0.8 lw 2 lc -1

unset label 1


###################################################################################################

unset xtics
unset xlabel
set border 0
unset ytics
unset ylabel
set yrange [-100:60]
set y2range [0:4]

set style arrow 1 head filled lw 1 lc -1 size screen 0.02,8

set size sizex2,sizey2
################################# EAD2 + EAD3 + DAD
set origin originx+sizex1+shiftx1,originy+2*(sizey2*2+shifty+blocky) + sizey2+shifty + sizey3+shifty
xstart=20.05
set xrange [xstart:(xstart+7.9)]
set y2range [0:4]
set arrow 1 from xstart-0.07,-80 to xstart-0.07,0 nohead lw 2 lc 1
set label 1 "80 mV" at xstart-0.25,-90 rotate by 90
set arrow 2 from second xstart+8.0,0 to second xstart+8.0,2 nohead lw 2 lc 2
set label 2 "2 μM" at second xstart+8.15,0 rotate by 90
set label 3 "▼" at xstart+2.32,35 font ",6" front
set label 4 "▲" at xstart+4.35,17 font ",6" # \t\t    ▲\t\t\t\t\t\t\t\t\t ♦
set label 5 "♦" at xstart+3.75,-70 font ",6" front
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1
set arrow 23 from xstart+4.05,95 to xstart+4.05,65 as 1
set arrow 24 from xstart+6.05,95 to xstart+6.05,65 as 1
set label 11 "{/:Bold B}" at graph -0.05,1.1

plot 	"DAD/Hill9_alpha0.2_beta0.001_cstar1.2/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill9_alpha0.2_beta0.001_cstar1.2/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		-30 w l lc -1 lw 0.5 dt 2

unset label 1
unset label 2
################################# EAD3 + DAD + EAD3-TAP + DAD-TAP
set origin originx+sizex1+shiftx1,originy+1*(sizey2*2+shifty+blocky) + sizey2+shifty + sizey3+shifty
xstart=6.05
set xrange [xstart:(xstart+7.9)]
set y2range [0:4]
set arrow 1 from xstart-0.07,-80 to xstart-0.07,0 nohead lw 2 lc 1
set arrow 2 from second xstart+8.0,0 to second xstart+8.0,2 nohead lw 2 lc 2
set label 2 "◼" at xstart+0.92,49 font ",9"  # DAD-TA
set label 3 "◼" at xstart+1.55,49 font ",9"   # DAD-TA
set label 4 "▼" at xstart+2.35,49 font ",6" # EAD3-TA
set label 5 "▼" at xstart+2.62,-30 font ",6" # EAD3
set label 6 "♦" at xstart+3.02,-60 font ",6" # DAD
set label 7 "◼" at xstart+4.57,49 font ",9"   # DAD-TA
set label 8 "▼" at xstart+4.97,47 font ",6" # EAD3-TA
set label 9 "▼" at xstart+5.25,47 font ",6" # EAD3-TA
set label 10 "▼" at xstart+5.50,-30 font ",6" # EAD3
set label 12 "♦" at xstart+5.84,-58 font ",6" # DAD
set label 13 "◼" at xstart+6.40,49 font ",9"   # DAD-TA
set label 14 "▼" at xstart+6.70,47 font ",6" # EAD3-TA ⬟
set label 15 "▼" at xstart+6.95,-30 font ",6"
set label 12 "♦" at xstart+7.28,-58 font ",6" # DAD
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1
set arrow 23 from xstart+4.05,95 to xstart+4.05,65 as 1
set arrow 24 from xstart+6.05,95 to xstart+6.05,65 as 1
set label 11 "{/:Bold C}" at graph -0.05,1.1

plot 	"DAD/Hill6_alpha0.2_beta0.001_cstar1/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill6_alpha0.2_beta0.001_cstar1/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		-30 w l lc -1 lw 0.5 dt 2


unset label
unset arrow
################################# Vm oscillations
set origin originx+sizex1+shiftx1,originy+0*(sizey2*2+shifty+blocky) + sizey2+shifty + sizey3+shifty
xstart=6.05
set xrange [xstart:(xstart+7.9)]
set y2range [0:4]
set arrow 1 from xstart-0.07,-80 to xstart-0.07,0 nohead lw 2 lc 1
set arrow 2 from second xstart+8.0,0 to second xstart+8.0,2 nohead lw 2 lc 2
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1
set arrow 22 from xstart+0.55,95 to xstart+0.55,65 as 1
set arrow 23 from xstart+1.05,95 to xstart+1.05,65 as 1
set arrow 24 from xstart+1.55,95 to xstart+1.55,65 as 1
set arrow 25 from xstart+2.05,95 to xstart+2.05,65 as 1
set arrow 26 from xstart+2.55,95 to xstart+2.55,65 as 1
set arrow 27 from xstart+3.05,95 to xstart+3.05,65 as 1
set arrow 28 from xstart+3.55,95 to xstart+3.55,65 as 1
set label 11 "{/:Bold D}" at graph -0.05,1.1 font ",16"

set label 31 '-61 mV' at xstart+6.55,-93
set arrow 31 from xstart+6.06,-61 to xstart+6.50,-93 head filled lw 1 lc -1 size screen 0.01,15

plot 	"DAD_2Hz/Hill5_alpha0.2_beta0.001_cstar1.6/wholecell.txt" u ($1/1000):7 w l,\
		"DAD_2Hz/Hill5_alpha0.2_beta0.001_cstar1.6/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		-61 w l lc -1 lw 0.5 dt 2



unset label
unset arrow

##################### I_Na
set size sizex2, sizey3
set origin originx+sizex1+shiftx1,originy+0*(sizey2*2+shifty+blocky) + sizey2+shifty

set yrange [-1.2:0]
set arrow 1 from xstart-0.07,-1 to xstart-0.07,0 nohead lw 2 lc rgb '#994F00'
set label 1 '1 pA/pF' center at xstart-0.25,-0.5 rotate by 90 tc rgb '#994F00'
set label 2 '{/Helvetica-Italic I}_{Na}' center at xstart+0.25,-0.7 tc rgb '#994F00'
plot "DAD_2Hz/Hill5_alpha0.2_beta0.001_cstar1.6/wholecell.txt" u ($1/1000):18 w l lc rgb '#994F00'


unset label
unset arrow




set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )
set yrange [0:102]
set cbrange [1:5]
set cbtics 2
set mcbtics 2
set size sizex2,sizey2
#################### EEAD2 + EAD3 + DAD
set origin originx+sizex1+shiftx1,originy+2*(sizey2*2+shifty+blocky) + sizey3+shifty
xstart=20.05
set xrange [xstart:(xstart+7.9)]
set y2range [0:4]
set arrow 1 from xstart-0.07,20 to xstart-0.07,70 lw 2 nohead
set label 1 '50 μm' at xstart-0.25,10 rotate by 90

set cbtics nomirror 2 offset -1.2,0 scale 0.7 in
set colorbox user origin 0.94,originy+2*(sizey2*2+shifty+blocky)+sizey3-0.018 size 0.013,0.11 noborder
set cblabel "F/F_0" rotate by 90 offset -0.5

plot 	"DAD/Hill9_alpha0.2_beta0.001_cstar1.2/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image

unset label 1
#################### EAD3 + DAD + EAD3-TAP + DAD-TAP
set origin originx+sizex1+shiftx1,originy+1*(sizey2*2+shifty+blocky) + sizey3+shifty
xstart=6.05
set xrange [xstart:(xstart+7.9)]
set y2range [0:4]
set arrow 1 from xstart-0.07,20 to xstart-0.07,70 lw 2 nohead

set cbtics nomirror 2 offset -1.2,0 scale 0.7 in
set colorbox user origin 0.94,originy+1*(sizey2*2+shifty+blocky)+sizey3-0.018 size 0.013,0.11 noborder
set cblabel "F/F_0" rotate by 90 offset -0.5

plot 	"DAD/Hill6_alpha0.2_beta0.001_cstar1/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image


#################### voltage oscillations
set origin originx+sizex1+shiftx1,originy+0*(sizey2*2+shifty+blocky)
xstart=6.05
set xrange [xstart:(xstart+7.9)]
set y2range [0:4]
set arrow 1 from xstart-0.07,20 to xstart-0.07,70 lw 2 nohead
set arrow 2 from xstart+0.05,-6 to xstart+0.55,-6 lw 2 nohead
set label 2 "0.5 s" at xstart+0.09,-18

set cbtics nomirror 2 offset -1.2,0 scale 0.7 in
set colorbox user origin 0.94,originy+0*(sizey2*2+shifty+blocky)+0.032 size 0.013,0.11 noborder
set cblabel "F/F_0" rotate by 90 offset -0.5

plot 	"DAD_2Hz/Hill5_alpha0.2_beta0.001_cstar1.6/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image
 
unset label
unset arrow
##################################################################################
##################################################################################
set origin 0,0
set size 1,1
set border 0
unset xtics 
unset ytics 
unset xlabel
unset ylabel
unset y2tics
unset y2label
set xrange [0:100]
set yrange [0:100]
unset key

startx1=4
startx2=15
starty=24
dx=1.5
dy=5

set label 1 "Normal" at startx1+dx,starty
set label 2 "EAD_2" at startx1+dx,starty-dy
set label 3 "DAD" at startx1+dx,starty-dy*2
set label 7 "DAD-TAP" at startx1+dx,starty-dy*3
set label 4 "EAD_2+EAD_3" at startx2+dx,starty
set label 5 "EAD_2+DAD" at startx2+dx,starty-dy
set label 6 "EAD_2+EAD_3+DAD" at startx2+dx,starty-dy*2
set label 8 "Complex" at startx2+dx,starty-dy*3

normal=starty;
EAD2=starty-dy;
DAD=starty-dy*2;
DADTAP=starty-dy*3;
EAD2EAD3=starty
EAD2DAD=starty-dy;
EAD2EAD3DAD=starty-dy*2
complex=starty-dy*3;

set object 1 rect from startx1-2,starty+4 to startx2+16,starty-19 fc rgb "#F0F0F0" fs solid 1 border rgb "#F0F0F0" back # F6F6F6
set object 2 rect from 51,-2 to 86,4.9 fc rgb "#F0F0F0" fs solid 1 border rgb "#F0F0F0" back # F6F6F6
set label 9 '▲                          ▼                           ♦' at 53,2.5 font ",6" #  ⬢⬟ hexagon
set label 10 '◼' at 75.5,2.5 font ",9"
set label 11 'EAD_2        EAD_3        DAD        DAD-TAP' at 54,2.5

plot	200,\
		"<echo ".startx1." ".normal w p pt 5 ps 1.2 lc rgb "#FFFFFF",\
		"<echo ".startx1." ".EAD2 w p pt 5 ps 1.2 lc rgb "#005ab5",\
		"<echo ".startx1." ".DAD w p pt 5 ps 1.2 lc rgb "#40b0a6",\
		"<echo ".startx1." ".DADTAP w p pt 5 ps 1.2 lc rgb "#D35fb7",\
		"<echo ".startx2." ".EAD2EAD3 w p pt 5 ps 1.2 lc rgb "#994f00",\
		"<echo ".startx2." ".EAD2DAD w p pt 5 ps 1.2 lc rgb "#D41159",\
		"<echo ".startx2." ".EAD2EAD3DAD w p pt 5 ps 1.2 lc rgb "#E66100",\
		"<echo ".startx2." ".complex w p pt 5 ps 1.2 lc rgb "#E1BE6A",\
		"<echo '34 64'" w p pt 4 ps 0.8 lw 2 lc -1,\
		"<echo '34 95'" w p pt 6 ps 0.8 lw 2 lc -1
		

unset multiplot