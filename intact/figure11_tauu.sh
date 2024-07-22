reset
set term pdfcairo enhanced color size 5.5,4 font 'Helvetica,10' background rgb "#ffffff"
set output "tauu_effect.pdf"

set multiplot 

path1="Hill7_cstar1.1_ISO/"
path2="Hill7_cstar1.1_ISO_tauu350ms/"
path3="Hill7_cstar1.1_ISO_tauu4350ms/"

path_T1="Hill7_cstar1.1_ISO_restitution/"
path_T2="Hill7_cstar1.1_ISO_tauu350ms_restitution/"
path_T3="Hill7_cstar1.1_ISO_tauu4350ms_restitution/"

originx1=-0.01
sizex1=0.6-originx1

originx2=0.049 # image
sizex2=0.6-originx2 # image

originx4=0.6 # restitution
sizex4=0.4

originy=0.01
sizey1=0.26
shifty1=-0.01

sizey2=0.15 # image
shifty2=-0.027

sizey3=0.12 # ci zoom in

originy4=0
sizey4=0.37
shifty4=-0.05



set border 2
set style arrow 1 head filled lw 1 size screen 0.015,15
unset xtics
unset xlabel
xstart=14000-100
set xrange [xstart:(xstart+8500)]
set mytics 2
set ytics out scale 0.7 nomirror offset 0.6
unset ylabel
unset key
path1="Hill7_cstar1.1_ISO/"
path2="Hill7_cstar1.1_ISO_tauu350ms/"
path3="Hill7_cstar1.1_ISO_tauu4350ms/"

set size sizex1,sizey1
########################################################## cj
set origin originx1, originy+1*(sizey1+shifty1)+sizey3+shifty1-0.01
set yrange [350:900]
set ytics 200
set ytics add('600'600)
set ylabel 'c_j (μM)'
set label 11 "{/:Bold B}" at graph -0.13,0.95 font ",16"

plot 	path1."wholecell.txt" every 4 u 1:5 w l,\
		path2."wholecell.txt" every 4 u 1:5 w l lc 2,\
		path3."wholecell.txt" every 4 u 1:5 w l lc 4

########################################################## ci
set origin originx1, originy+0*(sizey1+shifty1)+sizey3+shifty1-0.015
set yrange [0:3.5]
set ytics 1
set ytics add('   0'0)
set ylabel 'c_i (μM)' offset 1,-4
set label 11 "{/:Bold C}"
set key at xstart+8500,4.5 spacing 1.5

plot 	path1."wholecell.txt" every 4 u 1:2 w l t "τ_u (c_j)",\
		path2."wholecell.txt" every 4 u 1:2 w l lc 2 t "τ_u = 350 ms",\
		path3."wholecell.txt" every 4 u 1:2 w l lc 4 t "τ_u = 4350 ms"


unset key
unset label
unset arrow
set size sizex1,sizey3
########################################################## ci, zoom in
set origin originx1, originy
set yrange [0.1:0.3]
set ytics 0.1
set ytics add(' 0.1'0.1)
set ylabel " _ "

plot 	path1."wholecell.txt" every 4 u 1:2 w l t "",\
		path2."wholecell.txt" every 4 u 1:2 w l lc 2 t "",\
		path3."wholecell.txt" every 4 u 1:2 w l lc 4 t ""


set border 0

set size sizex2,sizey2
########################################################## line scan
set origin originx2, originy+2*(sizey1+shifty1)+(sizey3+shifty1)+2*(sizey2+shifty2)
unset ytics
unset ylabel
set yrange [0:105]
set arrow 2 from xstart+22600,20 to xstart+22600,70 nohead lw 2
set label 2 '50 μm' at xstart+23000,25 rotate by 90
set cbrange [1:3]
set cbtics 1 offset -4.5 scale 0.6 nomirror
set mcbtics 2
set cblabel 'F/F_0' offset -8.3

set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' ) # 0.33333 '#4286de', 
set colorbox user origin originx2+0.002,originy+2*(sizey1+shifty1)+(sizey3+shifty1)+2*(sizey2+shifty2)+0.025 size 0.015,sizey2-0.05 noborder

set label 11 "{/:Bold A}" at graph -0.13,0.95 font ",16"
set object 11 rect from graph 0.02,0.7 to graph 0.12,0.97 fc rgb "#ffffff" fs solid 0 border rgb '#ffffff' front
set label 1 'τ_u (c_j)' left at graph 0.025, 0.87 front

plot 	path1."fluoxt.txt" every :8 u 1:2:($3/7) w image

unset label 11
##########################################################
set origin originx2, originy+2*(sizey1+shifty1)+(sizey3+shifty1)+1*(sizey2+shifty2)
set colorbox user origin originx2+0.002,originy+2*(sizey1+shifty1)+(sizey3+shifty1)+1*(sizey2+shifty2)+0.025 size 0.015,sizey2-0.05 noborder
set object 11 rect from graph 0.02,0.72 to graph 0.22,0.97
set label 1 "τ_u = 350 ms"

plot 	path2."fluoxt.txt" every :8 u 1:2:($3/7) w image

##########################################################
set origin originx2, originy+2*(sizey1+shifty1)+(sizey3+shifty1)
set colorbox user origin originx2+0.002,originy+2*(sizey1+shifty1)+(sizey3+shifty1)+0.025 size 0.015,sizey2-0.05 noborder
set object 11 rect from graph 0.02,0.72 to graph 0.23,0.97
set label 1 "τ_u = 4350 ms"

set arrow 11 from 100,-30 to 100,-4 as 1
set arrow 12 from 2100,-30 to 2100,-4 as 1
set arrow 13 from 4100,-30 to 4100,-4 as 1
set arrow 14 from 6100,-30 to 6100,-4 as 1
set arrow 15 from 8100,-30 to 8100,-4 as 1
set arrow 16 from 10100,-30 to 10100,-4 as 1
set arrow 17 from 12100,-30 to 12100,-4 as 1
set arrow 18 from 14100,-30 to 14100,-4 as 1
set arrow 19 from 16100,-30 to 16100,-4 as 1
set arrow 20 from 18100,-30 to 18100,-4 as 1

plot 	path3."fluoxt.txt" every :8 u 1:2:($3/7) w image


unset arrow
unset label
unset object
set size sizex4,sizey4
set border 3
set tics out scale 0.7 nomirror
set xlabel 'Time (ms)' offset 0,1
set xrange [0:1000]
set xtics 500 offset 0,0.5 nomirror
set mxtics 5
set ylabel 'SR depletion (μM)' offset 1
set yrange [0:350]
set ytics 100 offset 0.5 nomirror
set mytics 2
path1='Hill7_cstar1.1_ISO_restitution/'
path2='Hill7_cstar1.1_ISO_tauu350ms_restitution/'
path3='Hill7_cstar1.1_ISO_tauu4350ms_restitution/'
##########################################################
########################################################## restitution

set origin originx4, originy4+0*(sizey4+shifty4)
set label 11 "{/:Bold F}" at graph -0.25,0.95 font ",16"
set label 1 '204.59-204.59exp\{-(t-34.94)/97.56\}' right at graph 1.05,0.1 front tc lt 4
set key right at 1000,750 spacing 1.3
plot 	path3.'ratio_vs_t.txt' u 1:( ($1>20)?$8:1/0 ) w p pt 8 ps 0.5 lc '#C0C0C0' t '',\
		path1.'ratio_vs_t_avg.txt' u 1:( ($1>20)?$2:1/0 ) w p pt 5 ps 0.4 lc 1 t 'τ_u (c_j)',\
		path2.'ratio_vs_t_avg.txt' u 1:( ($1>20)?$2:1/0 ) w p pt 7 ps 0.4 lc 2 t 'τ_u = 350 ms',\
		path3.'ratio_vs_t_avg.txt' u 1:( ($1>20)?$2:1/0 ) w p pt 9 ps 0.4 lc 4 t 'τ_u = 4350 ms',\
		203.44-203.44*exp(-(x-41.08)/109.06) w l lw 2 lc 1 t '',\
		150.30-150.30*exp(-(x-49.90)/67.39) w l lw 2 lc 2 t '',\
		204.59-204.59*exp(-(x-34.94)/97.56) w l lw 2 lc 4 t ''


set xlabel ' ' offset 0,1
set xtics add(' '0, ' '500, ' '1000)
unset key

set origin originx4, originy4+1*(sizey4+shifty4)
set label 11 "{/:Bold E}"
set label 1 '150.30-150.30exp\{-(t-49.90)/67.39\}' tc lt 2
plot 	path2.'ratio_vs_t.txt' u 1:( ($1>20)?$8:1/0 ) w p pt 6 ps 0.5 lc '#C0C0C0' t '',\
		path2.'ratio_vs_t_avg.txt' u 1:( ($1>20)?$2:1/0 ) w p pt 7 ps 0.4 lc 2 t '',\
		150.30-150.30*exp(-(x-49.90)/67.39) w l lw 2 lc 2 t ''

		
set origin originx4, originy4+2*(sizey4+shifty4)
set label 11 "{/:Bold D}"
set label 1 '203.44-203.44exp\{-(t-41.08)/109.06\}' tc lt 1
plot 	path1.'ratio_vs_t.txt' u 1:( ($1>30)?$8:1/0 ) w p pt 4 ps 0.5 lc '#C0C0C0' t '',\
		path1.'ratio_vs_t_avg.txt' u 1:( ($1>20)?$2:1/0 ) w p pt 5 ps 0.4 lc 1 t '',\
		203.44-203.44*exp(-(x-41.08)/109.06) w l lw 2 lc 1 t ''

reset
