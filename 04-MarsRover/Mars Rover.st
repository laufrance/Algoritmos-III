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

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/2/2020 14:19:32'!
test02MarsRoverIsNotOnInitialPositionAfterExecutingACommand
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'f'.
	
	self deny: (marsRoverVehicle isOn: 0@0 facing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 11:07:56'!
test03MarsRoverIsNotOnInitialPositionAfterExecutingACommandSeries
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'fbrbblfrbfbl'.
	
	self deny: (marsRoverVehicle isOn: 0@0 facing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:55:59'!
test04MarsRoverFailsExecutingAllTheCommandsWhenACommandIsInvalid
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'fbrqbml'.
	
	self deny: ( marsRoverVehicle canExecute: 'fbrqbml' )

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:56:15'!
test05MarsRoverExecuteCorrectlyAllTheCommandsWhenTheCommandsAreValid
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'f'.
	
	self assert: ( marsRoverVehicle canExecute: 'f')

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:26:45'!
test06MarsRoverCanNotInitializeWithAnInvalidCardinalPoint
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'V'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self deny: (marsRoverVehicle canInitializeFacing: 'V').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:32:29'!
test07MarsRoverCanInitializeWithAValidCardinalPoint
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self assert: (marsRoverVehicle canInitializeFacing: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:36:11'!
test08MarsRoverCanNotInitializeInAnInvalidCoordinate

	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self deny: (marsRoverVehicle canInitializeInPosition: 0).

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 16:07:25'!
test09MarsRoverCanInitializeInAnValidCoordinate
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'frb'.
	
	self assert: (marsRoverVehicle canInitializeInPosition: 0@0).

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 16:04:41'!
test10MarsRoverMovesForwardWithTheCommandf
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'f'.
	
	self assert: (marsRoverVehicle movedForwardFrom: 0@0).
	"self deny: (marsRoverVehicle movedBackwards).
	self deny: (marsRoverVehicle turnedLeft).
	self deny: (marsRoverVehicle turnedRight)."

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 16:05:18'!
test11MarsRoverMovesBackwardsWithTheCommandb
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'b'.
	
	self assert: (marsRoverVehicle movedBackwardsFrom: 0@0).
	"self deny: (marsRoverVehicle movedForward).
	self deny: (marsRoverVehicle turnedLeft).
	self deny: (marsRoverVehicle turnedRight)."

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 16:04:47'!
test12MarsRoverTurnsLeftWithTheCommandl
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'l'.
	
	self assert: (marsRoverVehicle turnedLeftFrom: 'N').

	
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 16:02:30'!
test13MarsRoverTurnsRightWithTheCommandr
	
	"Z ; Zero
	O ; One
	M ; Many (or More complex) hasta aca estamos me parece
	B ; Boundary Behaviors (se me ocurre que tenga elementos erroneos probamos con letras y despues un numero)
	I ; Interface definition (definirlo en alguna coordenada que no existe o algun punto cardinal feo (hacer de a un caso, osea primero la coordenada y despues el cardinal)
	E ; Exercise Exceptional behavior ( ni idea)
	S ; Simple Scenarios, Simple Solutions (ni idea tampoco)"
	
	| marsRoverVehicle |
	
	 marsRoverVehicle := MarsRover on: 0@0 facing: 'N'.
	
	marsRoverVehicle executeCommands: 'r'.
	
	self assert: (marsRoverVehicle turnedRightFrom: 'N').

	
	
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


!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:53:25'!
canExecute: aListOfCommands
	
	^('fblr' includesAllOf: aListOfCommands)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:33:38'!
canInitializeFacing: aCardinalPoint

	^'NSOE' includes: (cardinalPoint at: 1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:40:53'!
canInitializeInPosition: aPosition 
	
	^aPosition isPoint.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:24:21'!
executeCommands: aListOfCommands
	
	|theCardinalRule|
	
	('NSOE' includes: (cardinalPoint at: 1)) ifTrue:[
		aListOfCommands size timesRepeat: 
	
		[ theCardinalRule := (MarsRover allSubclasses detect: [: aClass | aClass canHandle: cardinalPoint]).
		
			('fblr' includes: (aListOfCommands at: index)) ifTrue: [theCardinalRule := theCardinalRule withCoordinateOn: `0@0` executing: (aListOfCommands at: index).
		
			coordinate := coordinate + theCardinalRule ruleCoordinate.
			cardinalPoint := theCardinalRule ruleCardinal.
		
			index:= index +1 ].].
	].
	
	
	index := 1.
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:22:55'!
isOn: aCoordinate facing: aCardinalPoint
	
	^(coordinate = aCoordinate) and: [^cardinalPoint = aCardinalPoint].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:59:06'!
movedBackwardsFrom: aCoordinate

	^aCoordinate isNotEqualTo: coordinate.
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 15:57:52'!
movedForwardFrom: aCoordinate
	
	^aCoordinate isNotEqualTo: coordinate.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 16:02:01'!
turnedLeftFrom: aCardinalPoint
	
	^aCardinalPoint isNotEqualTo: cardinalPoint.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 16:03:46'!
turnedRightFrom: aCardinalPoint

	^aCardinalPoint isNotEqualTo: cardinalPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MW 11/30/2020 21:52:52'!
on: aCoordinate facing: aCardinalPoint 
	
	^self new initializeOn: aCoordinate facing: aCardinalPoint.! !


!classDefinition: #CardinalEsteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalEsteRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalEsteRule methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:12:51'!
executeSpecificCommand
	
	ruleCoordinate := (CardinalEsteRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalEsteRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCardinal.
! !

!CardinalEsteRule methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 14:04:48'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'E'.
	
	ruleCommand := aSpecificCommand.
	
	self executeSpecificCommand.






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


!classDefinition: #MoveEsteBackwards category: 'Mars Rover'!
CardinalEsteRule subclass: #MoveEsteBackwards
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
CardinalEsteRule subclass: #MoveEsteForward
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
CardinalEsteRule subclass: #TurnEsteLeft
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
CardinalEsteRule subclass: #TurnEsteRight
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


!classDefinition: #CardinalNorteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalNorteRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalNorteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 11:07:18'!
executeSpecificCommand
	
	ruleCoordinate := (CardinalNorteRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalNorteRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCardinal.! !

!CardinalNorteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:26:24'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'N'.
	
	ruleCommand := aSpecificCommand.
	
	self executeSpecificCommand.






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


!classDefinition: #MoveNorteBackwards category: 'Mars Rover'!
CardinalNorteRule subclass: #MoveNorteBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveNorteBackwards class' category: 'Mars Rover'!
MoveNorteBackwards class
	instanceVariableNames: ''!

!MoveNorteBackwards class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:47:21'!
canHandle: aCommand

^aCommand = $b.! !

!MoveNorteBackwards class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:48:13'!
changeCardinal

^'N'.! !

!MoveNorteBackwards class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:49:31'!
changeCoordinateWith: theRuleCoordinate

^theRuleCoordinate - `0@1`
! !


!classDefinition: #MoveNorteForward category: 'Mars Rover'!
CardinalNorteRule subclass: #MoveNorteForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveNorteForward class' category: 'Mars Rover'!
MoveNorteForward class
	instanceVariableNames: ''!

!MoveNorteForward class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:52:19'!
canHandle: aCommand

^aCommand = $f.! !

!MoveNorteForward class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 11:03:14'!
changeCardinal

^'N'.! !

!MoveNorteForward class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:54:16'!
changeCoordinateWith: theRuleCoordinate

^theRuleCoordinate + `0@1`! !


!classDefinition: #TurnNorteLeft category: 'Mars Rover'!
CardinalNorteRule subclass: #TurnNorteLeft
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
CardinalNorteRule subclass: #TurnNorteRight
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


!classDefinition: #CardinalOesteRule category: 'Mars Rover'!
MarsRover subclass: #CardinalOesteRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalOesteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 11:07:10'!
executeSpecificCommand
	
	ruleCoordinate := (CardinalOesteRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalOesteRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCardinal.
	! !

!CardinalOesteRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:26:42'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'O'.
	
	ruleCommand := aSpecificCommand.
	
		self executeSpecificCommand.






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


!classDefinition: #MoveOesteBackwards category: 'Mars Rover'!
CardinalOesteRule subclass: #MoveOesteBackwards
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
CardinalOesteRule subclass: #MoveOesteForward
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
CardinalOesteRule subclass: #TurnOesteLeft
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
CardinalOesteRule subclass: #TurnOesteRight
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


!classDefinition: #CardinalSurRule category: 'Mars Rover'!
MarsRover subclass: #CardinalSurRule
	instanceVariableNames: 'ruleCoordinate ruleCardinal ruleCommand'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalSurRule methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 11:07:04'!
executeSpecificCommand

	ruleCoordinate := (CardinalSurRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCoordinateWith: ruleCoordinate.	
	ruleCardinal := (CardinalSurRule allSubclasses detect: [:aMovement | aMovement canHandle: ruleCommand]) changeCardinal.
	! !

!CardinalSurRule methodsFor: 'as yet unclassified' stamp: 'LF 12/2/2020 16:26:46'!
initializeWith: aCoordinate executing: aSpecificCommand

	ruleCoordinate  := aCoordinate.

	ruleCardinal  := 'S'.
	
	ruleCommand := aSpecificCommand.
	
		self executeSpecificCommand.






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


!classDefinition: #MoveSurBackwards category: 'Mars Rover'!
CardinalSurRule subclass: #MoveSurBackwards
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
CardinalSurRule subclass: #MoveSurForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveSurForward class' category: 'Mars Rover'!
MoveSurForward class
	instanceVariableNames: ''!

!MoveSurForward class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:52:28'!
canHandle: aCommand

^aCommand = $f.! !

!MoveSurForward class methodsFor: 'as yet unclassified' stamp: 'MW 12/3/2020 13:06:31'!
changeCardinal

	^'S'.! !

!MoveSurForward class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:53:12'!
changeCoordinateWith: theRuleCoordinate

^theRuleCoordinate  - `0@1`! !


!classDefinition: #TurnSurLeft category: 'Mars Rover'!
CardinalSurRule subclass: #TurnSurLeft
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
CardinalSurRule subclass: #TurnSurRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnSurRight class' category: 'Mars Rover'!
TurnSurRight class
	instanceVariableNames: ''!

!TurnSurRight class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:55:06'!
canHandle: aCommand

^aCommand = $r.! !

!TurnSurRight class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 10:56:32'!
changeCardinal

^'O'! !

!TurnSurRight class methodsFor: 'as yet unclassified' stamp: 'LF 12/3/2020 11:04:46'!
changeCoordinateWith: theRuleCoordinate

^theRuleCoordinate! !
