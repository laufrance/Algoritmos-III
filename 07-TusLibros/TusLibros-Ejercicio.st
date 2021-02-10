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

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:11:28'!
test02AddingABookToCartMakesItNotEmpty

	|shoppingSystem theCart aBook |
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	theCart := Cart initialize.
	
	aBook := Book withIsbn: '1234567890'.
	
	shoppingSystem add: aBook toCart: theCart.

	self deny: theCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:11:44'!
test03AddingMultipleBooksToCartMakesItsContentIncreases

	| theCart aBook anotherBook shoppingSystem|
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	theCart := Cart initialize.
	
	aBook := Book withIsbn: '1234567890'.
	
	anotherBook := Book withIsbn: '1234567890'.
	
	shoppingSystem add: aBook toCart: theCart.
	
	shoppingSystem add: anotherBook toCart: theCart.
	
	self assert: (theCart content size isEqualTo: 2). ! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:11:53'!
test04AddingABookToANotExistingCartWillCreateIt

	| theCart aBook shoppingSystem|
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	aBook := Book withIsbn: '1234567890'.
	
	theCart := shoppingSystem addToNewCart: aBook.
	
	self assert: (theCart content size isEqualTo: 1). ! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:12:03'!
test05AddingAnInvalidBookWontBeAddedToCart
	
	|shoppingSystem theCart aBook |
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	theCart := Cart initialize.
	
	aBook := Book withIsbn: 'isbnInvalido'.
	
	shoppingSystem add: aBook toCart: theCart.

	self assert: theCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:12:14'!
test06ASpecificBookCanBeIdentifiedInTheCart

	| theCart aBook shoppingSystem|
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	aBook := Book withIsbn: '1234567890'.
	
	theCart := Cart initialize.
	
	shoppingSystem add: aBook toCart: theCart.
	
	self assert: ( theCart hasSpecificBook: '1234567890' ).! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:12:22'!
test07TheCartIsValidBefore30MinutesOfInactivity

	| theCart aBook shoppingSystem|
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	aBook := Book withIsbn: '1234567890'.
	
	theCart := Cart initialize.
	
	shoppingSystem add: aBook toCart: theCart.
	
	self assert: ( shoppingSystem theCart: theCart isValidIn: Time now ).! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 16:12:35'!
test08TheCartIsInvalidAfter30MinutesOfInactivity

	| theCart aBook theTimeAfter35Minutes shoppingSystem|
	
	shoppingSystem := TusLibrosSystem initializeWith: '1234567890'.
	
	aBook := Book withIsbn: '1234567890'.
	
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

!TusLibrosSystem methodsFor: 'main protocol' stamp: 'LF 2/10/2021 15:43:03'!
add: aBook toCart: theCart 

	isbnLibrary detect:[:isbnBook | isbnBook = aBook isbn] ifNone:[^nil].
	
	(theCart content) add: aBook.	
	
	theCart setLastActivityTime.! !

!TusLibrosSystem methodsFor: 'main protocol' stamp: 'LF 2/10/2021 16:13:14'!
addToNewCart: aBook
	
	| theCart |
	
	isbnLibrary detect:[:isbnBook | isbnBook = aBook isbn] ifNone:[^nil].
		
	theCart := Cart initialize.
	
	self add: aBook toCart: theCart.
	
	theCart setLastActivityTime.
	
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


!classDefinition: #Book category: 'TusLibros-Ejercicio'!
TusLibrosSystem subclass: #Book
	instanceVariableNames: 'title isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Book methodsFor: 'initialization' stamp: 'LF 2/10/2021 14:58:23'!
initializeWithIsbn: aBookIsbn

	isbn := aBookIsbn.
	
	! !


!Book methodsFor: 'accessing' stamp: 'LF 2/10/2021 14:48:09'!
isbn

	^isbn
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros-Ejercicio'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'LF 2/10/2021 14:59:06'!
withIsbn: aBookIsbn

	^self new initializeWithIsbn: aBookIsbn.! !


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


!Cart methodsFor: 'main protocol' stamp: 'LF 2/10/2021 15:38:45'!
hasSpecificBook: aBookIsbn
	
	content detect: [ : aBook | aBook isbn = aBookIsbn ] ifNone:[ ^false ].
	
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