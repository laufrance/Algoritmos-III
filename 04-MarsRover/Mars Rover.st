!classDefinition: #MarsRoverTest category: 'Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 13:25:49'!
test01MarsRoverIsOnInitialPositionAfterExecutingAnEmptyCommandsSeries
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: ' '.
	
	self assert: (marsRoverVehicle isOn: 0@0 facing: 'N').
	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 14:19:32'!
test02MarsRoverIsNotOnInitialPositionAfterExecutingACommand
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'f'.
	
	self deny: (marsRoverVehicle isOn: 0@0 facing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 14:56:04'!
test03MarsRoverIsNotOnInitialPositionAfterExecutingACommandSeries
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'lfbfr'.
	
	self deny: (marsRoverVehicle isOn: 0@0 facing: 'N').

	
	
	! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate cardinalPoint index'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'MW 12/2/2020 13:54:43'!
initializeOn: aCoordinate facing: aCardinalPoint 

	coordinate := aCoordinate.
	cardinalPoint := aCardinalPoint.
	index := 1.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:05:33'!
executeCommands: aListOfCommands
	
	|theCardinalRule|
	
	aListOfCommands size timesRepeat: 
	
	[theCardinalRule := (MarsRover allSubclasses detect: [: aClass | aClass canHandle: cardinalPoint]).
		
		theCardinalRule := theCardinalRule withCoordinateOn: coordinate executing: (aListOfCommands at: index).
		
		theCardinalRule executeSpecificCommand.
		
		coordinate := coordinate + theCardinalRule ruleCoordinate.
		
		cardinalPoint := theCardinalRule ruleCardinal.
		
		index:= index +1].
	index := 1.
	

	"theCardinalRule executeSpecificCommand: (aListOfCommands at: index)"


	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:04:50'!
executeSpecificCommand
	
	self subclassResponsibility.
	
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 14:07:43'!
isOn: aCoordinate facing: aCardinalPoint
	
	^coordinate = aCoordinate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MW 12/2/2020 15:09:35'!
canHandle: aCardinalPoint

	self subclassResponsibility.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'MW 11/30/2020 21:52:52'!
on: aCoordinate facing: aCardinalPoint 
	
	^self new initializeOn: aCoordinate facing: aCardinalPoint.! !


!classDefinition: #CardinalEsteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalEsteRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalEsteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 15:57:27'!
executeSpecificCommand
	
	(ruleCommand = $f) ifTrue: [ruleCoordinate := ruleCoordinate + `1@0`]. 
	(ruleCommand = $b) ifTrue: [ruleCoordinate := ruleCoordinate - `1@0`]. 
	(ruleCommand = $r) ifTrue: [ruleCardinal := 'S']. 
	(ruleCommand = $l) ifTrue: [ruleCardinal := 'N'].! !

!CardinalEsteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 15:54:10'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'E'.
	
	ruleCommand := aSpecificCommand.






! !

!CardinalEsteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 15:58:30'!
ruleCardinal

^ruleCardinal! !

!CardinalEsteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 15:58:19'!
ruleCoordinate

^ruleCoordinate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalEsteRule class' category: 'Mars Rover'!
CardinalEsteRule class
	instanceVariableNames: ''!

!CardinalEsteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:18'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'E'! !

!CardinalEsteRule class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 15:43:52'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !


!classDefinition: #CardinalNorteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalNorteRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalNorteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:02:07'!
executeSpecificCommand
	
	(ruleCommand = $f) ifTrue: [ruleCoordinate := ruleCoordinate + `0@1`]. 
	(ruleCommand = $b) ifTrue: [ruleCoordinate := ruleCoordinate - `0@1`]. 
	(ruleCommand = $r) ifTrue: [ruleCardinal := 'E']. 
	(ruleCommand = $l) ifTrue: [ruleCardinal := 'O'].
! !

!CardinalNorteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:03:41'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'N'.
	
	ruleCommand := aSpecificCommand.






! !

!CardinalNorteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:06:12'!
ruleCardinal

	^ruleCardinal! !

!CardinalNorteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:06:17'!
ruleCoordinate

	^ruleCoordinate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalNorteRule class' category: 'Mars Rover'!
CardinalNorteRule class
	instanceVariableNames: ''!

!CardinalNorteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:34'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'N'! !

!CardinalNorteRule class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:00:46'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !


!classDefinition: #CardinalOesteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalOesteRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalOesteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:02:46'!
executeSpecificCommand
	
	(ruleCommand = $f) ifTrue: [ruleCoordinate := ruleCoordinate - `1@0`]. 
	(ruleCommand = $b) ifTrue: [ruleCoordinate := ruleCoordinate + `1@0`]. 
	(ruleCommand = $r) ifTrue: [ruleCardinal := 'N']. 
	(ruleCommand = $l) ifTrue: [ruleCardinal := 'S'].
! !

!CardinalOesteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:03:48'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'O'.
	
	ruleCommand := aSpecificCommand.






! !

!CardinalOesteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:06:25'!
ruleCardinal

	^ruleCardinal! !

!CardinalOesteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:06:22'!
ruleCoordinate

	^ruleCoordinate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalOesteRule class' category: 'Mars Rover'!
CardinalOesteRule class
	instanceVariableNames: ''!

!CardinalOesteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:41'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'O'! !

!CardinalOesteRule class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:00:49'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !


!classDefinition: #CardinalSurRule category: 'Mars Rover'!
MarsRover subclass: #CardinalSurRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalSurRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:03:23'!
executeSpecificCommand
	
	(ruleCommand = $f) ifTrue: [ruleCoordinate := ruleCoordinate - `0@1`]. 
	(ruleCommand = $b) ifTrue: [ruleCoordinate := ruleCoordinate + `0@1`]. 
	(ruleCommand = $r) ifTrue: [ruleCardinal := 'O']. 
	(ruleCommand = $l) ifTrue: [ruleCardinal := 'E'].
! !

!CardinalSurRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:03:58'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'S'.
	
	ruleCommand := aSpecificCommand.






! !

!CardinalSurRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:06:29'!
ruleCardinal

	^ruleCardinal! !

!CardinalSurRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:06:32'!
ruleCoordinate

	^ruleCoordinate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalSurRule class' category: 'Mars Rover'!
CardinalSurRule class
	instanceVariableNames: ''!

!CardinalSurRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:47'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'S'! !

!CardinalSurRule class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:00:54'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !
