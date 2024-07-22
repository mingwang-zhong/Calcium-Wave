reset

set term pdfcairo enhanced color size 6,5 font 'Helvetica,12' background rgb "#ffffff"
set output "superadditivity.pdf"
set multiplot

originx=0.05
originy=0.02

sizecix1=0.2
sizecix2=0.2
sizeciy1=0.225
sizeciy2=0.12
shiftx1=-0.04
shifty1=-0.04
jumpx=0.04

sizeCRUx1=0.2
sizeCRUx2=0.26
shiftx2=-0.06
shifty2=-0.04
sizeCRUz=0.22
sizeCRUz2=0.35

sizelinex=0.45
sizeliney=0.6
shiftx3=0.03
jumpy=0.05


set style arrow 1 head filled size screen 0.007,15 lw 1 lc -1
set style arrow 2 nohead lw 0.8 lc -1 dt 2
set style arrow 3 head empty size screen 0.025,10 lw 1 lc -1
########################################################################
########################################################################
set border 0
unset xtics
unset ytics
unset key

set origin -0.02,-0.02
set size 1.04,1.04
set xrange [0:100]
set yrange [0:100]
set arrow 1 from 14.4,3.7 to 14.4,97.0 as 2 dt 1
set arrow 3 from 13.8,3.7 to 13.8,97.0 as 2 dt 1
set arrow 4 from 10.5,97.8 to 13.5,97.0 filled size screen 0.005,20 lw 1 lc -1
set arrow 2 from 30.7,3.7 to 30.7,87.5 as 2
set label 1 "{/:Bold A}" at graph 0.03,0.98 font ",18"
set label 2 "{/:Bold B}" at graph 0.40,0.98 font ",18"
set label 3 "{/:Bold C}" at graph 0.62,0.98 font ",18"

plot 1000

unset arrow
unset label
unset object
########################################################################
########################################################################

path="Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3/image_cp/"

unset colorbox
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )
set cbrange [0:4]


set xrange [17.5:42.5]
set yrange [-0.5:25.5]
set size sizecix1,sizeciy1 
set size ratio -1

set origin originx, originy+4*(sizeciy1+shifty1)
set label 10 '{/Times z }{/Times = 5}' right at graph 1,1.08
set label 2 "24728 ms" at graph 0.05,0.1 tc rgb "#ffffff" front
set label 3 "{/Times i}" center at 30,29
set label 4 "{/Times i}{/Times +1}" center at 23,29
set arrow 101 from 45.4,21 to 42.7,21 as 3 lc 1
plot path."cp_xy_24728ms.txt" matrix w image pixels

unset label 10
unset label 3
unset label 4
unset arrow 1

set origin originx, originy+3*(sizeciy1+shifty1)
set label 2 "24733 ms"
plot path."cp_xy_24733ms.txt" matrix w image pixels

set origin originx, originy+2*(sizeciy1+shifty1)
set label 2 "24747 ms"
set arrow 102 from 26,18.5 to 28,20.5 head filled size screen 0.007,20 lw 1 lc rgb '#ffffff' front
set arrow 103 from 26,16.5 to 28,18.5 head filled size screen 0.007,20 lw 1 lc rgb '#ffffff' front
plot path."cp_xy_24747ms.txt" matrix w image pixels

unset arrow 102
unset arrow 103

set origin originx, originy+1*(sizeciy1+shifty1)
set label 2 "24798 ms"
set arrow 1 from 16.5,-0.5 to 16.5,25.5 as 1 # vertical arrow
set label 3 "26 CRUs" at 14.4,6 rotate by 90
set label 4 "{/Times y}" at 14,24.5
plot path."cp_xy_24798ms.txt" matrix w image pixels

set origin originx, originy+0*(sizeciy1+shifty1)
set label 2 "24828 ms"
set arrow 1 from 17.5,-1.5 to 42.5,-1.5 as 1
set label 3 "26 CRUs" center at 30,-3.5 rotate by 0
set label 4 "{/Times x}" at 41,-3.5
set cbtics nomirror 2 offset -1.2,0 scale 0 out offset -4.3
set colorbox user origin 0.05,0.044 size 0.015,0.17 noborder
set cblabel "[Ca^{2+}]_p (μM)" rotate by 90 offset -8
plot path."cp_xy_24828ms.txt" matrix w image pixels

unset label 2
unset label 3
unset label 4
unset arrow
unset colorbox
set xrange [17.5:42.5]
set yrange [-0.5:9.5]
set size sizecix2,sizeciy2

set origin originx+sizecix1+shiftx1, originy+4*(sizeciy1+shifty1)
set label 10 '{/Times y }{/Times = 22}' right at graph 1,1.2
set label 2 "{/Times i}" center at 30,13
set arrow 101 from 45.4,4 to 42.7,4 as 3 lc 2
plot path."cp_xz_24728ms_22.txt" matrix w image  pixels

unset label 10
unset label 2

set origin originx+sizecix1+shiftx1, originy+3*(sizeciy1+shifty1)
set arrow 102 from 26,5 to 28,3 head filled size screen 0.007,20 lw 1 lc rgb '#ffffff' front
plot path."cp_xz_24733ms_22.txt" matrix w image  pixels
unset arrow 102

set origin originx+sizecix1+shiftx1, originy+2*(sizeciy1+shifty1)
plot path."cp_xz_24747ms_22.txt" matrix w image  pixels

set origin originx+sizecix1+shiftx1, originy+1*(sizeciy1+shifty1)
plot path."cp_xz_24798ms_22.txt" matrix w image  pixels

set origin originx+sizecix1+shiftx1, originy+0*(sizeciy1+shifty1)
set arrow 1 from 17.5,-1.5 to 27.5,-1.5 as 1
set arrow 2 from 17,-0.5 to 17,9.5 as 1
set label 2 "{/Times x}" at 27,-3.2
set label 3 "{/Times z}" at 17,11.5 center
plot path."cp_xz_24828ms_22.txt" matrix w image  pixels

unset arrow
unset label
########################################################################
########################################################################
set border 15
set xrange [0:100]
set yrange [0:100]
set size noratio

#################################### xy
set origin originx+sizecix1+sizecix2+shiftx1+shiftx2+jumpx, originy+3*(sizeCRUz+shifty2)+jumpy
set size sizeCRUx1, sizeCRUz2
set arrow 1 from -3,-3 to 10,-3 as 1
set arrow 2 from -3,-3 to -3,10 as 1
set label 1 "{/Times x}" at 15,-3
set label 2 "{/Times z}" at -7,16
set label 4 "{/Times i}{/Times -1}" center at 20,107
set label 5 "{/Times i}" center at 50,107
set label 6 "{/Times i}{/Times +1}" center at 80,107
set label 7 "a" at graph 0.9,0.95
set arrow 3 from 20,0 to 20,100 as 2
set arrow 4 from 50,0 to 50,100 as 2
set arrow 5 from 80,0 to 80,100 as 2
plot 	1000 w l,\
		"<echo '20 10'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 20'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 30'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 40'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 50'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 60'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 70'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 80'" w p pt 7 ps 0.3 lc 9,\
		"<echo '20 90'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 10'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 20'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 30'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 40'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 50'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 60'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 70'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 80'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 90'" w p pt 7 ps 0.3 lc 9,\
		"<echo '80 50'" w p pt 5 ps 0.3 lc 1

unset label 
unset arrow

#################################### 1 y
set origin originx+sizecix1+sizecix2+shiftx1+shiftx2+jumpx, originy+2*(sizeCRUz+shifty2)
set size sizeCRUx1, sizeCRUz
set label 1 "Z-line {/Times i}{/Times +1}" right at 100,110
set label 2 "b" at graph 0.9,0.9
plot 	1000 w l,\
		"<echo '50 60'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 40'" w p pt 5 ps 0.3 lc 1

unset label
#################################### 1 z
set origin originx+sizecix1+sizecix2+shiftx1+shiftx2+jumpx, originy+1*(sizeCRUz+shifty2)
set size sizeCRUx1, sizeCRUz
set label 7 "c" at graph 0.9,0.9
plot 	1000 w l,\
		"<echo '50 60'" w p pt 7 ps 0.3 lc 9,\
		"<echo '33 40'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 40'" w p pt 5 ps 0.3 lc 1

#################################### 22 z
set origin originx+sizecix1+sizecix2+shiftx1+shiftx2+jumpx, originy+0*(sizeCRUz+shifty2)
set size sizeCRUx1, sizeCRUz
set arrow 1 from -3,-3 to 10,-3 as 1
set arrow 2 from -3,-3 to -3,10 as 1
set label 1 "{/Times z}" at 15,-4
set label 2 "{/Times y}" at -7,20
set label 7 "d" at graph 0.9,0.9
plot 	1000 w l,\
		"<echo '16 50'" w p pt 7 ps 0.3 lc 9,\
		"<echo '33 50'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 50'" w p pt 7 ps 0.3 lc 9,\
		"<echo '67 50'" w p pt 7 ps 0.3 lc 9,\
		"<echo '84 50'" w p pt 7 ps 0.3 lc 9,\
		"<echo '50 30'" w p pt 5 ps 0.3 lc 1

unset label
unset arrow

########################################################################
########################################################################
set origin originx+sizecix1+sizecix2+shiftx1+shiftx2+shiftx3+jumpx+sizeCRUx1+shiftx2, originy+0.5*(sizeCRUz+shifty2)+jumpy+0.05
set size sizelinex,sizeliney 
set border 3
set tics nomirror out scale 0.6
set xtics 20 offset 0,0.3 nomirror
set mxtics 2
set xrange [-10:60]
set xlabel "Time (ms)" offset 0,0.6
set ytics 0.2 offset 0.6 nomirror
set mytics 2
set yrange [0.2:0.9]
set ylabel "[Ca^{2+}]_p (μM)" offset 1.7
set key at 80,1 samplen 2
set label "a" at 22,0.38
set label "b" at 13,0.46
set label "c" at 11,0.76
set label "d" at 13,0.54
# set label "e" at 13,0.585
# set label "f" at 12,0.81

x=38
plot 	"Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299/wholecell.txt" u ($1-10):x w l lw 1.5 t "",\
		"Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_add1/wholecell.txt" u ($1-10):x w l lw 1.5 t "",\
		"Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_add1_add1z/wholecell.txt" u ($1-10):x w l lw 1.5 lc rgb '#994f00' t "",\
		"Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_add5/wholecell.txt" u ($1-10):x w l lw 1.5 t ""

unset arrow
unset label

unset multiplot

















