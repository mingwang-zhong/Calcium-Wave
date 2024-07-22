reset

set term pdfcairo enhanced color size 7,4 font 'Helvetica,12' background rgb "#ffffff"

set output "sparks.pdf"
set multiplot 

# size

sizex1=0.28 # spark rate
sizex2=0.26 # F/F0, FWHM, FDHM
sizex3=0.33 # I
sizex4=0.33 # image
shiftx=0.02

sizey1=0.5
sizey2=0.5
shifty=0.02

set style line 1 lc rgb "#8E8E8E" lw 1.5
####################################################################################
####################################################################################

set border 3
set tics out front
set xrange [-0.6:5.5]
set xtics nomirror out offset 0,1 rotate by 90 scale 0
set xtics add('0.1'0, '0.125'1, '0.15'2, '0.1'3, '0.125'4, '0.15'5, '0.175'6)
set xlabel "[Ca^{2+}]_i (μM)" offset 0,1.6
set mytics 2

set style histogram errorbars gap 1 linewidth 1
set style data histograms
set style fill solid 1 noborder
set boxwidth 0.8 relative
# set arrow 1 from -0.5,-0.2 to -0.5,0.2 nohead lw 3 lc rgb "#ffffff" front # rgb "#ffffff"
# set arrow 2 from 2.5,-0.2 to 2.5,0.2 nohead lw 3 lc rgb "#ffffff" front #rgb "#ffffff"

pathATP='Hill7_alpha0.2_beta0.004_cstar1.1/sparks.txt'
pathNoATP='Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/sparks.txt'

############################## spark rate ############################
set origin -0.02,sizey2-shifty
set size sizex1+0.01,sizey1
set ytics nomirror out 4 offset 0.6
set yrange [0:16]
set ylabel "{/=12 Spark frequency}\n{/=12 (sparks×(100 μm)^{-1}×s^{-1})}" offset 0.5 font ',16'
set label 5 "{/:Bold A}" at graph -0.3,1.05 font ",18"
set key at 5.5,17 spacing 1.3

plot 	pathATP u 0:($2-0.2):3 w yerrorbars ls 1 lc 1 pt 0 title "",\
		pathATP u 0:2:xtic(10) w boxes ls 1 lc 1 title "5 mM ATP",\
		pathNoATP u ($0+3):($2-0.2):3 w yerrorbars ls 1 lc 2  pt 0title "",\
		pathNoATP u ($0+3):($2):xtic(10) w boxes ls 1 lc 2 title "0 mM ATP"
################################ F/F_0 ###############################
set origin sizex1-shiftx-0.005,sizey2-shifty
set size sizex2,sizey1
set yrange [0:3.5]
set ytics nomirror out 1
set ylabel "Spark Amplitude F/F_0" offset 1.5 font ',12'
set label 5 "{/:Bold B}" at graph -0.3,1.05

plot	pathATP u 0:($4-0.02):5 w yerrorbars ls 1 lc 1 pt 0 title "",\
		pathATP u 0:4:xtic(10) w boxes ls 1 lc 1 title "",\
		pathNoATP u ($0+3):($4-0.02):5 w yerrorbars ls 1 lc 2 pt 0 title "",\
		pathNoATP u ($0+3):4:xtic(10) w boxes ls 1 lc 2 title ""

################################# FWHM ###############################
set origin sizex1+sizex2-2*shiftx,sizey2-shifty
set size sizex2,sizey1
set yrange [0:3.5]
set ytics nomirror out 1
set ylabel "Spark Width FWHM (μm)" offset 1.5
set label 5 "{/:Bold C}"

plot	pathATP i 0 u 0:($6-0.02):7 w yerrorbars ls 1 lc 1 pt 0 title "",\
		pathATP i 0 u 0:6:xtic(10) w boxes ls 1 lc 1 title "",\
		pathNoATP u ($0+3):($6-0.02):7 w yerrorbars ls 1 lc 2 pt 0 title "",\
		pathNoATP u ($0+3):6:xtic(10) w boxes ls 1 lc 2 title ""

################################# FDHM ###############################
set origin sizex1+2*sizex2-3*shiftx,sizey2-shifty
set size sizex2+0.01,sizey1
set yrange [0:30]
set ytics nomirror out 10
set mytics 2
set ylabel "Spark Duration FDHM (ms)" offset 1.5
set label 5 "{/:Bold D}"
# set arrow 1 from -0.9,22 to -0.9,42 nohead lw 36 lc bgnd front
# set arrow 2 from 2,22 to 2,42 nohead lw 36 lc bgnd front

plot	pathATP u 0:($8-0.6):9 w yerrorbars ls 1 lc 1 pt 0 title "",\
		pathATP u 0:8:xtic(10) w boxes ls 1 lc 1 title "",\
		pathNoATP u ($0+3):($8-0.6):9 w yerrorbars ls 1 lc 2 pt 0 title "",\
		pathNoATP u ($0+3):8:xtic(10) w boxes ls 1 lc 2 title ""



unset arrow
################################################################
################################################################
# set origin sizex1+2*sizex2-3*shiftx-0.009,sizey2-shifty+0.3
# set size sizex2+0.009,sizey1-0.3
# set yrange [40:140]
# set ytics nomirror out 40
# set ylabel "Spark Duration (ms)" offset 2 tc rgb "#ffffff00"
# set arrow 1 from -0.7,35 to -0.5,45 nohead lw 1
# set arrow 2 from -0.7,22 to -0.5,32 nohead lw 1
# set border 2
# unset label 
# unset xtics 
# unset xlabel

# plot	pathATP u 0:($8-0.6):9 w yerrorbars ls 1 lc 1 title "",\
# 		pathATP u 0:8:xtic(10) w boxes ls 1 lc 1 title "",\
# 		pathNoATP u ($0+4):($8-1.0):9 w yerrorbars ls 1 lc 2 title "",\
# 		pathNoATP u ($0+4):8:xtic(10) w boxes ls 1 lc 2 title ""

# set border 3
# unset arrow
####################################################################################
####################################################################################
set origin 0.005,0
set size sizex3-0.03, sizey2-0.02

set tics out

set xrange [-2:30]
set xtics nomirror 10 offset 0,0.5 rotate by 0
set xtics scale 0.7
set mxtics 2
set xlabel "Time (ms)" offset 0,0.5

set yrange [-0.2:4]
set ytics nomirror 2
set mytics 2
set ylabel "{/Helvetica-Italic I}_{rel} (pA)" offset 1 tc rgb "#000000"

set label 5 "{/:Bold E}" at graph -0.2,1.05 font ",18"

set key at 30,3.8

I1(x)=7.4*(1-exp(-x/6.409))*exp(-x/5.054)  # "#D1292180"
I2(x)=27.23*(1-exp(-x/5.066))*(exp(-x/3.251)-0.7618*exp(-x/2.011))

plot 	"Hill7_alpha0.2_beta0.004_cstar1.1/spark_ci0.1.txt" u ( ($1>7)?($1-10):1/0 ):( $2-$9 ):( $2+$9 ) w filledcurve fc rgb "#aaE0A080" t "",\
		"Hill7_alpha0.2_beta0.004_cstar1.1/spark_ci0.15.txt" u ( ($1>7)?($1-10):1/0 ):( $2-$9 ):( $2+$9 ) w filledcurve fc rgb "#aa629FA8" t "",\
		(x>=-0)?I1(x):0 lw 2.5 lc 1 t "0.1 μM",\
		(x>=-0)?I2(x):0 lw 2.5 lc 2 t "0.15 μM"


		# "Hill8_alpha0.3_beta0.02_custar1.3_cbstar5_Vup0.4/spark_ci0.3_linescan.txt" u ( ($1>7)?($1-10):1/0 ):2 w l lw 1.5 lc 3 t "0.3 μM",\
		# "Hill8_alpha0.3_beta0.02_custar1.3_cbstar5_Vup0.4/spark_ci0.4_linescan.txt" u ( ($1>7)?($1-10):1/0 ):2 w l lw 1.5 lc 6 t "0.4 μM",\

####################################################################################
set origin sizex3+0.02,0.09
set size sizex4,sizey2-0.15

set label 5 "{/:Bold F}" at graph 0,1.08

set border 0
unset colorbox
unset xtics 
unset xlabel
unset ytics 
unset ylabel

# set palette defined (0 '#3B37A3', 0.1 0.322 0.722 0.827, 0.37 0.318 0.667 0.102, 0.63 '#FFF35C', 0.9 '#D12921', 1 '#D12921' )
# set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' ) #  blue '#4286de'
set palette defined (0 '#3B37A3', 0.33333 '#4286de', 0.6667 '#c63361',  1 '#f5c344' ) #  Red: #c63361, blue: #4286de, orange: #f5c344, dark gree: #1e4c40
set xrange [0:300] # 300*0.2=60
set yrange [40:160] # 120*0.1=12
set cbrange [4.08:8.16] #7.955]
# set style fill solid 1 # for colorbox


path="Hill7_alpha0.2_beta0.004_cstar1.1/spark_ci01_avg_fluoxt.txt" #1.9196    1.8945   11.3103

plot 	path matrix w image t ""

#################################################################################### fine resolution
set origin sizex3+sizex4-shiftx+0.02+0.02,0.09
set size sizex4,sizey2-0.15

set label 5 "{/:Bold G}"

set xrange [0:60]
set yrange [-6:6]
set cbrange [1:2] #1.85]

set style arrow 1 nohead lw 3
set arrow 1 from 13,-6.3 to 23,-6.3 as 1
set label 1 "10 ms" at 14,-7
set arrow 2 from -54,-6.3 to -44,-6.3 as 1
set label 2 "10 ms" at -53.5,-7
set arrow 3 from -71.5,-1 to -71.5,1 as 1
set label 3 "2 μm" at -74,-1.3 rotate by 90
set style fill solid 1 noborder
set label 4 "F/F_0" at -40,-7.8
set cbtics 1 scale 0.5 nomirror offset 0,0.5
set cbtics add('1.5'1.5)
# set cbtics ('1'1, '1.4'1.4, '1.8'1.8)
set colorbox horizontal user origin 0.55,0.06 size 0.2,0.03 noborder


path="Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_0.8/fluoxt.txt"

plot 	path u 1:($2-6.6):($3/4.08) w image t ""



unset multiplot
set term qt


reset


