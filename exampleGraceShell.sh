atom=Dy
number=132
nuclide=$atom$number
baseline=40
maxJ=132

filename='error_'$nuclide'.agr'
title='Accuracy as a function of Gauss-Legendre integration points.'
subtitle='for \S'$number'\N'$atom' with a baseline of '$baseline' points and a Max J of '$maxJ'.'
xlabel='Number of Integration Points'
ylabel='Percent Error vs 40 Points (%)'

xmin=15
xmax=40
ymin=0
ymax=5
xticks_major=5
xticks_minor=0
yticks_major=1
yticks_minor=1
color=11

point0_x=35
point0_y=0.55951065 

point1_x=30
point1_y=7.7951198 

point2_x=25
point2_y=15.246922 

#point3_x=20
#point3_y=0.16691040

#point4_x=15
#point4_y=1.8445683   

modularGrace.x << INPUT
$filename
$title
$subtitle
$xlabel
$ylabel
$xmin
$xmax
$ymin
$ymax
y
y
$xticks_major
$xticks_minor
y
y
$yticks_major
$yticks_minor
y
$point0_x
$point0_y
$color
y
$point1_x
$point1_y   
y
$point2_x
$point2_y  
#y
#$point3_x
#$point3_y
#y
#$point4_x
#$point4_y 
n
INPUT

xmgrace error_$nuclide.agr
