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

!CartTest methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:44:28'!
test04AddingABookToANotExistingCartWillCreateIt

	| theCart aBook |
	
	aBook := Book new.
	
	aBook addToCart.
	
	self assert: (theCart content ). ! !


!classDefinition: #Book category: 'TusLibros-Ejercicio'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!


!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:29:02'!
addToCart: aBook 
	
	content add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:34:47'!
content
	
	^content! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:24:55'!
initializeCart

	content := OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:25:46'!
isEmpty

	^(content size) = 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'MW 2/8/2021 21:23:12'!
initialize

	^self new initializeCart.
	! !

Cart initialize!