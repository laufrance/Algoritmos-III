!classDefinition: #MarsRoverTest category: 'Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:20:43'!
test01MarsRoverIsOnInitialPositionAfterExecutingAnEmptyCommandsSeries
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: ''.
	
	self assert: (marsRoverVehicle isOn: 0@0 facing: 'N').
	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:50:58'!
test02MarsRoverMovesForwardWithTheCommandf
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'f'.
	
	self assert: (marsRoverVehicle isOn: 0@1 facing: 'N').


	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:50:51'!
test03MarsRoverMovesBackwardsWithTheCommandb
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'E'.
	
	marsRoverVehicle executeCommands: 'b'.
	
	self assert: (marsRoverVehicle isOn: -1@0 facing: 'E').


	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:50:44'!
test04MarsRoverTurnsLeftWithTheCommandl
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'S'.
	
	marsRoverVehicle executeCommands: 'l'.
	
	self assert: (marsRoverVehicle isOn: 0@0 facing: 'E').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:50:35'!
test05MarsRoverTurnsRightWithTheCommandr

	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'O'.
	
	marsRoverVehicle executeCommands: 'r'.
	
	self assert: (marsRoverVehicle isOn: 0@0 facing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:50:27'!
test06MarsRoverIsNotOnInitialPositionAfterExecutingACommand
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'f'.
	
	self deny: (marsRoverVehicle isOn: 0@0 facing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:50:14'!
test07MarsRoverIsNotOnInitialPositionAfterExecutingACommandSeries
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'fbrbblfrbfbl'.
	
	self deny: (marsRoverVehicle isOn: 0@0 facing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:54:19'!
test08MarsRoverFailsExecutingAllTheCommandsWhenACommandIsInvalid
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'fbrqbml'.
	
	self deny: ( marsRoverVehicle canExecute: 'fbrqbml' )

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:49:52'!
test09MarsRoverExecuteCorrectlyAllTheCommandsWhenTheCommandsAreValid
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'f'.
	
	self assert: ( marsRoverVehicle canExecute: 'f')

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:49:44'!
test10MarsRoverCanNotInitializeWithAnInvalidCardinalPoint
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'V'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self deny: (marsRoverVehicle canInitializeFacing: 'V').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:49:35'!
test11MarsRoverCanInitializeWithAValidCardinalPoint
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self assert: (marsRoverVehicle canInitializeFacing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:49:26'!
test12MarsRoverCanNotInitializeInAnInvalidCoordinate

	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self deny: (marsRoverVehicle canInitializeInPosition: 0).

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:49:18'!
test13MarsRoverCanInitializeInAnValidCoordinate
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self assert: (marsRoverVehicle canInitializeInPosition: 0@0).

	
	
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


!MarsRover methodsFor: 'comparing' stamp: 'LF 12/3/2020 10:22:55'!
isOn: aCoordinate facing: aCardinalPoint
	
	^(coordinate = aCoordinate) and: [^cardinalPoint = aCardinalPoint].! !


!MarsRover methodsFor: 'executing' stamp: 'LF 12/4/2020 10:34:52'!
executeCommands: aListOfCommands
	
	|theMarsRoverProcessor theSetMarsRoverProcessor|
	
	theMarsRoverProcessor := MarsRoverProcessor allSubclasses detect: [: aClass | aClass canHandle: cardinalPoint] ifNone: [^index].
	
	aListOfCommands size timesRepeat: 

		[theSetMarsRoverProcessor := theMarsRoverProcessor withCoordinateOn: `0@0` executing: (aListOfCommands at: index).
	
		self updateMarsRoverPositionWithTheInformationOf: theSetMarsRoverProcessor.
	
		index:= index +1 ].
		
	index := 1.
	
	! !

!MarsRover methodsFor: 'executing' stamp: 'LF 12/4/2020 09:47:32'!
updateMarsRoverPositionWithTheInformationOf: theMarsRoverProcessor

	coordinate := coordinate + theMarsRoverProcessor ruleCoordinate.
	cardinalPoint := theMarsRoverProcessor ruleCardinal! !


!MarsRover methodsFor: 'assertions' stamp: 'MW 12/3/2020 14:53:25'!
canExecute: aListOfCommands
	
	^('fblr' includesAllOf: aListOfCommands)! !

!MarsRover methodsFor: 'assertions' stamp: 'MW 12/3/2020 15:33:38'!
canInitializeFacing: aCardinalPoint

	^'NSOE' includes: (cardinalPoint at: 1)! !

!MarsRover methodsFor: 'assertions' stamp: 'MW 12/3/2020 15:40:53'!
canInitializeInPosition: aPosition 
	
	^aPosition isPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MW 11/30/2020 21:52:52'!
on: aCoordinate facing: aCardinalPoint 
	
	^self new initializeOn: aCoordinate facing: aCardinalPoint.! !


!classDefinition: #MarsRoverProcessor category: 'Mars Rover'!
Object subclass: #MarsRoverProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!


!classDefinition: #CardinalEsteActions category: 'Mars Rover'!
MarsRoverProcessor subclass: #CardinalEsteActions
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalEsteActions methodsFor: 'executing' stamp: 'LF 12/4/2020 10:33:52'!
executeSpecificCommand
	
	ruleCoordinate := (CardinalEsteActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]ifNone:[^0]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalEsteActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]ifNone:[^0]) changeCardinal.
! !


!CardinalEsteActions methodsFor: 'value' stamp: 'MW 12/4/2020 15:58:03'!
ruleCardinal

	^ruleCardinal! !

!CardinalEsteActions methodsFor: 'value' stamp: 'MW 12/4/2020 15:57:59'!
ruleCoordinate

	^ruleCoordinate ! !


!CardinalEsteActions methodsFor: 'initialization' stamp: 'MW 12/3/2020 14:04:48'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'E'.
	
	ruleCommand := aSpecificCommand.
	
	self executeSpecificCommand.






! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalEsteActions class' category: 'Mars Rover'!
CardinalEsteActions class
	instanceVariableNames: ''!

!CardinalEsteActions class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:18'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'E'! !

!CardinalEsteActions class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 15:43:52'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !


!classDefinition: #MoveEsteBackwards category: 'Mars Rover'!
CardinalEsteActions subclass: #MoveEsteBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveEsteBackwards class' category: 'Mars Rover'!
MoveEsteBackwards class
	instanceVariableNames: ''!

!MoveEsteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:05'!
canHandle: aCommand

	^aCommand = $b.! !

!MoveEsteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:09'!
changeCardinal

	^'E'.! !

!MoveEsteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:12'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate - `1@0`
! !


!classDefinition: #MoveEsteForward category: 'Mars Rover'!
CardinalEsteActions subclass: #MoveEsteForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveEsteForward class' category: 'Mars Rover'!
MoveEsteForward class
	instanceVariableNames: ''!

!MoveEsteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:17'!
canHandle: aCommand

	^aCommand = $f.! !

!MoveEsteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:21'!
changeCardinal

	^'E'.! !

!MoveEsteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:26'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate + `1@0`! !


!classDefinition: #TurnEsteLeft category: 'Mars Rover'!
CardinalEsteActions subclass: #TurnEsteLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnEsteLeft class' category: 'Mars Rover'!
TurnEsteLeft class
	instanceVariableNames: ''!

!TurnEsteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:32'!
canHandle: aCommand

	^aCommand = $l.! !

!TurnEsteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:35'!
changeCardinal

	^'N'! !

!TurnEsteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:39'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !


!classDefinition: #TurnEsteRight category: 'Mars Rover'!
CardinalEsteActions subclass: #TurnEsteRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnEsteRight class' category: 'Mars Rover'!
TurnEsteRight class
	instanceVariableNames: ''!

!TurnEsteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:51'!
canHandle: aCommand

	^aCommand = $r.! !

!TurnEsteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:47'!
changeCardinal

	^'S'! !

!TurnEsteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:11:43'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !


!classDefinition: #CardinalNorteActions category: 'Mars Rover'!
MarsRoverProcessor subclass: #CardinalNorteActions
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalNorteActions methodsFor: 'value' stamp: 'LF 12/2/2020 16:06:12'!
ruleCardinal

	^ruleCardinal! !

!CardinalNorteActions methodsFor: 'value' stamp: 'LF 12/2/2020 16:06:17'!
ruleCoordinate

	^ruleCoordinate ! !


!CardinalNorteActions methodsFor: 'executing' stamp: 'LF 12/4/2020 10:33:11'!
executeSpecificCommand
	
	ruleCoordinate := (CardinalNorteActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand] ifNone: [^0]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalNorteActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]ifNone:[^0]) changeCardinal.! !


!CardinalNorteActions methodsFor: 'initialization' stamp: 'LF 12/2/2020 16:26:24'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'N'.
	
	ruleCommand := aSpecificCommand.
	
	self executeSpecificCommand.






! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalNorteActions class' category: 'Mars Rover'!
CardinalNorteActions class
	instanceVariableNames: ''!

!CardinalNorteActions class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:34'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'N'! !

!CardinalNorteActions class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:00:46'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !


!classDefinition: #MoveNorteBackwards category: 'Mars Rover'!
CardinalNorteActions subclass: #MoveNorteBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveNorteBackwards class' category: 'Mars Rover'!
MoveNorteBackwards class
	instanceVariableNames: ''!

!MoveNorteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:57:08'!
canHandle: aCommand

	^aCommand = $b.! !

!MoveNorteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:57:04'!
changeCardinal

	^'N'.! !

!MoveNorteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:56:59'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate - `0@1`
! !


!classDefinition: #MoveNorteForward category: 'Mars Rover'!
CardinalNorteActions subclass: #MoveNorteForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveNorteForward class' category: 'Mars Rover'!
MoveNorteForward class
	instanceVariableNames: ''!

!MoveNorteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:57:19'!
canHandle: aCommand

	^aCommand = $f.! !

!MoveNorteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:57:16'!
changeCardinal

	^'N'.! !

!MoveNorteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:57:13'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate + `0@1`! !


!classDefinition: #TurnNorteLeft category: 'Mars Rover'!
CardinalNorteActions subclass: #TurnNorteLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnNorteLeft class' category: 'Mars Rover'!
TurnNorteLeft class
	instanceVariableNames: ''!

!TurnNorteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:59:02'!
canHandle: aCommand

	^aCommand = $l.! !

!TurnNorteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:47:43'!
changeCardinal

	^'O'! !

!TurnNorteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:47:39'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !


!classDefinition: #TurnNorteRight category: 'Mars Rover'!
CardinalNorteActions subclass: #TurnNorteRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnNorteRight class' category: 'Mars Rover'!
TurnNorteRight class
	instanceVariableNames: ''!

!TurnNorteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:47:34'!
canHandle: aCommand

	^aCommand = $r.! !

!TurnNorteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:47:31'!
changeCardinal

	^'E'! !

!TurnNorteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:47:28'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !


!classDefinition: #CardinalOesteActions category: 'Mars Rover'!
MarsRoverProcessor subclass: #CardinalOesteActions
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalOesteActions methodsFor: 'executing' stamp: 'LF 12/4/2020 10:34:08'!
executeSpecificCommand
	
	ruleCoordinate := (CardinalOesteActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]ifNone:[^0]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalOesteActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]ifNone:[^0]) changeCardinal.
	! !


!CardinalOesteActions methodsFor: 'value' stamp: 'LF 12/2/2020 16:06:25'!
ruleCardinal

	^ruleCardinal! !

!CardinalOesteActions methodsFor: 'value' stamp: 'LF 12/2/2020 16:06:22'!
ruleCoordinate

	^ruleCoordinate ! !


!CardinalOesteActions methodsFor: 'initialization' stamp: 'MW 12/4/2020 15:41:00'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'O'.
	
	ruleCommand := aSpecificCommand.
	
	self executeSpecificCommand.






! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalOesteActions class' category: 'Mars Rover'!
CardinalOesteActions class
	instanceVariableNames: ''!

!CardinalOesteActions class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:41'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'O'! !

!CardinalOesteActions class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:00:49'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !


!classDefinition: #MoveOesteBackwards category: 'Mars Rover'!
CardinalOesteActions subclass: #MoveOesteBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveOesteBackwards class' category: 'Mars Rover'!
MoveOesteBackwards class
	instanceVariableNames: ''!

!MoveOesteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:46:55'!
canHandle: aCommand

	^aCommand = $b.! !

!MoveOesteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:46:49'!
changeCardinal

	^'O'.! !

!MoveOesteBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:46:45'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate + `1@0`
! !


!classDefinition: #MoveOesteForward category: 'Mars Rover'!
CardinalOesteActions subclass: #MoveOesteForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveOesteForward class' category: 'Mars Rover'!
MoveOesteForward class
	instanceVariableNames: ''!

!MoveOesteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:47:08'!
canHandle: aCommand

	^aCommand = $f.! !

!MoveOesteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:47:13'!
changeCardinal

	^'O'.! !

!MoveOesteForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:46:40'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate - `1@0`! !


!classDefinition: #TurnOesteLeft category: 'Mars Rover'!
CardinalOesteActions subclass: #TurnOesteLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnOesteLeft class' category: 'Mars Rover'!
TurnOesteLeft class
	instanceVariableNames: ''!

!TurnOesteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:07:30'!
canHandle: aCommand

	^aCommand = $l.! !

!TurnOesteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:07:43'!
changeCardinal

	^'S'! !

!TurnOesteLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:46:32'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !


!classDefinition: #TurnOesteRight category: 'Mars Rover'!
CardinalOesteActions subclass: #TurnOesteRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnOesteRight class' category: 'Mars Rover'!
TurnOesteRight class
	instanceVariableNames: ''!

!TurnOesteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:07:12'!
canHandle: aCommand

	^aCommand = $r.! !

!TurnOesteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:07:03'!
changeCardinal

	^'N'! !

!TurnOesteRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:06:58'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !


!classDefinition: #CardinalSurActions category: 'Mars Rover'!
MarsRoverProcessor subclass: #CardinalSurActions
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalSurActions methodsFor: 'executing' stamp: 'LF 12/4/2020 10:34:15'!
executeSpecificCommand

	ruleCoordinate := (CardinalSurActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]ifNone:[^0]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalSurActions allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]ifNone:[^0]) changeCardinal.
	! !


!CardinalSurActions methodsFor: 'initialization' stamp: 'MW 12/4/2020 15:40:42'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'S'.
	
	ruleCommand := aSpecificCommand.
	
	self executeSpecificCommand.






! !


!CardinalSurActions methodsFor: 'value' stamp: 'LF 12/2/2020 16:06:29'!
ruleCardinal

	^ruleCardinal! !

!CardinalSurActions methodsFor: 'value' stamp: 'LF 12/2/2020 16:06:32'!
ruleCoordinate

	^ruleCoordinate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalSurActions class' category: 'Mars Rover'!
CardinalSurActions class
	instanceVariableNames: ''!

!CardinalSurActions class methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 15:08:47'!
canHandle: aCardinalPoint

	^aCardinalPoint = 'S'! !

!CardinalSurActions class methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:00:54'!
withCoordinateOn: aCoordinate executing: aSpecificCommand

	^self new initializeWith: aCoordinate executing: aSpecificCommand! !


!classDefinition: #MoveSurBackwards category: 'Mars Rover'!
CardinalSurActions subclass: #MoveSurBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveSurBackwards class' category: 'Mars Rover'!
MoveSurBackwards class
	instanceVariableNames: ''!

!MoveSurBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:06:45'!
canHandle: aCommand

	^aCommand = $b.! !

!MoveSurBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:06:40'!
changeCardinal

	^'S'.! !

!MoveSurBackwards class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:06:52'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate + `0@1`
! !


!classDefinition: #MoveSurForward category: 'Mars Rover'!
CardinalSurActions subclass: #MoveSurForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveSurForward class' category: 'Mars Rover'!
MoveSurForward class
	instanceVariableNames: ''!

!MoveSurForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:56:01'!
canHandle: aCommand

	^aCommand = $f.! !

!MoveSurForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:06:31'!
changeCardinal

	^'S'.! !

!MoveSurForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:55:54'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate  - `0@1`! !


!classDefinition: #TurnSurLeft category: 'Mars Rover'!
CardinalSurActions subclass: #TurnSurLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnSurLeft class' category: 'Mars Rover'!
TurnSurLeft class
	instanceVariableNames: ''!

!TurnSurLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 12:51:55'!
canHandle: aCommand

	^aCommand = $l.! !

!TurnSurLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 12:47:11'!
changeCardinal

	^'E'! !

!TurnSurLeft class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 12:47:00'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !


!classDefinition: #TurnSurRight category: 'Mars Rover'!
CardinalSurActions subclass: #TurnSurRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnSurRight class' category: 'Mars Rover'!
TurnSurRight class
	instanceVariableNames: ''!

!TurnSurRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:56:21'!
canHandle: aCommand

	^aCommand = $r.! !

!TurnSurRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:56:18'!
changeCardinal

	^'O'! !

!TurnSurRight class methodsFor: 'as yet unclassified' stamp: 'MW 12/4/2020 15:56:14'!
changeCoordinateWith: theRuleCoordinate

	^theRuleCoordinate! !
