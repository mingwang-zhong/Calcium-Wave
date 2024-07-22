
reset
set term pdfcairo enhanced color size 3.5,4 font 'Helvetica,10' background rgb "#ffffff"
set output "tauu_effect_ncu_ncb.pdf"

set multiplot 

path1="Hill7_cstar1.1_ISO/"
path2="Hill7_cstar1.1_ISO_tauu350ms/"
path3="Hill7_cstar1.1_ISO_tauu4350ms/"


originx=0.01
sizex=1.0-originx

originy=0.01
sizey=0.2
shifty=0.0

set border 2
set tics out nomirror
unset xtics
set format x ''
xstart=14000-100
set xrange [xstart:(xstart+8500)]
set size sizex,sizey
set mytics 2





set style arrow 1 head filled size screen 0.02,12 ls 1 lw 1 lc -1

########################################################## Vm
set origin originx, originy+4*(sizey+shifty)
set yrange [-100:60]
set ytics 40
set ytics add('0'0)
set ylabel 'V_m (mV)'
set label 1 "{/:Bold A}" at graph -0.15,0.95 font ",16"
set key spacing 1.5 right at xstart+8500,65

set arrow 11 from xstart+200,80 to xstart+200,55 as 1
set arrow 12 from xstart+2200,80 to xstart+2200,55 as 1
set arrow 13 from xstart+4200,80 to xstart+4200,55 as 1
set label 11 "◼" at xstart+1800,50 font ",9"
set label 12 "◼" at xstart+3550,50 font ",9"
set label 13 "◼" at xstart+5300,50 font ",9"
set label 14 "♦" at xstart+7100,-60 font ",6"

x=7
plot 	path1."wholecell.txt" every 4 u 1:x w l t 'τ_u(c_j)',\
		path2."wholecell.txt" every 4 u 1:x w l lc 2 t 'τ_u = 350 ms',\
		path3."wholecell.txt" every 4 u 1:x w l lc 4 t 'τ_u = 4350 ms'

unset arrow
unset label 11
unset label 12
unset label 13
unset label 14
unset key


########################################################## NCU
set origin originx, originy+3*(sizey+shifty)
set yrange [0:60]
set ytics 20
set ytics add('0'0)
set ylabel '{/Helvetica-Italic N}_{CU}'
set label 1 "{/:Bold B}"

x=23
plot 	path1."wholecell.txt" every 4 u 1:x w l,\
		path2."wholecell.txt" every 4 u 1:x w l lc 2,\
		path3."wholecell.txt" every 4 u 1:x w l lc 4

########################################################## NOU
set origin originx, originy+2*(sizey+shifty)
set yrange [0:14]
set ytics 4
set ytics add('0'0)
set ylabel '{/Helvetica-Italic N}_{OU}'
set label 1 "{/:Bold C}"

x=21
plot 	path1."wholecell.txt" every 4 u 1:x w l,\
		path2."wholecell.txt" every 4 u 1:x w l lc 2,\
		path3."wholecell.txt" every 4 u 1:x w l lc 4

########################################################## NCB
set origin originx, originy+1*(sizey+shifty)
set yrange [20:90]
set ytics 20
set ytics add('20'20)
set ylabel '{/Helvetica-Italic N}_{CB}'
set label 1 "{/:Bold D}"

x=24
plot 	path1."wholecell.txt" every 4 u 1:x w l,\
		path2."wholecell.txt" every 4 u 1:x w l lc 2,\
		path3."wholecell.txt" every 4 u 1:x w l lc 4


########################################################## NOB
set origin originx, originy+0*(sizey+shifty)
set yrange [0:7]
set ytics 2
set ytics add('  0'0)
set ylabel '{/Helvetica-Italic N}_{OB}'
set label 1 "{/:Bold E}"
set arrow 2 from xstart+200,-0.4 to xstart+1200,-0.4 nohead lw 2
set label 2 '1 s' center at xstart+700,-1.1

x=22
plot 	path1."wholecell.txt" every 4 u 1:x w l,\
		path2."wholecell.txt" every 4 u 1:x w l lc 2,\
		path3."wholecell.txt" every 4 u 1:x w l lc 4


