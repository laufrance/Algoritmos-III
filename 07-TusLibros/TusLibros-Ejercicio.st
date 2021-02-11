!classDefinition: #CartTest category: 'TusLibros-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:10:20'!
test01CartIsEmpty

	| theCart |
	
	theCart := Cart initialize.

	self assert: theCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'MW 2/11/2021 11:56:38'!
test02AddingABookToCartMakesItNotEmpty

	| shoppingSystem theCart aBook |
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	theCart := Cart initialize.
	
	aBook := '1234567890'.
	
	shoppingSystem add: aBook toCart: theCart.

	self deny: theCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'MW 2/11/2021 11:56:25'!
test03AddingMultipleBooksToCartMakesItsContentIncreases

	| theCart aBook anotherBook shoppingSystem|
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	theCart := Cart initialize.
	
	aBook := '1234567890'.
	anotherBook := '1234567890'.
	
	shoppingSystem add: aBook toCart: theCart.
	shoppingSystem add: anotherBook toCart: theCart.
	
	self assert: (theCart content size isEqualTo: 2). ! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/11/2021 10:29:53'!
test04AddingABookToANotExistingCartWillCreateIt

	| theCart aBook shoppingSystem|
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	aBook := '1234567890'.
	
	theCart := shoppingSystem addToNewCart: aBook.
	
	self assert: (theCart content size isEqualTo: 1). ! !

!CartTest methodsFor: 'testing' stamp: 'MW 2/11/2021 11:56:33'!
test05AddingAnInvalidBookWontBeAddedToCart
	
	|shoppingSystem theCart aBook |
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	theCart := Cart initialize.
	
	aBook := 'isbnInvalido'.
	
	shoppingSystem add: aBook toCart: theCart.

	self assert: theCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'MW 2/11/2021 11:56:52'!
test06ASpecificBookCanBeIdentifiedInTheCart

	| theCart aBook shoppingSystem |
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	aBook := '1234567890'.
	
	theCart := Cart initialize.
	
	shoppingSystem add: aBook toCart: theCart.
	
	self assert: ( theCart hasSpecificBook: '1234567890' ).! !

!CartTest methodsFor: 'testing' stamp: 'MW 2/11/2021 11:57:18'!
test07TheCartIsValidBefore30MinutesOfInactivity

	| theCart aBook shoppingSystem |
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'. 
	aBook := '1234567890'.
	
	theCart := Cart initialize.
	
	shoppingSystem add: aBook toCart: theCart.
	
	self assert: ( shoppingSystem theCart: theCart isValidIn: Time now ).! !

!CartTest methodsFor: 'testing' stamp: 'MW 2/11/2021 11:57:15'!
test08TheCartIsInvalidAfter30MinutesOfInactivity

	| theCart aBook theTimeAfter35Minutes shoppingSystem |
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	aBook := '1234567890'.
	
	theCart := Cart initialize.
	
	shoppingSystem add: aBook toCart: theCart.
	
	theTimeAfter35Minutes := Time hour: Time now hour minute: (Time now minute) + 35 second: Time now second.	
	
	self deny: ( shoppingSystem theCart: theCart isValidIn: theTimeAfter35Minutes ).
	
	! !


!classDefinition: #TusLibrosSystem category: 'TusLibros-Ejercicio'!
Object subclass: #TusLibrosSystem
	instanceVariableNames: 'isbnLibrary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosSystem methodsFor: 'main protocol' stamp: 'LF 2/11/2021 10:31:28'!
add: aBook toCart: theCart 

	isbnLibrary detect:[:isbnBook | isbnBook = aBook] ifNone:[^nil].
	
	(theCart content) add: aBook.	
	
	theCart setLastActivityTime.! !

!TusLibrosSystem methodsFor: 'main protocol' stamp: 'MW 2/11/2021 11:53:25'!
addToNewCart: aBook
	
	| theCart |
	
	isbnLibrary detect:[:isbnBook | isbnBook = aBook] ifNone:[^nil].
		
	theCart := Cart initialize.
	
	self add: aBook toCart: theCart.
	
	^theCart.! !


!TusLibrosSystem methodsFor: 'initialization' stamp: 'LF 2/10/2021 16:09:55'!
initializeSystemWith:booksIsbn

	isbnLibrary := OrderedCollection new.
	
	isbnLibrary add: booksIsbn.
	
	
	! !


!TusLibrosSystem methodsFor: 'comparing' stamp: 'LF 2/10/2021 15:58:36'!
theCart: aCart isValidIn: aTime 
	
	^(aTime - aCart lastActivityTime) minutes < 30.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystem class' category: 'TusLibros-Ejercicio'!
TusLibrosSystem class
	instanceVariableNames: ''!

!TusLibrosSystem class methodsFor: 'instance creation' stamp: 'LF 2/10/2021 16:09:09'!
initializeWith: booksIsbn
	
	^self new initializeSystemWith: booksIsbn.! !


!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
TusLibrosSystem subclass: #Cart
	instanceVariableNames: 'content lastActivityTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'initialization' stamp: 'LF 2/10/2021 10:30:58'!
initializeCart
	
	content := OrderedCollection new.
	
	lastActivityTime := Time now.! !


!Cart methodsFor: 'accessing' stamp: 'MW 2/8/2021 21:34:47'!
content
	
	^content! !


!Cart methodsFor: 'main protocol' stamp: 'LF 2/11/2021 10:32:15'!
hasSpecificBook: aBookIsbn
	
	content detect: [ : aBook | aBook = aBookIsbn ] ifNone:[ ^false ].
	
	^true.! !

!Cart methodsFor: 'main protocol' stamp: 'LF 2/10/2021 15:58:07'!
lastActivityTime

	^lastActivityTime.! !

!Cart methodsFor: 'main protocol' stamp: 'LF 2/10/2021 14:50:51'!
setLastActivityTime

	lastActivityTime := Time now.! !


!Cart methodsFor: 'comparing' stamp: 'MW 2/8/2021 21:25:46'!
isEmpty

	^(content size) = 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LF 2/10/2021 16:12:46'!
initialize

	^self new initializeCart.
	! !

Cart initialize!