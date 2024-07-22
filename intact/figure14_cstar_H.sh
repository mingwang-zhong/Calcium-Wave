

reset
set term pdfcairo enhanced color size 7,5 font 'Helvetica,12' background rgb "#ffffff"
set output "cstarH_β0.004.pdf"
set multiplot 

set border 15
set tics out scale 0.6 nomirror
set xrange [1.5:12.5]
set xtics 4
set mxtics 4
set xlabel "H"
set yrange [0.7:3.7]
set ytics 1
set mytics 5
set ylabel "c* (μM)" offset 1.3
# set palette defined (1 '#E0E0E0', 2 '#3B37A3', 3 '#52B8D3', 4 '#51AA1A', 5 '#990099', 6 '#FF9933', 7 '#D12921') 
set palette defined (1 '#FFFFFF', 2 '#005ab5', 3 '#E1BE6A', 4 '#40b0a6', 5 '#D41159', 6 '#66FF66', 7 '#FECC66', 8 '#D35fb7', 9 '#E1BE6A', 10 '#FC6666') 
set cbrange [1:10]
unset colorbox
unset key

# set x2range [2:13]
# set x2tics 1 scale 0 nomirror
# set mx2tics 15
set y2range [0.8:3.8]
set y2tics 0.2 scale 0 nomirror
# set my2tics 20
# set grid mx2tics my2tics x2tics y2tics front lt 1 lc rgb "#ffffff" lw 0.5 dt 2
# set x2tics format ""
set y2tics format ""

set origin -0.01,0.46
set size 0.37,0.5
set xlabel "H     " offset 0, 0.5
# set label 1 "{/Symbol-Italic b} = 0.004 ms^{-1}" at 5,3.9
set label 11 "{/:Bold A}" at graph -0.1,1.1 font ",18"
plot 	"DAD/data_beta0.004.txt" matrix u ($1+2):($2*0.2+0.8):3 w image pixels t "",\
		"<echo '12 3'"   w p pt 6  ps 0.8 lw 2 lc -1,\
		"<echo '6  0.8'" w p pt 10 ps 0.8 lw 2 lc -1,\
		"<echo '7  1.2'" w p pt 12 ps 0.8 lw 2 lc -1,\
		"<echo '2  3.2'" w p pt 4  ps 0.8 lw 2 lc -1,\
		"<echo '6  1.2'" w p pt 14 ps 0.8 lw 2 lc -1,\
		"<echo '12 0.8'" w p pt 8  ps 0.8 lw 2 lc -1


###################################################################################################
originx1=0.03 # normal, bottom left
originx=0.35
originy=0.04

sizex1=0.33 # Vm or ci, bottom left
sizex2=0.33 # linescan, bottom left
sizex3=0.64 # Vm or ci
sizex4=0.64 # linescan
shiftx1=-0.02 # between EAD2 and EAD3

sizey1=0.14 # linescan
sizey2=0.14 # Vm or ci

shifty=-0.04 # between linescan and Vm
shiftyBlock=0.0

unset xtics
unset xlabel
set border 0
unset ytics
unset ylabel


set style arrow 1 head filled lw 1 lc -1 size screen 0.015,12

set size sizex1,sizey2

################################# Normal
set origin originx1, originy+0*(sizey1+shifty+sizey2+shiftyBlock) + sizey1+shifty
xstart=12.05
set xrange [xstart:(xstart+3.2)]
set yrange [-87:60]
set y2range [0:4]
set arrow 1 from xstart-0.07,-80 to xstart-0.07,0 nohead lw 2 lc 1 # Vm
set label 1 "80 mV" at xstart-0.25,-80 rotate by 90
set arrow 2 from second xstart+3.25,0 to second xstart+3.25,2 nohead lw 2 lc 2 # ci
set label 2 "2 μM" at second xstart+3.35,0 rotate by 90
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1 # stimulus
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1 # stimulus
set label 11 "{/:Bold B}" at graph -0.15,1.05

plot 	"DAD/Hill12_alpha0.2_beta0.004_cstar3/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill12_alpha0.2_beta0.004_cstar3/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		-87 w l lc -1 lw 0.5 dt 2

unset label 12
unset label 2
unset label 1



set size sizex3,sizey2
################################# DAD, organized wave
set origin originx, originy+3*(sizey1+shifty+sizey2+shiftyBlock) + sizey1+shifty
xstart=14.05
set xrange [xstart:(xstart+7.0)]
set y2range [0:4]

set arrow 1 from xstart-0.07,-80 to xstart-0.07,0 nohead lw 2 lc 1 # Vm
set arrow 2 from second xstart+7.08,0 to second xstart+7.08,2 nohead lw 2 lc 2 # ci
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1 # stimulus
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1 # stimulus
set arrow 23 from xstart+4.05,95 to xstart+4.05,65 as 1 # stimulus
set arrow 24 from xstart+6.05,95 to xstart+6.05,65 as 1 # stimulus
set label 2 "♦" at xstart+1.70,-55 font ",6"
set label 3 "♦" at xstart+3.5,-60 font ",6"
set label 11 "{/:Bold C}" at graph -0.05,1.05


plot 	"DAD/Hill7_alpha0.2_beta0.004_cstar1.2/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill7_alpha0.2_beta0.004_cstar1.2/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		-87 w l lc -1 lw 0.5 dt 2

unset arrow 1
unset label 1

################################# DAD, synchronized wave
set origin originx, originy+2*(sizey1+shifty+sizey2+shiftyBlock) + sizey1+shifty
xstart=12.05
set xrange [xstart:(xstart+7.0)]
set y2range [0:4]
set arrow 1 from xstart-0.07,-80 to xstart-0.07,0 nohead lw 2 lc 1 # Vm
set arrow 2 from second xstart+7.08,0 to second xstart+7.08,2 nohead lw 2 lc 2 # ci
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1 # stimulus
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1 # stimulus
set arrow 23 from xstart+4.05,95 to xstart+4.05,65 as 1 # stimulus
set arrow 24 from xstart+6.05,95 to xstart+6.05,65 as 1 # stimulus
set label 2 "♦" at xstart+0.70,-60 font ",6"
set label 3 "♦" at xstart+2.66,-60 font ",6"
set label 4 "♦" at xstart+4.64,-60 font ",6"
set label 11 "{/:Bold D}"

plot 	"DAD/Hill3_alpha0.2_beta0.004_cstar3/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill3_alpha0.2_beta0.004_cstar3/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		-87 w l lc -1 lw 0.5 dt 2

################################# TA
set origin originx, originy+1*(sizey1+shifty+sizey2+shiftyBlock) + sizey1+shifty
xstart=20.05
set xrange [xstart:(xstart+7.0)]
set y2range [0:4]
set arrow 1 from xstart-0.07,-80 to xstart-0.07,0 nohead lw 2 lc 1 # Vm
set arrow 2 from second xstart+7.08,0 to second xstart+7.08,2 nohead lw 2 lc 2 # ci
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1 # stimulus
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1 # stimulus
set arrow 23 from xstart+4.05,95 to xstart+4.05,65 as 1 # stimulus
set arrow 24 from xstart+6.05,95 to xstart+6.05,65 as 1 # stimulus
set label 2 "◼" at xstart+1.59,50 font ",9"  
set label 3 "◼" at xstart+2.83,50 font ",9"  
set label 4 "◼" at xstart+3.70,50 font ",9"  
set label 5 "◼" at xstart+4.69,50 font ",9"  
set label 6 "◼" at xstart+5.47,50 font ",9"  
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1
set label 11 "{/:Bold E}"

plot 	"DAD/Hill6_alpha0.2_beta0.004_cstar1.2/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill6_alpha0.2_beta0.004_cstar1.2/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		-87 w l lc -1 lw 0.5 dt 2


unset label 2
unset label 3
unset label 4
unset label 5
unset label 6
unset arrow 23
unset arrow 24


set size sizex1,sizey2
################################# EAD2
set origin originx, originy+0*(sizey1+shifty+sizey2+shiftyBlock) + sizey1+shifty
xstart=12.05
set xrange [xstart:(xstart+3.2)]
set yrange [-87:60]
set y2range [0:4]
set arrow 1 from xstart-0.05,-80 to xstart-0.05,0 nohead lw 2 lc 1 # Vm
set arrow 2 from second xstart+3.25,0 to second xstart+3.25,2 nohead lw 2 lc 2 # ci
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1 # stimulus
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1 # stimulus
set label 2 "▲" at xstart+0.34,40 font ",6"
set label 3 "▲" at xstart+2.34,40 font ",6"
set label 11 "{/:Bold F}" at graph -0.1,1.05

plot 	"DAD/Hill12_alpha0.2_beta0.004_cstar0.8/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill12_alpha0.2_beta0.004_cstar0.8/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		(x<xstart+2.8)?(-30):1/0 w l lc -1 lw 0.5 dt 2

unset arrow 1
unset label 1
################################# EAD3
set origin originx+sizex1+shiftx1, originy+0*(sizey1+shifty+sizey2+shiftyBlock) + sizey1+shifty
xstart=18.05
set xrange [xstart:(xstart+3.2)]
set yrange [-87:60]
set y2range [0:4]
set arrow 1 from xstart-0.05,-80 to xstart-0.05,0 nohead lw 2 lc 1 # Vm
set arrow 2 from second xstart+3.25,0 to second xstart+3.25,2 nohead lw 2 lc 2 # ci
set arrow 21 from xstart+0.05,95 to xstart+0.05,65 as 1 # stimulus
set arrow 22 from xstart+2.05,95 to xstart+2.05,65 as 1 # stimulus
set label 2 "▼" at xstart+0.42,40 font ",6"
set label 3 "▼" at xstart+2.46,40 font ",6"
set label 11 "{/:Bold G}"
set label 12 '-30 mV' at xstart+1.1,-25

plot 	"DAD/Hill6_alpha0.2_beta0.004_cstar0.8/wholecell.txt" u ($1/1000):7 w l,\
		"DAD/Hill6_alpha0.2_beta0.004_cstar0.8/wholecell.txt" u ($1/1000):2 w l axes x1y2,\
		(x<xstart+1)?(-30):1/0 w l lc -1 lw 0.5 dt 2,\
		((x>xstart+1.9)&&(x<xstart+2.8))?(-30):1/0 w l lc -1 lw 0.5 dt 2

unset arrow 1
unset arrow 2
unset arrow 21
unset arrow 22
unset arrow 23
unset label 2
unset label 3
unset label 4
unset label 5
unset label 6
unset label 11
unset label 12
###################################################################################################
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )

set cbrange [1:5]
set mcbtics 2
set yrange [0:114]
set cbtics 2 offset -1 in
set cblabel "F/F_0" offset -1


set size sizex2,sizey1
#################### Normal
set origin originx1, originy+0*(sizey1+shifty+sizey2+shiftyBlock)
xstart=12.05
set xrange [xstart:(xstart+3.2)]
set y2range [0:4]
set arrow 2 from xstart-0.05,20 to xstart-0.05,70 nohead lw 2
set label 2 "50 μm" at xstart-0.2,10 rotate by 90
set arrow 3 from xstart+0.05,-9 to xstart+0.55,-9 lw 2 nohead
set label 3 "0.5 s" at xstart+0.08,-23
set colorbox user origin originx1+sizex2-0.04,originy+0*(sizey1+shifty+sizey2+shiftyBlock)+0.025 size 0.01,sizey1-0.055 noborder
# unset colorbox
unset cblabel

plot 	"DAD/Hill12_alpha0.2_beta0.004_cstar3/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image

set size sizex4,sizey1
unset arrow 
unset label
set cblabel "F/F_0" offset -1
#################### DAD, organized wave
set origin originx, originy+3*(sizey1+shifty+sizey2+shiftyBlock)
xstart=14.05
set xrange [xstart:(xstart+7.0)]
set y2range [0:4]
set arrow 2 from xstart-0.05,20 to xstart-0.05,70 nohead lw 2
set colorbox user origin originx+sizex4-0.04,originy+2*(sizey1+shifty+sizey2+shiftyBlock)+0.025 size 0.01,sizey1-0.055 noborder

plot 	"DAD/Hill7_alpha0.2_beta0.004_cstar1.2/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image


#################### DAD, synchronized wave
set origin originx, originy+2*(sizey1+shifty+sizey2+shiftyBlock)
xstart=12.05
set xrange [xstart:(xstart+7.0)]
set y2range [0:4]
set arrow 2 from xstart-0.05,20 to xstart-0.05,70 nohead lw 2
set colorbox user origin originx+sizex4-0.04,originy+1*(sizey1+shifty+sizey2+shiftyBlock)+0.025 size 0.01,sizey1-0.055 noborder

plot 	"DAD/Hill3_alpha0.2_beta0.004_cstar3/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image


#################### TA
set origin originx, originy+1*(sizey1+shifty+sizey2+shiftyBlock)
xstart=20.05
set xrange [xstart:(xstart+7.0)]
set y2range [0:4]
set arrow 2 from xstart-0.05,20 to xstart-0.05,70 nohead lw 2
set colorbox user origin originx+sizex4-0.04,originy+0*(sizey1+shifty+sizey2+shiftyBlock)+0.025 size 0.01,sizey1-0.055 noborder

plot 	"DAD/Hill6_alpha0.2_beta0.004_cstar1.2/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image



set size sizex2,sizey1
################### EAD2
set origin originx, originy+0*(sizey1+shifty+sizey2+shiftyBlock)
xstart=12.05
set xrange [xstart:(xstart+3.2)]
set y2range [0:4]
set arrow 2 from xstart-0.05,20 to xstart-0.05,70 nohead lw 2
set arrow 3 from xstart+0.05,-9 to xstart+0.55,-9 lw 2 nohead
unset colorbox

plot 	"DAD/Hill12_alpha0.2_beta0.004_cstar0.8/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image

unset arrow
unset label
################### EAD3
set origin originx+sizex1+shiftx1, originy+0*(sizey1+shifty+sizey2+shiftyBlock)
xstart=18.05
set xrange [xstart:(xstart+3.2)]
set y2range [0:4]
set arrow 2 from xstart-0.05,20 to xstart-0.05,70 nohead lw 2
set colorbox user origin originx+sizex4-0.04,originy+3*(sizey1+shifty+sizey2+shiftyBlock)+0.025 size 0.01,sizey1-0.055 noborder

plot 	"DAD/Hill6_alpha0.2_beta0.004_cstar0.8/fluoxt.txt" every :8 u ($1/1000):2:($3/5) w image

unset label
unset arrow
##################################################################################
##################################################################################
set origin -0.02,0
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


startx1=8
startx2=21
starty=42
dy=5

set label 1 "Normal" at startx1+2,starty
set label 2 "EAD_2" at startx1+2,starty-dy
set label 3 "EAD_3" at startx1+2,starty-dy*2
set label 4 "DAD" at startx2+2,starty-2
set label 5 "DAD-TAP" at startx2+2,starty-dy-2
set label 6 '▲                          ▼                           ♦' at 52,1.9 font ",6"
set label 7 'EAD_2        EAD_3        DAD        DAD-TAP' at 53,1.9  #  ⬢⬟ hexagon
set label 8 '◼' at 74.5,1.9 font ",9" # 

normal=starty;
EAD2=starty-dy;
EAD3=starty-dy*2;
DAD=starty-2;
DADTAP=starty-dy-2;

set object 1 rect from startx1-2,starty+2 to startx2+10,starty-12 fc rgb "#F0F0F0" fs solid 1 border rgb "#F0F0F0" back # F6F6F6
set object 2 rect from 50,-2 to 86,3.6 fc rgb "#F0F0F0" fs solid 1 border rgb "#F0F0F0" back # F6F6F6


plot	200,\
		"<echo '36.5 97'" w p pt 12 ps 0.8 lw 2 lc -1,\
		"<echo '36.5 72'" w p pt 4  ps 0.8 lw 2 lc -1,\
		"<echo '36.5 47'" w p pt 14 ps 0.8 lw 2 lc -1,\
		"<echo '36.5 22'" w p pt 8  ps 0.8 lw 2 lc -1,\
		"<echo '69.5 22'" w p pt 10 ps 0.8 lw 2 lc -1,\
		"<echo '1  22'" w p pt 6  ps 0.8 lw 2 lc -1,\
		"<echo ".startx1." ".normal w p pt 5 ps 1.2 lc rgb "#FFFFFF",\
		"<echo ".startx1." ".EAD2 w p pt 5 ps 1.2 lc rgb "#005ab5",\
		"<echo ".startx1." ".EAD3 w p pt 5 ps 1.2 lc rgb "#E1BE6A",\
		"<echo ".startx2." ".DAD w p pt 5 ps 1.2 lc rgb "#40b0a6",\
		"<echo ".startx2." ".DADTAP w p pt 5 ps 1.2 lc rgb "#D35fb7"

unset multiplot





