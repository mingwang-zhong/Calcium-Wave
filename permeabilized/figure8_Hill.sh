################################################################################################################
################################################################################################################

reset

set term pdfcairo enhanced color size 6.5,4 font 'Helvetica,12' background rgb "#ffffff"

set output "Hill_effect.pdf"
set multiplot 

set border 3
set tics out scale 0.7

originx=-0.0
sizex1=0.35 # ci = 0.175
sizex2=0.35 # ci = 0.3
sizex3=0.35 # panels C and D
shiftx1=-0.01
shiftx2=-0.03

originy=-0.0
sizey=0.5
shifty=-0.0


path2="Hill2_alpha0.2_beta0.004_cstar1.1/ci0.175_before_spark.txt"
path7="Hill7_alpha0.2_beta0.004_cstar1.1/ci0.175_before_spark.txt"
path12="Hill12_alpha0.2_beta0.004_cstar1.1/ci0.175_before_spark.txt"
set ytics nomirror 0.2 offset 0.5,0
set mytics 2
set ytics add('    0'0)
set ylabel "Frequency" offset 3,0
set size sizex1,sizey


set style data histograms
set style fill transparent solid 0.8 border rgb 'grey50'
set style arrow 1 head filled size screen 0.015,20 lw 1

####################################################################################
set origin originx+0*(sizex1+shiftx1)+0*(sizex2+shiftx2),originy+1*(sizey+shifty)
set label 1 "{/:Bold Aa}" at graph -0.3,1.0 font ",16"
set label 2 '[Ca^{2+}]_i ≈ 0.175 μM' center at 0.6,1

set xrange [0.1:1.2]
set xtics nomirror 0.4  offset 0,0.5
set mxtics 4
set xlabel "[Ca^{2+}]_p (μM)" offset 0,0.5

# set yrange [0:0.6]

set key right at 1.2,0.833 spacing 1.5 samplen 2
set arrow 1 from 1,0.3 to 0.8,0.08 as 1

binwidth=0.024
set boxwidth binwidth
bin(x,width)=width*floor(x/width) + binwidth/2.0

plot 	path2 u (bin($2,binwidth)):(1.0/93) smooth freq with boxes lc 1 lw 0.5 t "H = 2",\
		path7 u (bin($2,binwidth)):(1.0/752) smooth freq with boxes lc 2 lw 0.5 t "H = 7",\
		path12 u (bin($2,binwidth)):(1.0/437) smooth freq with boxes lc 4 lw 0.5 t "H = 12"

unset label 2
unset arrow
####################################################################################
set origin originx+0*(sizex1+shiftx1)+0*(sizex2+shiftx2),originy+0*(sizey+shifty)
set label 1 "{/:Bold Ab}"

set xrange [300:1200]
set xtics nomirror 400
set mxtics 4
set xlabel "[Ca^{2+}]_{JSR} (μM)"

# set yrange [0:0.5]

unset key
binwidth=20
set boxwidth binwidth
bin(x,width)=width*floor(x/width) + binwidth/2.0


plot 	path2 u (bin($1,binwidth)):(1.0/93) smooth freq with boxes lc 1 lw 0.5 t "",\
		path7 u (bin($1,binwidth)):(1.0/752) smooth freq with boxes lc 2 lw 0.5 t "",\
		path12 u (bin($1,binwidth)):(1.0/437) smooth freq with boxes lc 4 lw 0.5 t ""


path2="Hill2_alpha0.2_beta0.004_cstar1.1/ci0.3_before_spark.txt"
path7="Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3_before_spark.txt"
path12="Hill12_alpha0.2_beta0.004_cstar1.1/ci0.3_before_spark.txt"
set size sizex2,sizey
####################################################################################
set origin originx+1*(sizex1+shiftx1)+0*(sizex2+shiftx2),originy+1*(sizey+shifty)
set label 1 "{/:Bold Ba}"

set label 2 '[Ca^{2+}]_i ≈ 0.3 μM' center at 0.6,0.6

set xrange [0.1:1.2]
set xtics nomirror 0.4  offset 0,0.5
set mxtics 4
set xlabel "[Ca^{2+}]_p (μM)" offset 0,0.5

# set yrange [0:0.6]

set key right at 1.2,0.5 spacing 1.5
set arrow 1 from 1.12,0.26 to 0.92,0.14 as 1

set style data histograms
set style fill transparent solid 0.8 border rgb 'grey50'
binwidth=0.024
set boxwidth binwidth
bin(x,width)=width*floor(x/width) + binwidth/2.0

plot 	path2 u (bin($2,binwidth)):(1.0/465) smooth freq with boxes lc 1 lw 0.5 t "H = 2",\
		path7 u (bin($2,binwidth)):(1.0/1742) smooth freq with boxes lc 2 lw 0.5 t "H = 7",\
		path12 u (bin($2,binwidth)):(1.0/1823) smooth freq with boxes lc 4 lw 0.5 t "H = 12"

unset label 2
unset arrow
####################################################################################
set origin originx+1*(sizex1+shiftx1)+0*(sizex2+shiftx2),originy+0*(sizey+shifty)
set label 1 "{/:Bold Bb}"

set xrange [300:1200]
set xtics nomirror 400
set mxtics 4
set xlabel "[Ca^{2+}]_{JSR} (μM)"

# set yrange [0:0.4]

unset key
binwidth=20
set boxwidth binwidth
bin(x,width)=width*floor(x/width) + binwidth/2.0


plot 	path2 u (bin($1,binwidth)):(1.0/465) smooth freq with boxes lc 1 lw 0.5 t "",\
		path7 u (bin($1,binwidth)):(1.0/1742) smooth freq with boxes lc 2 lw 0.5 t "",\
		path12 u (bin($1,binwidth)):(1.0/1823) smooth freq with boxes lc 4 lw 0.5 t ""

####################################################################################
set origin originx+1*(sizex1+shiftx1)+1*(sizex2+shiftx2),originy+1*(sizey+shifty)
set size sizex3,sizey
set label 1 "{/:Bold C}"

path="sparks_nonspark.txt"

set xrange [-0.5:5.5]
set xtics nomirror out offset 0,0.5 #out("0.0" 0, "0.2" 180, "0.4" 360, "0.6" 540, "0.8" 720, "1.0" 900)
set xlabel "H_ " offset 0,0.5

set yrange [1:300000]
set ytics nomirror out 0.1
set ytics add('10^1'10, '10^2'100, '10^3'1000, '10^4'10000, '10^5'100000)
set mytics 10
set ylabel "Number of events" offset 5,0
set logscale y

set style histogram gap 1.5
set style data histograms
set style fill solid 0.95 noborder
set boxwidth 1 relative

set key at 5.8,5e5 maxrows 1 samplen 2 spacing 1.2 width -2

set arrow 1 nohead from 2.5,0.9 to 2.5,1.1 lw 8 lc rgb '#ffffff' front

set label 2 "0.175 μM" center at 1,5e4
set label 3 "0.3 μM" center at 4,5e4

set arrow 2 from -0.3,2e4 to 2.3,2e4 nohead lw 4 lc rgb '#A0A0A0'
set arrow 3 from 2.7,2e4 to 5.3,2e4 nohead lw 4 lc rgb '#A0A0A0'

plot 	path u 2:xtic(1) lw 1.5 lc 1 title "{/Helvetica-Italic N}_{spark}",\
		path u 3:xtic(1) lw 1.5 lc 2 fs pattern 3 title "{/Helvetica-Italic N}_{non-spark}"

set mytics 2
unset arrow
unset label 2
unset label 3
################################################
set origin originx+1*(sizex1+shiftx1)+1*(sizex2+shiftx2)-0.018,originy+0*(sizey+shifty)
set size sizex3+0.017,sizey
set label 1 "{/:Bold D}"

set xrange [0:1.2]
set xtics nomirror 0.4 offset 0,0.5
set mxtics 4
set xlabel "[Ca^{2+}]_p (μM)" offset 0,0.5

set yrange [0.00001:10]
set ytics nomirror 1e-5,1e1,10 #0.1
set ytics add('10^{-5}'0.00001, '10^{-4}'0.0001, '10^{-3}'0.001, '10^{-2}'0.01, '10^{-1}'0.1, '1'1, '10^1'10 )
set mytics 10
set ylabel "{/Helvetica-Italic k}_{CRU} (ms^{-1})" offset 6,0

set logscale y
set key at 1.24,7e-4 samplen 2 spacing 1.2 maxrows -1
# set label 2 "H = 2" at 0.7,0.0024 rotate by 8 tc lt 1
set label 2 "H = 2" at 0.7,0.003 rotate by 8 tc lt 1
set label 4 "H = 2" at 0.15,0.8 rotate by 30  tc lt 1
set label 3 "H = 7" at 0.45,0.09 rotate by 48 tc lt 2
set label 5 "H = 12" at 0.68,0.015 rotate by 57 tc lt 4

set object 1 rect from 0.5,1e-5 to 1,10 fc rgb "#F0F0F0" fs solid 1 border rgb "#F0F0F0" back

BCSQN = 460.0
nCa = 31.0
Kc = 600.0
Nryr = 100.0

cb(cj)= BCSQN*nCa*cj/(Kc + cj)
ku2b(cj)= 1/(1.0 + (cb(cj)/(BCSQN*13.3))**24)
kb2u(cj)= 1.0/(  4000.0/( 1.0+(cj/670.0)**24 ) + 350.0  );
NCU(cj)= kb2u(cj)/(kb2u(cj) + ku2b(cj))*Nryr
ku7(x)= 0.2/(1.0 + (1.1/x)**7) + 2*10**(-6)
kb7(x)= 0.004/(1.0 + (1.1/x)**7) + 2*10**(-9)
ku2(x)= 0.2/(1.0 + (1.1/x)**2) + 2*10**(-6)
kb2(x)= 0.004/(1.0 + (1.1/x)**2) + 2*10**(-9)
ku12(x)= 0.2/(1.0 + (1.1/x)**12) + 2*10**(-6)
kb12(x)= 0.004/(1.0 + (1.1/x)**12) + 2*10**(-9)

kp7(ci, cj)= NCU(cj)*ku7(ci) + (Nryr - NCU(cj))*kb7(ci)
kp2(ci, cj)= NCU(cj)*ku2(ci) + (Nryr - NCU(cj))*kb2(ci)
kp12(ci, cj)= NCU(cj)*ku12(ci) + (Nryr - NCU(cj))*kb12(ci)

set arrow 1 from 1.035,1.35e-4 to 1.185, 1.35e-4 nohead lc 1 lw 2
set arrow 2 from 1.035,8e-5 to 1.185,8e-5 nohead lc 4 lw 2

# plot 	(x>0.04)?( (0.0*ku2(x) + 84.0*kb2(x) )*93.0/(93+7529) ):1/0 w l lw 2 lc 1 dt 1 t '',\
# 		(x>0.04)?( (0.0*ku2(x) + 84.0*kb2(x) )*465.0/(465+9797) ):1/0 w l lw 2 lc 1 dt 2 t '',\
# 		(x>0.04)?( ( 64*ku7(x) + 20*kb7(x) )*752.0/(752+18) ):1/0 w l lw 2 lc 2 dt 1 t '',\
# 		(x>0.04)?( ( 42*ku7(x) + 42*kb7(x) )*1742.0/(1742+67) ):1/0 w l lw 2 lc 2 dt 2 t '',\
# 		(x>0.04)?( ( 78*ku12(x) + 4*kb12(x) )*437.0/(437+0) ):1/0 w l lw 2 lc 4 dt 1 t '',\
# 		(x>0.04)?( ( 74*ku12(x) + 10*kb12(x) )*1823.0/(1823+3) ):1/0 w l lw 2 lc 4 dt 2 t '',\
# 		(x>0.04)?kp2(x,800):1/0 w l lw 2 dt 4 lc 1 t '',\
# 		kp2(x,400)*93.0/(93+7529) w l lw 1 lc 1 t '',\
# 		kp7(x,800) w l lw 1 lc 2 t '',\
# 		kp12(x,900) w l lw 1 lc 4 t '',\
# 		100 w l lc -1 lw 2 t '0.175 μM',\
# 		100 w l lc -1 lw 2 dt 2 t '0.3 μM',\
# 		100 w l lc -1 lw 2 dt 4 t 'c_j = 800 μM'

plot  	kp2(x,400)*93.0/(93+7529) w l lw 2 dt (10,4)  lc 1 t '',\
		kp2(x,800) w l lw 2 lc 1 t '',\
		kp7(x,800) w l lw 2 lc 2 t '',\
		(x>0.04)?( ( 64*ku7(x) + 20*kb7(x) ) ):1/0 w l lw 2 lc 2 dt 4 t '',\
		kp12(x,800) w l lw 2 lc 4 t '',\
		kp12(x,900) w l lw 2 dt (3,3) lc 4 t '',\
		100 w l lc  1 lw 2 dt (10,4) t '{/Helvetica-Italic c_j} = 400 μM',\
		100 w l lc  2 lw 2 t '{/Helvetica-Italic c_j} = 800 μM',\
		100 w l lc  4 lw 2 dt (3,3) t '{/Helvetica-Italic c_j} = 900 μM'
		


unset multiplot
set term qt

reset


