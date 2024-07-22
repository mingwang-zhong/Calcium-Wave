reset
set term pdfcairo enhanced color size 4.6,1.8 font 'Helvetica,10' background rgb "#ffffff"
set output "EAD_H10_supplemental.pdf"
set multiplot layout 1,2

pathH="Hill_effect/result_H_all.txt"
set border 3
set tics out scale 0.7 nomirror

set xrange [-40:-10]
set xtics 10 offset 0,0.3
set mxtics 2
set xlabel 'Take-off V_m (mV)' offset 0,0.6

set yrange [0.17:0.18]
set ytics 0.01 offset 0.6
set mytics 5
set ylabel 'Diastolic [Ca^{2+}]_i (μM)' offset 1.2
set label 1 "{/:Bold A}" at graph -0.25,1 font ",14"

plot path u 2:7 w p pt 4 ps 0.5 t ''




set yrange [660:685]
set ytics 10 offset 0.6
set mytics 2
set ylabel 'Take-off [Ca^{2+}]_{JSR} (μM)' offset 1.2
set label 1 "{/:Bold B}"

plot path u 2:5 w p pt 4 ps 0.5 t ''

unset multiplot
