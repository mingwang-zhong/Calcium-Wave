reset

set term pdfcairo enhanced color size 6,2 font 'Helvetica,12' background rgb "#ffffff"

set output "sparks_profile.pdf"
set multiplot 

set border 3
set tics out nomirror scale 0.7

originx=-0.03
sizex=0.355
shiftx=-0.01

originy=0
sizey=1


path='Hill7_alpha0.2_beta0.004_cstar1.1/spark_profile.txt'
set size sizex,sizey
set xlabel 'Ratio to the reference' offset 0,1
set xrange [0:2]
set xtics 1 offset 0,0.5
set mxtics 2
set key spacing 1.5 at 2.1,4.1

##########################################################################################
set origin originx,originy
set ylabel 'F/F_0' offset 1.5
set yrange [1:4]
set ytics 1 offset 0.5
set ytics add('  2'2)
set mytics 1
set label 1 "{/:Bold A}" at graph -0.25,1.0 font ",16"

plot 	path i 2 u ($1/1.3):2 w lp pt 9 ps 0.5 lw 1.5 t '{/Helvetica-Italic λ_x}',\
		path i 0 u ($1/0.8):2 w lp pt 5 ps 0.5 lw 1.5 t '{/Helvetica-Italic v_i}',\
		path i 5 u ($1/0.15):2 w lp pt 7 ps 0.5 lc rgb '#994f00' lw 1.5 t '{/Helvetica-Italic D}_{dye}',\
		path i 1 u ($1/0.3):2 w lp pt 13 ps 0.5 lw 1.5 t '{/Helvetica-Italic D}_{Ca}',\
		path i 4 u ($1/$1):2 w lp pt 11 ps 0.5 lw 1.5 lc -1 t ''

		# ,\
		# path i 3 u ($1/0.4):2 w lp pt 11 ps 0.5 lw 1.5 t 'λ_y = λ_z'


		
unset key
##########################################################################################
set origin originx+1*(sizex+shiftx),originy
set ylabel 'FWHM (μm)'
set yrange [1.5:2.3]
set ytics 0.2
set mytics 2
set label 1 "{/:Bold B}"

plot 	path i 2 u ($1/1.3):3 w lp pt 9 ps 0.5 lw 1.5 t 'λ_x',\
		path i 0 u ($1/0.8):3 w lp pt 5 ps 0.5 lw 1.5 t 'v_i',\
		path i 5 u ($1/0.15):3 w lp pt 7 ps 0.5 lc rgb '#994f00' lw 1.5 t 'D_{dye}',\
		path i 1 u ($1/0.3):3 w lp pt 7 ps 0.5 lw 1.5 t 'D_{Ca}',\
		path i 4 u ($1/$1):3 w lp pt 11 ps 0.5 lw 1.5 lc -1 t ''

		# ,\
		# path i 3 u ($1/0.4):3 w lp pt 11 ps 0.5 lw 1.5 t 'λ_y'


		

##########################################################################################
set origin originx+2*(sizex+shiftx),originy
set ylabel 'FDHM (ms)'
set yrange [14:22]
set ytics 2
set ytics add(' 10'10)
set mytics 2
set label 1 "{/:Bold C}"

plot 	path i 2 u ($1/1.3):4 w lp pt 9 ps 0.5 lw 1.5 t 'λ_x',\
		path i 0 u ($1/0.8):4 w lp pt 5 ps 0.5 lw 1.5 t 'v_i',\
		path i 5 u ($1/0.15):4 w lp pt 7 ps 0.5 lc rgb '#994f00' lw 1.5 t 'D_{dye}',\
		path i 1 u ($1/0.3):4 w lp pt 7 ps 0.5 lw 1.5 t 'D_{Ca}',\
		path i 4 u ($1/$1):4 w lp pt 11 ps 0.5 lw 1.5 lc -1 t ''

		# ,\
		# path i 3 u ($1/0.4):4 w lp pt 11 ps 0.5 lw 1.5 t 'λ_y'


unset multiplot