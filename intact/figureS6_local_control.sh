reset
set term pdfcairo enhanced color size 5.5,4.5 font 'Helvetica,12' background rgb "#ffffff"
set output "localControl.pdf"

set multiplot layout 2,2

set border 3 lw 1
set tics out nomirror

path1="localControl_Hill7_cstar3.5/result.txt"
path2="localControl_Hill7_cstar1.1_ISO/result.txt"
path3="gain_control_0mV/result.txt"
# path4="gain_control_0mV/result.txt"

################################################################################
set xrange [-50:60]
set xtics 40 offset 0,0.6
set mxtics 4
set xlabel "V_m (mV)" offset 0,0.5

set yrange [-0.02:1]
set ytics 0.5 offset 0.6
set mytics 5
set ylabel " " offset 2
unset key

set label 10 "{/:Bold A}" at graph -0.2,1 font ",18"

set label 1 "{/Helvetica-Italic ~I{0.9\\~}}_{ Ca,L}" at 49,0.35
set label 2 "{/Helvetica-Italic ~I{0.9\\~}}_{ rel}" at 17,0.2
set label 3 "Control" at graph 0.04,0.95 left

plot 	path1 u 1:2 w lp pt 5 ps 0.6 t "Normalized {/Helvetica-Italic I}_{Ca,L}",\
		path1 u 1:3 w lp pt 7 ps 0.6 t "Normalized {/Helvetica-Italic I}_{rel}"

################################################################################
set label 10 "{/:Bold B}"
set label 1 "{/Helvetica-Italic ~I{0.9\\~}}_{ Ca,L}" at 20,0.4
set label 2 "{/Helvetica-Italic ~I{0.9\\~}}_{ rel}" at 55,0.8
set label 3 "Caffeine + ISO"

plot 	path2 u 1:2 w lp pt 5 ps 0.6 t "Normalized {/Helvetica-Italic I}_{Ca,L}",\
		path2 u 1:3 w lp pt 7 ps 0.6 t "Normalized {/Helvetica-Italic I}_{rel}"


unset label 1
unset label 2
unset label 3

################################################################################
set xrange [400:800]
set xtics 200
set mxtics 2
set xlabel "[Ca^{2+}]_{JSR}"

set yrange [0:12]
set ytics 4
set mytics 2
set ylabel "Gain"  offset 3

set key top left samplen 3

set label 10 "{/:Bold C}"

set ytics add('   0'0)
plot 	path3 u ( ($1<=750)?$1:1/0 ):(-$3/$2) w lp pt 5 ps 0.6 t "Control"

################################################################################
set yrange [0:0.4]
set ytics 0.2
set mytics 2
set ylabel "Fractional release"  offset 2
set ytics add('0'0)
set label 10 "{/:Bold D}"

plot 	path3 u ( ($1<=750)?$1:1/0 ):($3/$4) w lp pt 5 ps 0.6 t "Control"

unset multiplot
