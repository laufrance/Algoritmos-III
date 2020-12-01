!classDefinition: #MarsRoverTest category: 'Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 11/30/2020 21:58:24'!
test01
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	self assert: marsRoverVehicle isOnInicialCoordinate.
	
	
	! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate cardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'MW 11/30/2020 21:54:25'!
initializeOn: aCoordinate facing: aCardinalPoint 

	coordinate := aCoordinate.
	cardinalPoint := aCardinalPoint.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 11/30/2020 21:55:06'!
isOnInicialCoordinate
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MW 11/30/2020 21:52:52'!
on: aCoordinate facing: aCardinalPoint 
	
	^self new initializeOn: aCoordinate facing: aCardinalPoint.! !
