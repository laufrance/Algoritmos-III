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


!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:07:21'!
executeCommands: aListOfCommands
	
	aListOfCommands size timesRepeat: [(MarsRover allSubclasses detect: [: aClass | aClass canHandle: cardinalPoint]) executeSpecificCommand: (aListOfCommands at: index)].
	index := 1.
	

	


	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:13:43'!
executeSpecificCommand: aCommand
	
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalEsteRule methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:12:21'!
executeSpecificCommand: aCommand
	
	(aCommand = $f) ifTrue: [coordinate := coordinate + `1@0`]. 
	(aCommand = $b) ifTrue: [coordinate := coordinate - `1@0`]. 
	(aCommand = $r) ifTrue: [cardinalPoint := 'S']. 
	(aCommand = $l) ifTrue: [cardinalPoint := 'N'].
	index := index + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalEsteRule class' category: 'Mars Rover'!
CardinalEsteRule class
	instanceVariableNames: ''!

!CardinalEsteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:18'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'E'! !

!CardinalEsteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:20:19'!
executeSpecificCommand: aCommand
	
	^self new executeSpecificCommand: aCommand.
	
	! !

!CardinalEsteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:23:02'!
initializeWith: aCommand
	! !


!classDefinition: #CardinalNorteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalNorteRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalNorteRule methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:11:23'!
executeSpecificCommand: aCommand
	
	(aCommand = $f) ifTrue: [coordinate := coordinate + `0@1`]. 
	(aCommand = $b) ifTrue: [coordinate := coordinate - `0@1`]. 
	(aCommand = $r) ifTrue: [cardinalPoint := 'E']. 
	(aCommand = $l) ifTrue: [cardinalPoint := 'O'].
	index := index + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalNorteRule class' category: 'Mars Rover'!
CardinalNorteRule class
	instanceVariableNames: ''!

!CardinalNorteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:34'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'N'! !

!CardinalNorteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:20:28'!
executeSpecificCommand: aCommand
	
	^self new executeSpecificCommand: aCommand.! !


!classDefinition: #CardinalOesteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalOesteRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalOesteRule methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:13:36'!
executeSpecificCommand: aCommand
	
	(aCommand = $f) ifTrue: [coordinate := coordinate - `1@0`]. 
	(aCommand = $b) ifTrue: [coordinate := coordinate + `1@0`]. 
	(aCommand = $r) ifTrue: [cardinalPoint := 'N']. 
	(aCommand = $l) ifTrue: [cardinalPoint := 'S'].
	index := index + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalOesteRule class' category: 'Mars Rover'!
CardinalOesteRule class
	instanceVariableNames: ''!

!CardinalOesteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:41'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'O'! !

!CardinalOesteRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:20:35'!
executeSpecificCommand: aCommand
	
	^self new executeSpecificCommand: aCommand.! !


!classDefinition: #CardinalSurRule category: 'Mars Rover'!
MarsRover subclass: #CardinalSurRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalSurRule methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:12:54'!
executeSpecificCommand: aCommand
	
	(aCommand = $f) ifTrue: [coordinate := coordinate - `0@1`]. 
	(aCommand = $b) ifTrue: [coordinate := coordinate + `0@1`]. 
	(aCommand = $r) ifTrue: [cardinalPoint := 'O']. 
	(aCommand = $l) ifTrue: [cardinalPoint := 'E'].
	index := index + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalSurRule class' category: 'Mars Rover'!
CardinalSurRule class
	instanceVariableNames: ''!

!CardinalSurRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:47'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'S'! !

!CardinalSurRule class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:20:40'!
executeSpecificCommand: aCommand
	
	^self new executeSpecificCommand: aCommand.! !
