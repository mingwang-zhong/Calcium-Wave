################################################################################################################
################################################################################################################

reset

set term pdfcairo enhanced color size 5,4 font 'Helvetica,12' background rgb "#ffffff"

set output "Hill_effect_NCU_NCB.pdf"
set multiplot 

set border 3
set tics out scale 0.7 nomirror

originx=0
sizex=0.5 # cp, cj
shiftx=-0.02 

originy=0
sizey=0.5
shifty=-0.02

path2="Hill2_alpha0.2_beta0.004_cstar1.1/ci0.175_before_spark.txt"
path7="Hill7_alpha0.2_beta0.004_cstar1.1/ci0.175_before_spark.txt"
path12="Hill12_alpha0.2_beta0.004_cstar1.1/ci0.175_before_spark.txt"

set size sizex,sizey

set xrange [-3:90]
set xtics 30
set mxtics 3

set ylabel 'Frequency' offset 2,0
set yrange [0:1]
set ytics nomirror 0.5 offset 0.5,0
set mytics 5

set style data histograms
set style fill transparent solid 0.8 border rgb 'grey50'
binwidth=2
####################################################################################
set origin originx+0*(sizex+shiftx),originy+1*(sizey+shifty)
set label 1 "{/:Bold Aa}" at graph -0.2,1.05 font ",16"

set xlabel "{/Helvetica-Italic N}_{CU}" offset 0,0.5

set key at 90,1 samplen 2 spacing 1.2
set label 2 "0.175 μM" center at 43,1.05

set boxwidth binwidth
bin(x,width)=width*floor(x/width)

plot 	path2 u (bin($5,binwidth)):(1.0/93) smooth freq with boxes lc 1 lw 0.5 t "H = 2",\
		path7 u (bin($5,binwidth)):(1.0/752) smooth freq with boxes lc 2 lw 0.5 t "H = 7",\
		path12 u (bin($5,binwidth)):(1.0/437) smooth freq with boxes lc 4 lw 0.5 t "H = 12"


unset label 2
unset key
####################################################################################
set origin originx+0*(sizex+shiftx),originy+0*(sizey+shifty)
set label 1 "{/:Bold Ab}"


set xlabel "{/Helvetica-Italic N}_{CB}"


plot 	path2 u (bin($6,binwidth)):(1.0/93) smooth freq with boxes lc 1 lw 0.5 t "",\
		path7 u (bin($6,binwidth)):(1.0/752) smooth freq with boxes lc 2 lw 0.5 t "",\
		path12 u (bin($6,binwidth)):(1.0/437) smooth freq with boxes lc 4 lw 0.5 t ""




path2="Hill2_alpha0.2_beta0.004_cstar1.1/ci0.3_before_spark.txt"
path7="Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3_before_spark.txt"
path12="Hill12_alpha0.2_beta0.004_cstar1.1/ci0.3_before_spark.txt"
####################################################################################
set origin originx+1*(sizex+shiftx),originy+1*(sizey+shifty)
set label 1 "{/:Bold Ba}"

set xlabel "{/Helvetica-Italic N}_{CU}" offset 0,0.5

set key at 90,1 samplen 2
set label 2 "0.3 μM" center at 43,1.05

plot 	path2 u (bin($5,binwidth)):(1.0/465) smooth freq with boxes lc 1 lw 0.5 t "H = 2",\
		path7 u (bin($5,binwidth)):(1.0/1742) smooth freq with boxes lc 2 lw 0.5 t "H = 7",\
		path12 u (bin($5,binwidth)):(1.0/1823) smooth freq with boxes lc 4 lw 0.5 t "H = 12"

unset label 2
unset key
####################################################################################
set origin originx+1*(sizex+shiftx),originy+0*(sizey+shifty)
set label 1 "{/:Bold Bb}"


set xlabel "{/Helvetica-Italic N}_{CB}"

plot 	path2 u (bin($6,binwidth)):(1.0/465) smooth freq with boxes lc 1 lw 0.5 t "H = 2",\
		path7 u (bin($6,binwidth)):(1.0/1742) smooth freq with boxes lc 2 lw 0.5 t "H = 7",\
		path12 u (bin($6,binwidth)):(1.0/1823) smooth freq with boxes lc 4 lw 0.5 t "H = 12"



unset multiplot
set term qt

reset
