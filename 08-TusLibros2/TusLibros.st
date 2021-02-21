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

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/12/2021 19:27:28'!
test01AChekcoutWith0ItemsCantBeDone
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.
	
	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.
	
	self deny: (checkoutSystem checkoutWasDoneCorrectly).! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/14/2021 12:27:45'!
test02AChekcoutWith1ItemCanBeDone
	
	|checkoutSystem aCart aCreditCard postnetSystem |
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self assert:(checkoutSystem checkoutWasDoneCorrectly).
	
! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/13/2021 16:34:35'!
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
! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/13/2021 17:08:24'!
test04CantCheckoutWithAnInvalidCreditCardNumber
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 787 withExpirationDate: 122025 of: 'Mirko Wu'.

	self should: 	[checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals:'Credit card number must have 16 characters'.
		self deny: (checkoutSystem checkoutWasDoneCorrectly).
	].! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/13/2021 17:11:21'!
test05CantCheckoutWithAnInvalidCreditCardExpirationDate
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122020 of: 'Mirko Wu'.

	self should: 	[checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals:'Credit card expiration month must be in between 1 and 12 and year cant be in the past'.
		self deny: (checkoutSystem checkoutWasDoneCorrectly).
	].! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/13/2021 17:06:49'!
test06CantCheckoutWithAnInvalidCreditCardOwnerName
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Salvador Felipe Jacinto Dalí y Domenech'.

	self should: 	[checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals:'Credit card owner name must have 30 characters or less'.
		self deny: (checkoutSystem checkoutWasDoneCorrectly).
	].! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/13/2021 14:00:05'!
test07CantCheckoutWithAnBlockedCreditCard
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234511 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self deny: (checkoutSystem checkoutWasDoneCorrectly).! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/13/2021 16:35:28'!
test08CheckoutSystemKnowsTransactionTotalFor1Item
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self assert: (checkoutSystem checkoutWasDoneCorrectly).
	
	self assert: (checkoutSystem checkoutTotalPriceWas: 150*peso).! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/13/2021 16:36:03'!
test09CheckoutSystemKnowsTransactionTotalForMoreThan1Item
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	aCart add: (Dictionary new at: #DEF456 put: 50*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self assert: (checkoutSystem checkoutWasDoneCorrectly).
	
	self assert: (checkoutSystem checkoutTotalPriceWas: 200*peso).! !

!CheckoutSystemTest methodsFor: 'testing' stamp: 'LF 2/18/2021 15:18:14'!
test10CheckoutSystemKnowsTransactionHistorial
	
	|checkoutSystem aCart aCreditCard postnetSystem|
	
	aCart:= self createCart.
	
	aCart add: (Dictionary new at: #ABC123 put: 150*peso).
	
	checkoutSystem := self createCheckoutSystem.
	
	postnetSystem := self createPostnetSystem.
	
	aCreditCard := self createCreditCardNumbered: 1234567891234567 withExpirationDate: 122025 of: 'Mirko Wu'.

	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.
	
	checkoutSystem checkout: aCart with: aCreditCard on: postnetSystem.

	self assert: (checkoutSystem checkoutWasDoneCorrectly).

	self assert: (checkoutSystem checkoutHistorial size isEqualTo: 2).! !


!CheckoutSystemTest methodsFor: 'private' stamp: 'LF 2/13/2021 13:55:29'!
createCart

	| aCatalog |
	
	aCatalog := Set with: (Dictionary new at: #ABC123 put: (150*peso)) with: (Dictionary new at: #DEF456 put: (50*peso)).
	
	^Cart withCatalog: aCatalog.! !

!CheckoutSystemTest methodsFor: 'private' stamp: 'LF 2/11/2021 21:13:33'!
createCheckoutSystem
	
	|checkoutSystem|
	
	checkoutSystem := CheckoutSystem initialize.
	
	^checkoutSystem.! !

!CheckoutSystemTest methodsFor: 'private' stamp: 'LF 2/11/2021 21:44:52'!
createCreditCardNumbered: creditCardNumber withExpirationDate: expirationDate of: theOwner 
	
	|creditCard|
	
	creditCard:= Dictionary new.
	
	creditCard at: #number put: creditCardNumber.
	creditCard at: #expiration put: expirationDate.
	creditCard at: #owner put: theOwner.
	
	^creditCard! !

!CheckoutSystemTest methodsFor: 'private' stamp: 'LF 2/13/2021 13:22:11'!
createPostnetSystem
	
	|postnetSystem blockedCards|
	
	blockedCards:= OrderedCollection with: 1234567891234511.
	
	postnetSystem := FakePostnet initializeWithBlockedCards: blockedCards.
	
	^postnetSystem.! !


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


!Cart methodsFor: 'accessing' stamp: 'LF 2/14/2021 15:18:44'!
contents
	
	^books copy! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LF 2/13/2021 13:58:43'!
valueOfCart

	|value|
	
	value:= 0.
	
	books do:[:eachBookValue| value:= value + eachBookValue].
	
	^value.! !


!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 20:19:45'!
assertIsInCatalog: aBook

	^ (bookCatalog includes: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !

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
	instanceVariableNames: 'checkoutTicket checkoutHistorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutSystem methodsFor: 'initialization' stamp: 'LF 2/14/2021 12:20:19'!
initializeCheckoutSystem

	checkoutTicket := Dictionary new.
	checkoutHistorial := OrderedCollection new.
	checkoutTicket  at: #total put: 0.
	checkoutTicket  at: #status put: 'incorrect'.
	
	
	

! !


!CheckoutSystem methodsFor: 'testing' stamp: 'LF 2/18/2021 15:23:34'!
assertCardNumber: aCreditCard 
	
	((aCreditCard at: #number) asString size = 16)ifFalse:[self error: self class invalidCreditCardNumberLength].
	^true.! !

!CheckoutSystem methodsFor: 'testing' stamp: 'LF 2/18/2021 15:23:49'!
assertExpirationDate: 	aCreditCard 
	
	|month year expirationDate|
	
	expirationDate:= (aCreditCard at: #expiration) asString.
	
	month:= expirationDate copyFrom: 1 to: 2.
	
	year:= expirationDate  copyFrom: 3 to: 6.
	
	(expirationDate size = 6 	
		and:( 0<(month asInteger) and:(month asInteger < 13)) 
			and:( year asInteger >= DateAndTime now yearNumber))
	ifFalse:[self error: self class invalidCreditCardExpirationDate ].
	^true.! !

!CheckoutSystem methodsFor: 'testing' stamp: 'LF 2/18/2021 15:24:03'!
assertIfTheCartIsNotEmpty: aCart 
	
	^(aCart contents) size > 0.! !

!CheckoutSystem methodsFor: 'testing' stamp: 'LF 2/18/2021 15:24:16'!
assertOwnerName: aCreditCard
	
	((aCreditCard at: #owner) size < 31)ifFalse:[self error: self class invalidCreditCardOwnerNameLength].
	^true.
	! !

!CheckoutSystem methodsFor: 'testing' stamp: 'LF 2/18/2021 15:24:35'!
assertValidCreditCardData: aCreditCard

	^(self assertCardNumber: aCreditCard )
	and: (self assertExpirationDate: aCreditCard)
	and: (self assertOwnerName: aCreditCard ).
	
	
	
	! !

!CheckoutSystem methodsFor: 'testing' stamp: 'LF 2/13/2021 14:02:03'!
checkoutTotalPriceWas: aPrice.
	
	^(checkoutTicket at: #total) = aPrice.! !

!CheckoutSystem methodsFor: 'testing' stamp: 'LF 2/13/2021 13:11:20'!
checkoutWasDoneCorrectly
	
	^(checkoutTicket at: #status) = 'correct'.! !


!CheckoutSystem methodsFor: 'main protocol' stamp: 'LF 2/18/2021 15:24:35'!
checkout: aCart with: aCreditCard on: fakePostnet  
	
	((self assertValidCreditCardData: aCreditCard )and: (self assertIfTheCartIsNotEmpty: aCart)) 
	ifTrue:[ fakePostnet executePaymentOf: aCart with: aCreditCard.	
			self updatePaymentInfoOf:aCart with: fakePostnet.].




	

		
	
	
	! !

!CheckoutSystem methodsFor: 'main protocol' stamp: 'LF 2/18/2021 15:32:44'!
updatePaymentInfoOf: aCart with: aFakePostnet 
	
	checkoutTicket at:#status put: (aFakePostnet paymentStatus).
	checkoutTicket at:#total put: (aCart valueOfCart ).
	checkoutHistorial add: aCart valueOfCart.! !


!CheckoutSystem methodsFor: 'accesing' stamp: 'LF 2/14/2021 12:21:07'!
checkoutHistorial
	
	^checkoutHistorial.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutSystem class' category: 'TusLibros'!
CheckoutSystem class
	instanceVariableNames: ''!

!CheckoutSystem class methodsFor: 'error messages' stamp: 'LF 2/13/2021 17:10:38'!
invalidCreditCardExpirationDate

	^'Credit card expiration month must be in between 1 and 12 and year cant be in the past'! !

!CheckoutSystem class methodsFor: 'error messages' stamp: 'LF 2/13/2021 16:48:48'!
invalidCreditCardNumberLength

	^'Credit card number must have 16 characters'! !

!CheckoutSystem class methodsFor: 'error messages' stamp: 'LF 2/13/2021 16:50:14'!
invalidCreditCardOwnerNameLength

	^'Credit card owner name must have 30 characters or less'! !


!CheckoutSystem class methodsFor: 'initialization' stamp: 'LF 2/11/2021 21:20:16'!
initialize

	^self new initializeCheckoutSystem.

! !


!classDefinition: #FakePostnet category: 'TusLibros'!
Object subclass: #FakePostnet
	instanceVariableNames: 'blockedCards paymentStatus'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakePostnet methodsFor: 'initialization' stamp: 'LF 2/13/2021 18:36:40'!
initializePostnetWith: potentialBlockedCards

	blockedCards := potentialBlockedCards.
	paymentStatus  := 'incorrect'.! !


!FakePostnet methodsFor: 'accesing' stamp: 'LF 2/14/2021 15:18:35'!
paymentStatus
	
	^paymentStatus.! !


!FakePostnet methodsFor: 'system primitives' stamp: 'LF 2/13/2021 18:36:22'!
executePaymentOf: aCart with: aCreditCard 

	(blockedCards includes: (aCreditCard at: #number))ifFalse:[paymentStatus := 'correct'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FakePostnet class' category: 'TusLibros'!
FakePostnet class
	instanceVariableNames: ''!

!FakePostnet class methodsFor: 'initialization' stamp: 'LF 2/12/2021 20:14:16'!
initializeWithBlockedCards: blockedCards

	^self new initializePostnetWith: blockedCards.! !

CheckoutSystem initialize!