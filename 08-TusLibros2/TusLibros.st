!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:58'!
test01NewCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:38'!
test02CanAddABookToACart

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:25:18'!
test03CannotAddABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF456'.

	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.
	! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:12:27'!
test04CanAddTwoCopiesOfABook

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial quantity: 2.
	
	self assert: (cart quantityOf: self bookFromTheEditorial) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:27:25'!
test05CannotAddNonPositiveNumberOfCopiesOfABook

	| cart |
	cart := self createCart.

	self assert: cart isEmptyAfter: [ cart add: self bookFromTheEditorial quantity: -1 ] raisesErrorWithMessage: Cart invalidNumberOfCopiesErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:39:03'!
test06CartRemembersAddedBooks

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial quantity: 2.
	cart add: self bookFromTheEditorial quantity: 1.
	
	self assert: (cart includes: self bookFromTheEditorial).
	self assert: (cart quantityOf: self bookFromTheEditorial) equals: 3! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:26:35'!
test07CannotAddTwoCopiesOfABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF123'.
	
	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog quantity: 2 ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.! !


!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 21:24:13'!
assert: cart isEmptyAfter: blockExpectedToFail raisesErrorWithMessage: errorMessage
	
	self should: blockExpectedToFail raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: errorMessage.
		self assert: cart isEmpty.
	]! !

!CartTest methodsFor: 'private' stamp: 'LF 2/13/2021 13:26:49'!
bookFromTheEditorial

	^ Dictionary new at: #ABC123 put: 150*peso.! !

!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 20:09:10'!
createCart

	| aCatalog |
	aCatalog := Set with: self bookFromTheEditorial.
	^Cart withCatalog: aCatalog.! !


!classDefinition: #CheckoutSystemTest category: 'TusLibros'!
TestCase subclass: #CheckoutSystemTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:55:29'!
createCart

	| aCatalog |
	
	aCatalog := Set with: (Dictionary new at: #ABC123 put: (150*peso)) with: (Dictionary new at: #DEF456 put: (50*peso)).
	
	^Cart withCatalog: aCatalog.! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/11/2021 21:13:33'!
createCheckoutSystem
	
	|checkoutSystem|
	
	checkoutSystem := CheckoutSystem initialize.
	
	^checkoutSystem.! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/11/2021 21:44:52'!
createCreditCardNumbered: creditCardNumber withExpirationDate: expirationDate of: theOwner 
	
	|creditCard|
	
	creditCard:= Dictionary new.
	
	creditCard at: #number put: creditCardNumber.
	creditCard at: #expiration put: expirationDate.
	creditCard at: #owner put: theOwner.
	
	^creditCard! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:22:11'!
createPostnetSystem
	
	|postnetSystem blockedCards|
	
	blockedCards:= OrderedCollection with: 1234567891234511.
	
	postnetSystem := FakePostnet initializeWithBlockedCards: blockedCards.
	
	^postnetSystem.! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 19:27:28'!
test01AChekcoutWith0ItemsCantBeDone
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.
	
	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.
	
	self deny: (checkoutSystem checkoutWasDoneCorrectly).! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 14:02:38'!
test02AChekcoutWith1ItemCanBeDone
	
	|checkoutSystem aCart aCreditCard postnetSystem |
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self assert:(checkoutSystem checkoutWasDoneCorrectly).
	
	self assert:(checkoutSystem checkoutTotalPriceWas: 150*peso).! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 14:02:58'!
test03AChekcoutWithManyItemsCanBeDone
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	aCart add: (Dictionary new at: #DEF456 put: 50*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self assert:(checkoutSystem checkoutWasDoneCorrectly).
	
	self assert:(checkoutSystem checkoutTotalPriceWas: 200*peso).! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:59:46'!
test04CantCheckoutWithAnInvalidCreditCardNumber
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 787 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self deny: (checkoutSystem checkoutWasDoneCorrectly).! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:59:53'!
test05CantCheckoutWithAnInvalidCreditCardExpirationDate
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122020 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self deny: (checkoutSystem checkoutWasDoneCorrectly).! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:59:59'!
test06CantCheckoutWithAnInvalidCreditCardOwnerName
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Salvador Felipe Jacinto Dalí y Domenech'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self deny: (checkoutSystem checkoutWasDoneCorrectly).! !

!CheckoutSystemTest methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 14:00:05'!
test07CantCheckoutWithAnBlockedCreditCard
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234511 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self deny: (checkoutSystem checkoutWasDoneCorrectly).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LL 1/21/2021 20:26:42'!
initializeWithCatalog: aBookCatalog
	
	bookCatalog := aBookCatalog.
	books := Bag new! !


!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:24:07'!
add: aBook
	
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'LF 2/13/2021 13:49:49'!
add: aBook quantity: numberOfBooksToAdd

	self assertIsInCatalog: aBook.
	self assertValidNumberOfCopies: numberOfBooksToAdd.
	
	books add: aBook withOccurrences: numberOfBooksToAdd.! !


!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 22:11:43'!
contents
	^books copy! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !


!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 20:19:45'!
assertIsInCatalog: aBook

	^ (bookCatalog includes: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:58:43'!
valueOfCart

	|value|
	
	value:= 0.
	
	books do:[:eachBookValue| value:= value + eachBookValue].
	
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LL 1/20/2021 21:37:38'!
withCatalog: aBookCatalog
 
	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LL 1/20/2021 21:45:09'!
bookNotInCatalogErrorMessage

	^'Cannot add a book that is not from the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'LL 1/21/2021 21:27:21'!
invalidNumberOfCopiesErrorMessage

	^'Cannot add zero books'! !


!classDefinition: #CheckoutSystem category: 'TusLibros'!
Object subclass: #CheckoutSystem
	instanceVariableNames: 'checkoutTicket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 19:52:38'!
checkCardNumber: aCreditCard 
	
	^(aCreditCard at: #number) asString size = 16 ! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 19:54:15'!
checkExpirationDate: 	aCreditCard 
	
	|month year expirationDate|
	
	expirationDate:=aCreditCard at: #expiration.
	
	month:='xx'.
	month at: 1 put: (expirationDate asString at: 1).
	month at: 2 put:  (expirationDate asString at: 2).
	
	year:= 'xxxx'.
	year at: 1 put: (expirationDate asString at: 3).
	year at: 2 put: (expirationDate asString at: 4).
	year at: 3 put: (expirationDate asString at: 5).
	year at: 4 put:  (expirationDate asString at: 6).
	
	^(aCreditCard at: #expiration) asString size = 6 
	and:( (0<(month asInteger) and:((month asInteger) < 13)) and:( year asInteger >= DateAndTime now yearNumber)).! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 19:47:41'!
checkIfTheCartIsNotEmpty: aCart 
	
	^(aCart contents) size > 0.! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 19:34:57'!
checkOwnerName: aCreditCard

	^(aCreditCard at: #owner) size < 31.
	! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 19:31:58'!
checkValidCreditCardData: aCreditCard

	^(self checkCardNumber: aCreditCard )
	and: (self checkExpirationDate: aCreditCard)
	and: (self checkOwnerName: aCreditCard ).
	
	
	
	! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:45:05'!
checkout: aCart with: aCreditCard on: fakePostnet  
	
	((self checkValidCreditCardData: aCreditCard )and: (self checkIfTheCartIsNotEmpty: aCart)) ifTrue:[
	checkoutTicket at:#status put: (fakePostnet executePaymentOf: aCart with: aCreditCard).
	checkoutTicket at:#total put: (aCart valueOfCart )]

		
	
	
	! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 14:02:03'!
checkoutTotalPriceWas: aPrice.
	
	^(checkoutTicket at: #total) = aPrice.! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:11:20'!
checkoutWasDoneCorrectly
	
	^(checkoutTicket at: #status) = 'correct'.! !

!CheckoutSystem methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:08:39'!
initializeCheckoutSystem

	checkoutTicket := Dictionary new.
	
	checkoutTicket  at: #total put: 0.
	checkoutTicket  at: #status put: 'incorrect'.
	
	
	

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutSystem class' category: 'TusLibros'!
CheckoutSystem class
	instanceVariableNames: ''!

!CheckoutSystem class methodsFor: 'as yet unclassified' stamp: 'LF 2/11/2021 21:20:16'!
initialize

	^self new initializeCheckoutSystem.

! !


!classDefinition: #FakePostnet category: 'TusLibros'!
Object subclass: #FakePostnet
	instanceVariableNames: 'blockedCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakePostnet methodsFor: 'as yet unclassified' stamp: 'LF 2/13/2021 13:15:47'!
executePaymentOf: aCart with: aCreditCard 

	(blockedCards includes: (aCreditCard at: #number))ifTrue:[^'incorrect'].
	^'correct'.! !

!FakePostnet methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 20:14:28'!
initializePostnetWith: potentialBlockedCards

	blockedCards := potentialBlockedCards .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FakePostnet class' category: 'TusLibros'!
FakePostnet class
	instanceVariableNames: ''!

!FakePostnet class methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 20:23:49'!
executePaymentOf: aCart with: aCreditCard 

	
	! !

!FakePostnet class methodsFor: 'as yet unclassified' stamp: 'LF 2/12/2021 20:14:16'!
initializeWithBlockedCards: blockedCards

	^self new initializePostnetWith: blockedCards.! !

CheckoutSystem initialize!