!classDefinition: #CartTest category: 'TusLibros-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTest methodsFor: 'testing' stamp: 'MW 2/8/2021 21:26:24'!
test01CartIsEmpty

	| theCart |
	
	theCart := Cart initialize.

	self assert: theCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 10:18:36'!
test02AddingABookToCartMakesItNotEmpty

	| theCart aBook |
	
	theCart := Cart initialize.
	
	aBook := Book new.
	
	theCart addToCart: aBook.

	self deny: theCart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 10:18:45'!
test03AddingMultipleBooksToCartMakesItsContentIncreases

	| theCart aBook anotherBook |
	
	theCart := Cart initialize.
	
	aBook := Book new.
	
	anotherBook := Book new.
	
	theCart addToCart: aBook.
	
	theCart addToCart: anotherBook .
	
	self assert: (theCart content size isEqualTo: 2). ! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 10:19:31'!
test04AddingABookToANotExistingCartWillCreateIt

	| theCart aBook |
	
	aBook := Book new.
	
	theCart := aBook addToCart.
	
	self deny: ( theCart = nil ).
	
	self assert: ( theCart content size = 1 ).! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 10:19:07'!
test05CartIdentifiesSpecificBookInIt

	| theCart aBook |
	
	aBook := Book titled: 'test'.
	
	theCart := Cart initialize.
	
	theCart addToCart: aBook.
	
	self assert: ( theCart hasBookTitled: 'test' ).! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 10:18:29'!
test06TheCartIsValidBefore30MinutesOfInactivity

	| theCart aBook |
	
	aBook := Book new.
	
	theCart := Cart initialize.
	
	theCart addToCart: aBook.
	
	self assert: ( theCart isValidOn: Time now ).! !

!CartTest methodsFor: 'testing' stamp: 'LF 2/10/2021 10:11:52'!
test07TheCartIsInvalidAfter30MinutesOfInactivity

	| theCart aBook theTimeAfter35Minutes timeNow|
	
	aBook := Book new.
	
	theCart := Cart initialize.
	
	theCart addToCart: aBook.
	
	timeNow := Time now.
	
	theTimeAfter35Minutes := Time hour: timeNow hour minute: (timeNow minute) + 35 second: timeNow second.	
	
	self deny: ( theCart isValidOn: theTimeAfter35Minutes ).
	
	! !


!classDefinition: #Book category: 'TusLibros-Ejercicio'!
Object subclass: #Book
	instanceVariableNames: 'title'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Book methodsFor: 'initialization' stamp: 'LF 2/10/2021 10:29:57'!
initializeTitled: aBookTitle

	title := aBookTitle.! !


!Book methodsFor: 'accessing' stamp: 'MW 2/9/2021 14:30:48'!
title

	^title! !


!Book methodsFor: 'main protocol' stamp: 'LF 2/10/2021 10:19:31'!
addToCart
	
	| theCart |
	
	theCart := Cart initialize.
	
	theCart addToCart: self.
	
	^theCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros-Ejercicio'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 14:22:34'!
titled: aBookTitle

	^self new initializeTitled: aBookTitle.! !


!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
Object subclass: #Cart
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


!Cart methodsFor: 'main protocol' stamp: 'LF 2/10/2021 10:30:26'!
addToCart: aBook 
	
	content add: aBook.
	
	lastActivityTime := Time now.! !

!Cart methodsFor: 'main protocol' stamp: 'LF 2/10/2021 10:30:42'!
hasBookTitled: aBookTitle 
	
	content detect: [ : aBook | aBook title = aBookTitle ] ifNone:[ ^false ].
	
	^true.! !


!Cart methodsFor: 'comparing' stamp: 'MW 2/8/2021 21:25:46'!
isEmpty

	^(content size) = 0.! !

!Cart methodsFor: 'comparing' stamp: 'LF 2/10/2021 10:33:55'!
isValidOn: aTime 

	^( aTime - lastActivityTime ) minutes < 30 * minute.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:23:12'!
initialize

	^self new initializeCart.
	! !

Cart initialize!