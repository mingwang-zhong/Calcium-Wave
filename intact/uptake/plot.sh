



reset
set term pdfcairo enhanced color size 36,40 font 'Helvetica,10' background rgb "#ffffff"

set output "Vm.pdf"
set multiplot 

set border 3
set tics out nomirror scale 0.5
set xrange [-0.2:40]
set xtics 10
set mxtics 5
# set format x ""
set yrange [-100:60]
set ytics 40
set mytics 2


Numx=6
Numy=40
originx=0
shiftx=0.003
sizex=0.99/Numx+shiftx
originy=0
shifty=0.003
sizey=0.99/Numy+shifty

set size sizex,sizey
do for [i=1:Numx] {
	print "Vup = ", 120+20*i


	do for [j=1:Numy] {

		set origin originx+(i-1)*(sizex-shiftx), originy+(j-1)*(sizey-shifty)
		str=sprintf('V_{up} = %g, # = %g', 120+20*i, j)
		set label 1 str at graph 0.1,1.1 front tc lt -1 font ",12"

		path = sprintf('Vup%g_%g/wholecell.txt', 120+20*i, j)
		plot path u ($1/1000-0.1):7 every 1 w l lw 0.5 t ""

	}
}

unset multiplot


