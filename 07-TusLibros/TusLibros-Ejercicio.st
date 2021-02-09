!classDefinition: #CartTest category: 'TusLibros-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:26:24'!
test01CartIsEmpty

	| theCart |
	
	theCart := Cart initialize.

	self assert: theCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:28:24'!
test02AddingABookToCartMakesItNotEmpty

	| theCart aBook |
	
	theCart := Cart initialize.
	aBook := Book new.
	
	theCart addToCart: aBook.

	self deny: theCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:41:54'!
test03AddingMultipleBooksToCartMakesItContentIncreases

	| theCart aBook anotherBook |
	
	theCart := Cart initialize.
	aBook := Book new.
	anotherBook := Book new.
	
	theCart addToCart: aBook.
	theCart addToCart: anotherBook .
	
	self assert: (theCart content size isEqualTo: 2). ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 14:08:28'!
test04AddingABookToANotExistingCartWillCreateIt

	| theCart aBook |
	
	aBook := Book new.
	
	theCart := aBook addToNewCart.
	
	self deny: ( theCart = nil ).
	self assert: ( theCart content size = 1 ).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 14:35:02'!
test05CartDetectsIfASpecificBookIsInIt

	| theCart aBook |
	
	aBook := Book titled: 'test'.
	
	theCart := Cart initialize.
	theCart addToCart: aBook.
	
	self assert: ( theCart hasBookTitled: 'test' ).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 15:29:39'!
test06TheCartIsValidBefore30MinutesOfInactivity

	| theCart aBook |
	
	aBook := Book new.
	theCart := Cart initialize.
	
	theCart addToCart: aBook.
	
	self assert: ( theCart isValid ).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 15:45:14'!
test07TheCartIsInvalidAfter30MinutesOfInactivity

	| theCart aBook aTime timeNow|
	
	aBook := Book new.
	theCart := Cart initialize.
	
	theCart addToCart: aBook.
	
	timeNow := Time now.
	
	aTime := Time hour: timeNow hour minute: (timeNow minute) + 35 second: timeNow second.	
	self deny: ( theCart isValidOn: aTime ).
	
	! !


!classDefinition: #Book category: 'TusLibros-Ejercicio'!
Object subclass: #Book
	instanceVariableNames: 'title'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Book methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 14:11:07'!
addToNewCart
	
	| theCart |
	
	theCart := Cart initialize.
	theCart addToCart: self.
	
	^theCart.! !

!Book methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 14:23:04'!
initializeTitled: aBookName

	title := aBookName.! !

!Book methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 14:30:48'!
title

	^title! !

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

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 15:22:28'!
addToCart: aBook 
	
	content add: aBook.
	lastActivityTime := Time now.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:34:47'!
content
	
	^content! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 14:32:07'!
hasBookTitled: aBookTitle 
	
	content detect: [ : aBook | aBook title = aBookTitle ] ifNone:[ ^false ].
	^true.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 15:21:59'!
initializeCart
	
	content := OrderedCollection new.
	lastActivityTime := Time now.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:25:46'!
isEmpty

	^(content size) = 0.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 15:28:31'!
isValid
	
	^(lastActivityTime - Time now) minutes < 30.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/9/2021 15:46:26'!
isValidOn: aTime 

	^( aTime - lastActivityTime ) minutes < 30.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:23:12'!
initialize

	^self new initializeCart.
	! !

Cart initialize!