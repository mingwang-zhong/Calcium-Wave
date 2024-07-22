reset

set term pdfcairo enhanced color size 7,2.2 font 'Helvetica,12' background rgb "#ffffff"

set output "ryr.pdf"
set multiplot 

set tics nomirror out
originx=-0.0
sizex1=0.34
sizex2=0.39
shiftx=-0.015
originy=-0.02
sizey=1.02
shifty=-0.0

nCa=31
Kc=600
BCSQN=460
kminus=0.4
Nryr = 84.0


cb(cj)= BCSQN*nCa*cj/(Kc + cj)
ku2b(cj)= 1/(1.0 + (cb(cj)/(BCSQN*13.3))**24)
kb2u(cj)= 1.0/(  4000.0/( 1.0+(cj/670.0)**24 ) + 350.0  );
NCU(cj)= kb2u(cj)/(kb2u(cj) + ku2b(cj))*Nryr

ku(H,x)= 0.2/(1.0 + (1.1/x)**H) + 2*10**(-6)
kb(H,x)= 0.004/(1.0 + (1.1/x)**H) + 2*10**(-9)
kCRU(H, ci, cj)= NCU(cj)*ku(H,ci) + (Nryr - NCU(cj))*kb(H,ci)
P0(H,ci,cj) = 1/(1+kminus/kCRU(H,ci,cj))

set border 3
set xrange [0.1:10]
set xtics offset 0,0.6
set logscale x
set mxtics 10
set xlabel "[Ca^{2+}]_p (μM)" offset 0,1
#######################################
set origin originx,originy
set size sizex1,sizey

set yrange [-0.006:0.21]
set ytics 0.1 offset 0.6
set mytics 10
set ylabel "RyR open rate (ms^{-1})" offset 2.5

set label 1 "k_u" at 5,0.19
set label 2 "k_b" at 5,0.02
set label 10 "{/:Bold C}" at graph -0.27,1.0 font ",18"

plot 	ku(7,x) w l lw 2 lc 1 t "",\
		kb(7,x) w l lw 2 lc 2 t ""
#######################################
set origin originx+sizex1+shiftx,originy
set size sizex1,sizey

set xrange [0.08:10]
set yrange [-0.02:1]
set ytics 0.5
set mytics 5
set ylabel "CRU open probability (P_0)"

set label 1 "H = 12" left at 0.85,0.2 tc lt 1
set label 2 "H = 7" left at 0.20,0.1 tc lt 2
set label 3 "H = 2" left at 0.13,0.7 tc lt 3
set label 10 "{/:Bold D}" at graph -0.25,1.0

path='Hill7_alpha0.2_beta0.004_cstar1.1_fixNSR_taujn/result.txt' # only c_n is fixed, measured from all CRUs

plot 	P0(12,x,800) w l lw 2 lc 1 t "",\
		P0(7,x,800) w l lw 2 lc 2 t "",\
		P0(2,x,800) w l lw 2 lc 3 t "",\
		path u 2:(1/(1+$1*kminus)) w p pt 5 ps 0.2 lw 2 lc rgb '#ffffff' t '',\
		path u 2:(1/(1+$1*kminus)) w p pt 4 ps 0.5 lw 2 lc 2 t ''

print P0(7,0.781,800)

unset logscale
unset label 3
#######################################
set origin originx+2*(sizex1+shiftx),originy
set size sizex2,sizey
set border 11
set xrange [400:900]
set xtics 200 offset 0,0.6
set mxtics 2
set xlabel "[Ca^{2+}]_{JSR}" offset 0,1

set yrange [-0.10:4.5]
set ytics 1 offset 0.6
set mytics 2
set ylabel "τ_u (s)" tc lt 1 offset 1.2

set y2range [-0.2:10]
set y2tics 4 offset -1
set my2tics 4
set y2label "τ_b (s)" tc lt 2 offset -1.8

set label 1 "τ_u" at 450,4.05 tc lt 1
set label 2 "τ_b" at 450,0.30 tc lt 2
set label 10 "{/:Bold E}" at graph -0.22,1.0

plot 	0.001/kb2u(x) w l lw 2 lc 1 t "",\
		0.001/ku2b(x) w l lw 2 lc 2 t ""

unset y2tics
unset y2label
set format y2 ""
unset multiplot
set term qt

reset