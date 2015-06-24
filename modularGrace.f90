! This program allows a user to easily produce xmgrace bar graphs.  The user may either
!   manually enter all data or read information in from a file.

MODULE userInput
	IMPLICIT NONE
    INTEGER :: xpoint, ypoint
	INTEGER :: xmin, xmax, ymin, ymax
	INTEGER :: xmajor, xminor, ymajor, yminor
	INTEGER :: color
	INTEGER :: dataPoint, numendLines
    CHARACTER(LEN=10) :: tempString, tempString2
	CHARACTER(LEN=10) :: xminString, xmaxString, yminString, ymaxString
	CHARACTER(LEN=20) :: longString
	CHARACTER(LEN=100) :: filename, title, subtitle
	CHARACTER(LEN=100) :: xlabel, ylabel
	CHARACTER(LEN=1) :: choice
	LOGICAL :: xTicks, yTicks, xNumbers, yNumbers, sameColor, anotherPoint
END MODULE userInput


PROGRAM modularGrace
	USE userInput

CALL mainMenu()
CALL mainInfo()
CALL buildBeginning()
CALL buildBody()
CALL buildEnd()
WRITE(*,*) ''
WRITE(*,*) 'Task complete.  Your .agr file named is: ', TRIM(filename)

END PROGRAM


! ###############################################################################################
!
! This subroutine handles the initial question: Manual Entry or Data File.
!
! ###############################################################################################
SUBROUTINE mainMenu()
    USE userInput
    IMPLICIT NONE

WRITE(*,*) ' Welcome to the xmgrace bar graph maker.'
WRITE(*,*) '       Version 0 : June 23, 2015'
WRITE(*,*) ''
WRITE(*,*) ' * * * * * * * * * * * * * * * * * * * *'
WRITE(*,*) ''

RETURN
END SUBROUTINE mainMenu



! ###############################################################################################
!
! Allows the user to enter all primary info about the graph.  This is used to populate the first
!   section of the .agr Grace project file.
!
! ###############################################################################################
SUBROUTINE mainInfo()
    USE userInput
    IMPLICIT NONE

! Output filename
WRITE(*,*) 'Enter name of output file (inluding ".agr").'
READ(*,'(A)') filename
OPEN(UNIT=100, FILE=TRIM(filename), STATUS='UNKNOWN')

! Title/Subtitle/x-y labels
WRITE(*,*) 'Enter title of graph (using xmgrace nomenclature) ["help" for info]'
CALL enterString(title)
WRITE(*,*) 'Enter subtitle of graph (using xmgrace nomenclature) ["help" for info]'
CALL enterString(subtitle)
WRITE(*,*) 'Enter label for the x-axis (using xmgrace nomenclature) ["help" for info]'
CALL enterString(xlabel)
WRITE(*,*) 'Enter label for the y-axis (using xmgrace nomenclature) ["help" for info]'
CALL enterString(ylabel)

! Range of x-y values displayed
WRITE(*,*) 'Enter minimum & maximum range of x-values to be displayed'
READ(*,*) xmin, xmax
WRITE(*,*) 'Enter minimum & maximum range of y-values to be displayed'
READ(*,*) ymin, ymax

! Number lables & tick marks for x-y axis
WRITE(*,*) 'Do you want number labels to show on the x-axis? (Y/N)'
CALL yesNo(xNumbers)
WRITE(*,*) 'Do you want tick marks to display on the x-axis? (Y/N)'
CALL yesNo(xTicks)
IF (xTicks.EQV..TRUE.) THEN
    WRITE(*,*) 'Enter major spacing and # of minor ticks'
    READ(*,*) xmajor, xminor
ELSE
	xmajor=1; xminor=1
END IF

WRITE(*,*) 'Do you want number labels to show on the y-axis? (Y/N)'
CALL yesNo(yNumbers)
WRITE(*,*) 'Do you want tick marks to display on the y-axis? (Y/N)'
CALL yesNo(yTicks)
IF (yTicks.EQV..TRUE.) THEN
    WRITE(*,*) 'Enter major spacing and # of minor ticks'
    READ(*,*) ymajor, yminor
ELSE
	ymajor=1; yminor=1
END IF

! Same color?
WRITE(*,*) 'Do you want *all* bars to be the same color? (Y/N)'
CALL yesNo(sameColor)

RETURN
END SUBROUTINE mainInfo


! ###############################################################################################
!
! Reads a string from user input.
!
! ###############################################################################################
SUBROUTINE enterString(string)
    IMPLICIT NONE
    CHARACTER(LEN=100) :: string

DO
    READ(*,'(A)') string

    IF ((string == 'help').OR.(string == 'help').OR.(string == 'HELP')) THEN
		!CALL nomenclature
    ELSE
		EXIT
    ENDIF
END DO

RETURN
END SUBROUTINE enterString


! ###############################################################################################
!
! Reads YES or NO from user input.
!
! ###############################################################################################
SUBROUTINE yesNo(logicalValue)
    IMPLICIT NONE
    CHARACTER(LEN=1) :: choice
    LOGICAL, INTENT(out) :: logicalValue

DO
    READ(*,*) choice
    IF ((choice == 'y').OR.(choice == 'Y')) THEN
	    logicalvalue = .TRUE.
        EXIT
    ELSEIF ((choice == 'n').OR.(choice == 'N')) THEN
	    logicalValue = .FALSE.
        EXIT
    ELSE
	    WRITE(*,*) 'Y or N please.'
    ENDIF
END DO

RETURN
END SUBROUTINE yesNo



! ###############################################################################################
!
! Takes a number from input -> returns string as output.
!
! ###############################################################################################
SUBROUTINE numberTostring(num,string)
	IMPLICIT NONE
	INTEGER, INTENT(in) :: num
	CHARACTER(LEN=10) :: string

WRITE(string,'(I10)') num

RETURN
END SUBROUTINE numberTOstring



! ###############################################################################################
!
! Writes standard/default information to the beginning of the Grace project file.
!
! ###############################################################################################
SUBROUTINE buildBeginning()

WRITE(100,*) '# Grace project file'
WRITE(100,*) '#'
WRITE(100,*) '@version 50122'
WRITE(100,*) '@page size 792, 612'
WRITE(100,*) '@page scroll 5%'
WRITE(100,*) '@page inout 5%'
WRITE(100,*) '@link page off'
WRITE(100,*) '@map font 13 to "ZapfDingbats", "ZapfDingbats"'
WRITE(100,*) '@map font 4 to "Helvetica", "Helvetica"'
WRITE(100,*) '@map font 6 to "Helvetica-Bold", "Helvetica-Bold"'
WRITE(100,*) '@map font 5 to "Helvetica-Oblique", "Helvetica-Oblique"'
WRITE(100,*) '@map font 7 to "Helvetica-BoldOblique", "Helvetica-BoldOblique"'
WRITE(100,*) '@map font 17 to "Nimbus-Sans-L-Regular-Condensed", "Nimbus-Sans-L-Regular-Condensed"'
WRITE(100,*) '@map font 18 to "Nimbus-Sans-L-Bold-Condensed", "Nimbus-Sans-L-Bold-Condensed"'
WRITE(100,*) '@map font 19 to "Nimbus-Sans-L-Regular-Condensed-Italic", "Nimbus-Sans-L-Regular-Condensed-Italic"'
WRITE(100,*) '@map font 20 to "Nimbus-Sans-L-Bold-Condensed-Italic", "Nimbus-Sans-L-Bold-Condensed-Italic"'
WRITE(100,*) '@map font 0 to "Times-Roman", "Times-Roman"'
WRITE(100,*) '@map font 2 to "Times-Bold", "Times-Bold"'
WRITE(100,*) '@map font 1 to "Times-Italic", "Times-Italic"'
WRITE(100,*) '@map font 3 to "Times-BoldItalic", "Times-BoldItalic"'
WRITE(100,*) '@map font 8 to "Courier", "Courier"'
WRITE(100,*) '@map font 10 to "Courier-Bold", "Courier-Bold"'
WRITE(100,*) '@map font 9 to "Courier-Oblique", "Courier-Oblique"'
WRITE(100,*) '@map font 11 to "Courier-BoldOblique", "Courier-BoldOblique"'
WRITE(100,*) '@map font 29 to "URW-Palladio-L-Roman", "URW-Palladio-L-Roman"'
WRITE(100,*) '@map font 30 to "URW-Palladio-L-Bold", "URW-Palladio-L-Bold"'
WRITE(100,*) '@map font 31 to "URW-Palladio-L-Italic", "URW-Palladio-L-Italic"'
WRITE(100,*) '@map font 32 to "URW-Palladio-L-Bold-Italic", "URW-Palladio-L-Bold-Italic"'
WRITE(100,*) '@map font 12 to "Symbol", "Symbol"'
WRITE(100,*) '@map font 34 to "URW-Chancery-L-Medium-Italic", "URW-Chancery-L-Medium-Italic"'
WRITE(100,*) '@map color 0 to (255, 255, 255), "white"'
WRITE(100,*) '@map color 1 to (0, 0, 0), "black"'
WRITE(100,*) '@map color 2 to (255, 0, 0), "red"'
WRITE(100,*) '@map color 3 to (0, 255, 0), "green"'
WRITE(100,*) '@map color 4 to (0, 0, 255), "blue"'
WRITE(100,*) '@map color 5 to (255, 255, 0), "yellow"'
WRITE(100,*) '@map color 6 to (188, 143, 143), "brown"'
WRITE(100,*) '@map color 7 to (220, 220, 220), "grey"'
WRITE(100,*) '@map color 8 to (148, 0, 211), "violet"'
WRITE(100,*) '@map color 9 to (0, 255, 255), "cyan"'
WRITE(100,*) '@map color 10 to (255, 0, 255), "magenta"'
WRITE(100,*) '@map color 11 to (255, 165, 0), "orange"'
WRITE(100,*) '@map color 12 to (114, 33, 188), "indigo"'
WRITE(100,*) '@map color 13 to (103, 7, 72), "maroon"'
WRITE(100,*) '@map color 14 to (64, 224, 208), "turquoise"'
WRITE(100,*) '@map color 15 to (0, 139, 0), "green4"'
WRITE(100,*) '@reference date 0'
WRITE(100,*) '@date wrap off'
WRITE(100,*) '@date wrap year 1950'
WRITE(100,*) '@default linewidth 1.0'
WRITE(100,*) '@default linestyle 1'
WRITE(100,*) '@default color 1'
WRITE(100,*) '@default pattern 1'
WRITE(100,*) '@default font 0'
WRITE(100,*) '@default char size 1.000000'
WRITE(100,*) '@default symbol size 1.000000'
WRITE(100,*) '@default sformat "%.8g"'
WRITE(100,*) '@background color 0'
WRITE(100,*) '@page background fill on'
WRITE(100,*) '@timestamp off'
WRITE(100,*) '@timestamp 0.03, 0.03'
WRITE(100,*) '@timestamp color 1'
WRITE(100,*) '@timestamp rot 0'
WRITE(100,*) '@timestamp font 0'
WRITE(100,*) '@timestamp char size 1.000000'
WRITE(100,*) '@timestamp def "Wed Jun 23 18:58:05 2015"'
WRITE(100,*) '@with string'
WRITE(100,*) '@r0 off'
WRITE(100,*) '@link r0 to g0'
WRITE(100,*) '@r0 type above'
WRITE(100,*) '@r0 linestyle 1'
WRITE(100,*) '@r0 linewidth 1.0'
WRITE(100,*) '@r0 color 1'
WRITE(100,*) '@r0 line 0, 0, 0, 0'
WRITE(100,*) '@r1 off'
WRITE(100,*) '@link r1 to g0'
WRITE(100,*) '@r1 type above'
WRITE(100,*) '@r1 linestyle 1'
WRITE(100,*) '@r1 linewidth 1.0'
WRITE(100,*) '@r1 color 1'
WRITE(100,*) '@r1 line 0, 0, 0, 0'
WRITE(100,*) '@r2 off'
WRITE(100,*) '@link r2 to g0'
WRITE(100,*) '@r2 type above'
WRITE(100,*) '@r2 linestyle 1'
WRITE(100,*) '@r2 linewidth 1.0'
WRITE(100,*) '@r2 color 1'
WRITE(100,*) '@r2 line 0, 0, 0, 0'
WRITE(100,*) '@r3 off'
WRITE(100,*) '@link r3 to g0'
WRITE(100,*) '@r3 type above'
WRITE(100,*) '@r3 linestyle 1'
WRITE(100,*) '@r3 linewidth 1.0'
WRITE(100,*) '@r3 color 1'
WRITE(100,*) '@r3 line 0, 0, 0, 0'
WRITE(100,*) '@r4 off'
WRITE(100,*) '@link r4 to g0'
WRITE(100,*) '@r4 type above'
WRITE(100,*) '@r4 linestyle 1'
WRITE(100,*) '@r4 linewidth 1.0'
WRITE(100,*) '@r4 color 1'
WRITE(100,*) '@r4 line 0, 0, 0, 0'

RETURN
END SUBROUTINE buildBeginning



! ###############################################################################################
!
! Writes main body of Grace file -> i.e. graph space, one for each data point/column.
!
! ###############################################################################################
SUBROUTINE buildBody()
    USE userInput
    IMPLICIT NONE

OPEN(UNIT=300,FILE='tempData.dat',STATUS='UNKNOWN')
dataPoint=0
numendLines=0

DO
	CALL numberTOstring(dataPoint,tempString)
	WRITE(*,'(A,A)') 'Enter data point (x_value y_value) ', TRIM(ADJUSTL(tempString))
	READ(*,*) xpoint, ypoint
	IF ((sameColor.EQV..FALSE.).OR.(dataPoint==0)) THEN
		IF (sameColor.EQV..FALSE.) THEN
			WRITE(*,*) 'What color do you want the bar? ("-1" for help)'
		ELSE
			WRITE(*,*) 'What color do you want *all* the bars? ("-1" for help)'
		END IF
		DO
			READ(*,*) color
			IF (color==-1) THEN
				CALL colorHelp
				WRITE(*,*) 'Now, what color? ("-1" for help)'
			ELSE IF ((color>16).OR.(color<-1)) THEN
			    WRITE(*,*) 'Error: Not a color, try again.'
			ELSE
				EXIT
			END IF
		END DO
	END IF

	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' on'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' hidden false'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' type Chart'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' stacked false'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' bar hgap 0.000000'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' fixedpoint off'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' fixedpoint type 0'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' fixedpoint xy 0.000000, 0.000000'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' fixedpoint format general general'
	WRITE(100,*) '@g' // TRIM(ADJUSTL(tempString)) // ' fixedpoint prec 6, 6'
	WRITE(100,*) '@with g' // TRIM(ADJUSTL(tempString))
	CALL numberTOstring(xmin,xminString)
	CALL numberTOstring(ymin,yminString)
	CALL numberTOstring(xmax,xmaxString)
	CALL numberTOstring(ymax,ymaxString)
	WRITE(100,1001) '@    world ',TRIM(ADJUSTL(xminString)),', ',TRIM(ADJUSTL(yminString)),', ',&
	TRIM(ADJUSTL(xmaxString)),', ',TRIM(ADJUSTL(ymaxString))
	1001 FORMAT(A,A,A,A,A,A,A,A)
	WRITE(100,*) '@    stack world 0, 0, 0, 0'
	WRITE(100,*) '@    znorm 1'
	WRITE(100,*) '@    view 0.150000, 0.150000, 1.000000, 0.850000'
	WRITE(100,'(A,A,A)') '@    title "', title, '"'
	WRITE(100,*) '@    title font 0'
	WRITE(100,*) '@    title size 1.500000'
	WRITE(100,*) '@    title color 1'
	WRITE(100,'(A,A,A)') '@    subtitle "', subtitle, '"'
	WRITE(100,*) '@    subtitle font 0'
	WRITE(100,*) '@    subtitle size 1.000000'
	WRITE(100,*) '@    subtitle color 1'
	WRITE(100,*) '@    xaxes scale Normal'
	WRITE(100,*) '@    yaxes scale Normal'
	WRITE(100,*) '@    xaxes invert off'
	WRITE(100,*) '@    yaxes invert off'
	WRITE(100,*) '@    xaxis  on'
	WRITE(100,*) '@    xaxis  type zero false'
	WRITE(100,*) '@    xaxis  offset 0.000000 , 0.000000'
	WRITE(100,*) '@    xaxis  bar off'
	WRITE(100,*) '@    xaxis  bar color 1'
	WRITE(100,*) '@    xaxis  bar linestyle 1'
	WRITE(100,*) '@    xaxis  bar linewidth 1.0'
	IF (dataPoint == 0) THEN
		WRITE(100,*) '@    xaxis  label "' // xlabel // '"'
	ELSE
		WRITE(100,*) '@    xaxis  label ""'
	END IF
	WRITE(100,*) '@    xaxis  label layout para'
	WRITE(100,*) '@    xaxis  label place auto'
	WRITE(100,*) '@    xaxis  label char size 1.000000'
	WRITE(100,*) '@    xaxis  label font 0'
	WRITE(100,*) '@    xaxis  label color 1'
	WRITE(100,*) '@    xaxis  label place normal'
	IF ((dataPoint == 0).AND.(xTicks.EQV..TRUE.)) THEN
		WRITE(100,*) '@    xaxis  tick on'
	ELSE
		WRITE(100,*) '@    xaxis  tick off'
	END IF
	CALL numberTOstring(xmajor,tempString)
	WRITE(100,*) '@    xaxis  tick major ' // TRIM(ADJUSTL(tempString))
	CALL numberTOstring(xminor,tempString)
	WRITE(100,*) '@    xaxis  tick minor ticks ' // TRIM(ADJUSTL(tempString))
	WRITE(100,*) '@    xaxis  tick default 6'
	WRITE(100,*) '@    xaxis  tick place rounded true'
	WRITE(100,*) '@    xaxis  tick in'
	WRITE(100,*) '@    xaxis  tick major size 1.000000'
	WRITE(100,*) '@    xaxis  tick major color 1'
	WRITE(100,*) '@    xaxis  tick major linewidth 1.0'
	WRITE(100,*) '@    xaxis  tick major linestyle 1'
	WRITE(100,*) '@    xaxis  tick major grid off'
	WRITE(100,*) '@    xaxis  tick minor color 1'
	WRITE(100,*) '@    xaxis  tick minor linewidth 1.0'
	WRITE(100,*) '@    xaxis  tick minor linestyle 1'
	WRITE(100,*) '@    xaxis  tick minor grid off'
	WRITE(100,*) '@    xaxis  tick minor size 0.500000'
	IF ((dataPoint == 0).AND.(xNumbers.EQV..TRUE.)) THEN
		WRITE(100,*) '@    xaxis  ticklabel on'
	ELSE
		WRITE(100,*) '@    xaxis  ticklabel off'
	END IF
	WRITE(100,*) '@    xaxis  ticklabel format general'
	WRITE(100,*) '@    xaxis  ticklabel prec 5'
	WRITE(100,*) '@    xaxis  ticklabel formula ""'
	WRITE(100,*) '@    xaxis  ticklabel append ""'
	WRITE(100,*) '@    xaxis  ticklabel prepend ""'
	WRITE(100,*) '@    xaxis  ticklabel angle 0'
	WRITE(100,*) '@    xaxis  ticklabel skip 0'
	WRITE(100,*) '@    xaxis  ticklabel stagger 0'
	WRITE(100,*) '@    xaxis  ticklabel place normal'
	WRITE(100,*) '@    xaxis  ticklabel offset auto'
	WRITE(100,*) '@    xaxis  ticklabel offset 0.000000 , 0.010000'
	WRITE(100,*) '@    xaxis  ticklabel start type auto'
	WRITE(100,*) '@    xaxis  ticklabel start 0.000000'
	WRITE(100,*) '@    xaxis  ticklabel stop type auto'
	WRITE(100,*) '@    xaxis  ticklabel stop 0.000000'
	WRITE(100,*) '@    xaxis  ticklabel char size 1.000000'
	WRITE(100,*) '@    xaxis  ticklabel font 0'
	WRITE(100,*) '@    xaxis  ticklabel color 1'
	WRITE(100,*) '@    xaxis  tick place both'
	WRITE(100,*) '@    xaxis  tick spec type none'
	WRITE(100,*) '@    yaxis  on'
	WRITE(100,*) '@    yaxis  type zero false'
	WRITE(100,*) '@    yaxis  offset 0.000000 , 0.000000'
	WRITE(100,*) '@    yaxis  bar on'
	WRITE(100,*) '@    yaxis  bar color 1'
	WRITE(100,*) '@    yaxis  bar linestyle 1'
	WRITE(100,*) '@    yaxis  bar linewidth 1.0'
	IF ((dataPoint == 0).AND.(yTicks.EQV..TRUE.)) THEN
		WRITE(100,*) '@    yaxis  label "' // ylabel // '"'
	ELSE
		WRITE(100,*) '@    yaxis  label ""'
	END IF
	WRITE(100,*) '@    yaxis  label layout para'
	WRITE(100,*) '@    yaxis  label place auto'
	WRITE(100,*) '@    yaxis  label char size 1.000000'
	WRITE(100,*) '@    yaxis  label font 0'
	WRITE(100,*) '@    yaxis  label color 1'
	WRITE(100,*) '@    yaxis  label place normal'
	IF (dataPoint == 0) THEN
		WRITE(100,*) '@    yaxis  tick on'
	ELSE
		WRITE(100,*) '@    yaxis  tick off'
	END IF
	CALL numberTOstring(ymajor,tempString)
	WRITE(100,*) '@    yaxis  tick major ' // TRIM(ADJUSTL(tempString))
	CALL numberTOstring(yminor,tempString)
	WRITE(100,*) '@    yaxis  tick minor ticks ' // TRIM(ADJUSTL(tempString))
	WRITE(100,*) '@    yaxis  tick default 6'
	WRITE(100,*) '@    yaxis  tick place rounded true'
	WRITE(100,*) '@    yaxis  tick in'
	WRITE(100,*) '@    yaxis  tick major size 1.000000'
	WRITE(100,*) '@    yaxis  tick major color 1'
	WRITE(100,*) '@    yaxis  tick major linewidth 1.0'
	WRITE(100,*) '@    yaxis  tick major linestyle 1'
	WRITE(100,*) '@    yaxis  tick major grid off'
	WRITE(100,*) '@    yaxis  tick minor color 1'
	WRITE(100,*) '@    yaxis  tick minor linewidth 1.0'
	WRITE(100,*) '@    yaxis  tick minor linestyle 1'
	WRITE(100,*) '@    yaxis  tick minor grid off'
	WRITE(100,*) '@    yaxis  tick minor size 0.500000'
	IF ((dataPoint == 0).AND.(yNumbers.EQV..TRUE.)) THEN
		WRITE(100,*) '@    yaxis  ticklabel on'
	ELSE
		WRITE(100,*) '@    yaxis  ticklabel off'
	END IF
	WRITE(100,*) '@    yaxis  ticklabel format general'
	WRITE(100,*) '@    yaxis  ticklabel prec 5'
	WRITE(100,*) '@    yaxis  ticklabel formula ""'
	WRITE(100,*) '@    yaxis  ticklabel append ""'
	WRITE(100,*) '@    yaxis  ticklabel prepend ""'
	WRITE(100,*) '@    yaxis  ticklabel angle 0'
	WRITE(100,*) '@    yaxis  ticklabel skip 0'
	WRITE(100,*) '@    yaxis  ticklabel stagger 0'
	WRITE(100,*) '@    yaxis  ticklabel place normal'
	WRITE(100,*) '@    yaxis  ticklabel offset auto'
	WRITE(100,*) '@    yaxis  ticklabel offset 0.000000 , 0.010000'
	WRITE(100,*) '@    yaxis  ticklabel start type auto'
	WRITE(100,*) '@    yaxis  ticklabel start 0.000000'
	WRITE(100,*) '@    yaxis  ticklabel stop type auto'
	WRITE(100,*) '@    yaxis  ticklabel stop 0.000000'
	WRITE(100,*) '@    yaxis  ticklabel char size 1.000000'
	WRITE(100,*) '@    yaxis  ticklabel font 0'
	WRITE(100,*) '@    yaxis  ticklabel color 1'
	WRITE(100,*) '@    yaxis  tick place both'
	WRITE(100,*) '@    yaxis  tick spec type none'
	WRITE(100,*) '@    altxaxis  off'
	WRITE(100,*) '@    altyaxis  off'
	WRITE(100,*) '@    legend on'
	WRITE(100,*) '@    legend loctype view'
	WRITE(100,*) '@    legend 0.65, 0.8'
	WRITE(100,*) '@    legend box color 1'
	WRITE(100,*) '@    legend box pattern 1'
	WRITE(100,*) '@    legend box linewidth 1.0'
	WRITE(100,*) '@    legend box linestyle 1'
	WRITE(100,*) '@    legend box fill color 0'
	WRITE(100,*) '@    legend box fill pattern 1'
	WRITE(100,*) '@    legend font 0'
	WRITE(100,*) '@    legend char size 1.000000'
	WRITE(100,*) '@    legend color 1'
	WRITE(100,*) '@    legend length 4'
	WRITE(100,*) '@    legend vgap 1'
	WRITE(100,*) '@    legend hgap 1'
	WRITE(100,*) '@    legend invert false'
	WRITE(100,*) '@    frame type 0'
	WRITE(100,*) '@    frame linestyle 1'
	WRITE(100,*) '@    frame linewidth 1.0'
	WRITE(100,*) '@    frame color 1'
	WRITE(100,*) '@    frame pattern 1'
	WRITE(100,*) '@    frame background color 0'
	WRITE(100,*) '@    frame background pattern 0'
	WRITE(100,*) '@    s0 hidden false'
	WRITE(100,*) '@    s0 type bar'
	WRITE(100,*) '@    s0 symbol 0'
	WRITE(100,*) '@    s0 symbol size 3.010000'
	WRITE(100,*) '@    s0 symbol color 1'
	WRITE(100,*) '@    s0 symbol pattern 1'
	CALL numberTOstring(color,tempString)
	WRITE(100,*) '@    s0 symbol fill color ' // TRIM(ADJUSTL(tempString))
	WRITE(100,*) '@    s0 symbol fill pattern 1'
	WRITE(100,*) '@    s0 symbol linewidth 1.0'
	WRITE(100,*) '@    s0 symbol linestyle 1'
	WRITE(100,*) '@    s0 symbol char 65'
	WRITE(100,*) '@    s0 symbol char font 0'
	WRITE(100,*) '@    s0 symbol skip 0'
	WRITE(100,*) '@    s0 line type 1'
	WRITE(100,*) '@    s0 line linestyle 1'
	WRITE(100,*) '@    s0 line linewidth 1.0'
	WRITE(100,*) '@    s0 line color 1'
	WRITE(100,*) '@    s0 line pattern 1'
	WRITE(100,*) '@    s0 baseline type 0'
	WRITE(100,*) '@    s0 baseline off'
	WRITE(100,*) '@    s0 dropline off'
	WRITE(100,*) '@    s0 fill type 0'
	WRITE(100,*) '@    s0 fill rule 0'
	WRITE(100,*) '@    s0 fill color 1'
	WRITE(100,*) '@    s0 fill pattern 1'
	WRITE(100,*) '@    s0 avalue off'
	WRITE(100,*) '@    s0 avalue type 2'
	WRITE(100,*) '@    s0 avalue char size 1.000000'
	WRITE(100,*) '@    s0 avalue font 0'
	WRITE(100,*) '@    s0 avalue color 1'
	WRITE(100,*) '@    s0 avalue rot 0'
	WRITE(100,*) '@    s0 avalue format general'
	WRITE(100,*) '@    s0 avalue prec 3'
	WRITE(100,*) '@    s0 avalue prepend ""'
	WRITE(100,*) '@    s0 avalue append ""'
	WRITE(100,*) '@    s0 avalue offset 0.000000 , 0.000000'
	WRITE(100,*) '@    s0 errorbar on'
	WRITE(100,*) '@    s0 errorbar place both'
	WRITE(100,*) '@    s0 errorbar color 1'
	WRITE(100,*) '@    s0 errorbar pattern 1'
	WRITE(100,*) '@    s0 errorbar size 1.000000'
	WRITE(100,*) '@    s0 errorbar linewidth 1.0'
	WRITE(100,*) '@    s0 errorbar linestyle 1'
	WRITE(100,*) '@    s0 errorbar riser linewidth 1.0'
	WRITE(100,*) '@    s0 errorbar riser linestyle 1'
	WRITE(100,*) '@    s0 errorbar riser clip off'
	WRITE(100,*) '@    s0 errorbar riser clip length 0.100000'
	WRITE(100,*) '@    s0 comment ""'
	WRITE(100,*) '@    s0 legend  ""' 

	CALL numberTOstring(dataPoint,tempString)
	WRITE(300,*) '@target G' // TRIM(ADJUSTL(tempString)) // '.S0'
	WRITE(300,*) '@type bar'
	CALL numberTOstring(xpoint,tempString)
	CALL numberTOstring(ypoint,tempString2)
	WRITE(300,*) TRIM(ADJUSTL(tempString)) // ' ' // TRIM(ADJUSTL(tempString2))
	numendLines = numendLines + 3

	WRITE(*,*) 'Enter another data point? (Y/N)'
	CALL yesNo(anotherPoint)
	IF (anotherPoint.EQV..TRUE.) THEN
		WRITE(300,*) '&'
		dataPoint = dataPoint + 1
		numendLines = numendLines + 1
	ELSE
		EXIT
	END IF
END DO

 CLOSE(100); CLOSE(300)

RETURN
END SUBROUTINE buildBody



! ###############################################################################################
!
! Writes end lines of Grace file -> i.e. data points
!
! ###############################################################################################
SUBROUTINE buildEnd()
	USE userInput
	IMPLICIT NONE
	INTEGER :: i, IOstatus

OPEN(UNIT=100, FILE=TRIM(filename), STATUS='OLD',POSITION='APPEND',ACTION='WRITE')
OPEN(UNIT=300,FILE='tempData.dat',STATUS='OLD',ACTION='READ')

IOstatus=0
DO WHILE (IOstatus==0)
	READ(300,'(A)',IOSTAT=IOstatus) longString
	WRITE(100,'(A)') TRIM(ADJUSTL(longString))
END DO

!DO i=1,numendLines-1
!	READ(300,*) longString
!	WRITE(100,*) TRIM(ADJUSTL(longString))
!END DO

 CLOSE(100); CLOSE(300)

RETURN
END SUBROUTINE buildEnd



! ###############################################################################################
!
! Gives information about what is required from a Data File.  Includes options of "Full Header" and "Color".
!
! ###############################################################################################
SUBROUTINE colorHelp()
    IMPLICIT NONE

WRITE(*,*) ' #    Color'
WRITE(*,*) '--------------'
WRITE(*,*) ' 0    White'
WRITE(*,*) ' 1    Black'
WRITE(*,*) ' 2    Red'
WRITE(*,*) ' 3    Green'
WRITE(*,*) ' 4    Blue'
WRITE(*,*) ' 5    Yellow'
WRITE(*,*) ' 6    Brown'
WRITE(*,*) ' 7    Grey'
WRITE(*,*) ' 8    Violet'
WRITE(*,*) ' 9    Cyan'
WRITE(*,*) ' 10   Magenta'
WRITE(*,*) ' 11   Orange'
WRITE(*,*) ' 12   Indigo'
WRITE(*,*) ' 13   Maron'
WRITE(*,*) ' 14   Turquoise'
WRITE(*,*) ' 15   Green4'
WRITE(*,*) ''

RETURN
END SUBROUTINE colorHelp
