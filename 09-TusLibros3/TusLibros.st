!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'objectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
setUp

	objectsFactory := PublisherTestObjectsFactory new! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:58'!
test01NewCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test02CanAddABookToACart

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:25:18'!
test03CannotAddABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF456'.

	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.
	! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test04CanAddTwoCopiesOfABook

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test05CannotAddNonPositiveNumberOfCopiesOfABook

	| cart |
	cart := self createCart.

	self assert: cart isEmptyAfter: [ cart add: objectsFactory bookFromTheEditorial quantity: -1 ] raisesErrorWithMessage: Cart invalidNumberOfCopiesErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test06CartRemembersAddedBooks

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	cart add: objectsFactory bookFromTheEditorial quantity: 1.
	
	self assert: (cart includes: objectsFactory bookFromTheEditorial).
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 3! !

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

!CartTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:24'!
createCart

	^ objectsFactory anEmptyCart! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'objectsFactory merchantProcessorBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:04'!
setUp

	objectsFactory := PublisherTestObjectsFactory new.
	merchantProcessorBehaviour := [ :anAmountToDebit :aCreditCard |  ]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:40'!
test01CannotCheckoutAnEmptyCart

	| cart salesBook cashier |
	cart := objectsFactory anEmptyCart.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutAnEmptyCart.
			self assert: salesBook isEmpty
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:05'!
test02TotalIsCalculatedCorrectlyAfterCheckout

	| cart ticket cashier |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: objectsFactory bookFromTheEditorialPrice equals: ticket value.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:50'!
test03CannotCheckoutIfCardIsExpired

	| cart cashier merchantProcessorWasContacted salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	merchantProcessorWasContacted := false.
	self merchantProcessorBehaviour: [ :amountToDebit :aCreditCard |  merchantProcessorWasContacted := true ].
	
	self should: [ self cashier: cashier checkout: cart debitingOn: objectsFactory anExpiredCreditCard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutUsingAnExpiredCard.
			self deny: merchantProcessorWasContacted.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 23:04:34'!
test04CheckoutDebitsCreditCardUsingMerchantProcessor

	| cart ticket cashier debitedAmountFromCreditCard debitedCreditCard creditCard |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	creditCard := objectsFactory aValidCreditCard.
		
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | 
		debitedAmountFromCreditCard := anAmountToDebit.
		debitedCreditCard := aCreditCard.
	].
	
	ticket := self cashier: cashier checkout: cart debitingOn: creditCard.
	
	self assert: debitedAmountFromCreditCard equals: ticket value.
	self assert: debitedCreditCard equals: creditCard.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:58'!
test05CheckoutFailsIfMerchantProcessorCantProcessPayment

	| cart cashier salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | Error new signal ].
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: Cashier couldNotProcessPaymentErrorMessage.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:52:03'!
test06CheckingOutACartRegistersASale

	| cart cashier ticket salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.	
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: ticket.! !


!CashierTest methodsFor: 'merchat processor protocol' stamp: 'LL 1/24/2021 18:26:00'!
debit: anAmountToDebit from: aCreditCard

	^merchantProcessorBehaviour value: anAmountToDebit value: aCreditCard! !


!CashierTest methodsFor: 'change mp behaviour' stamp: 'LL 1/24/2021 18:26:00'!
merchantProcessorBehaviour: newBehaviour

	merchantProcessorBehaviour := newBehaviour! !


!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:05'!
cashier: cashier checkout: cart

	^self cashier: cashier checkout: cart debitingOn: objectsFactory aValidCreditCard! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:04'!
cashier: cashier checkout: cart debitingOn: aCreditCard

	^cashier checkout: cart payingWith: aCreditCard through: self merchantProcessorForTest on: objectsFactory now.! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 18:29:57'!
merchantProcessorForTest
	
	^self! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LL 1/24/2021 18:15:23'!
test01CreditCardOwnerNameCannotBeBlank

	^self should: [ CreditCard of: '' number: 11111111 expiringOn: (FixedGregorianDate today) monthOfYear ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: CreditCard nameCannotBeBlankErrorMessage.
		]! !


!classDefinition: #InterfaceTest category: 'TusLibros'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'objectsFactory merchantProcessorBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 20:41:56'!
debit: anAmountToDebit from: aCreditCard

	^merchantProcessorBehaviour value: anAmountToDebit value: aCreditCard! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 20:47:09'!
merchantProcessorBehaviour: newBehaviour

	merchantProcessorBehaviour := newBehaviour! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 20:36:58'!
merchantProcessorForTest
	
	^self! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 17:40:01'!
setUp

	objectsFactory := PublisherTestObjectsFactory new! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 19:36:47'!
test01UserWithAnInvalidIDCantSignUpInTheInterface

	|interface userID userPassword |

	userID:= 'a'.
	
	userPassword:= '*****'.
	
	interface := Interface initializeNewInterface.
	
	self should:[interface signUpUserID: userID withPassword: userPassword]
		raise: Error 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Interface invalidUserIDError.
			self deny: (interface theUserIsRegisteredOnTheDatabase: userID)].	
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 19:36:57'!
test02UserWithValidIDCanSignUpInTheInterface

	|interface userID userPassword |

	userID:= 41395965.
	
	userPassword:= 'todoBitcoin'.
	
	interface := Interface initializeNewInterface.
	
	interface signUpUserID: userID withPassword: userPassword.
	
	self assert: (interface theUserIsRegisteredOnTheDatabase: userID).

	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:05:35'!
test03UserWithAValidIDCanCreateACartInTheInterface

	|interface userID aCartID |
	
	userID:= 41395965.
	
	interface:= 	objectsFactory anInterfaceWithAValidUser.
	
	aCartID := interface createCartFor: userID.
	
	self assert: (interface theUserIsRegisteredOnTheDatabase: userID).
	
	self assert: (aCartID isEqualTo: userID).

	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:06:02'!
test04InterfaceCantAddABookToACartWithAInvalidCartID

	|interface userID aCartID aBook|
	
	userID:= 41395965.
	
	interface:= 	objectsFactory anInterfaceWithAValidUser.
	
	aCartID := interface createCartFor: userID.
	
	aBook := objectsFactory bookFromTheEditorial.

	self should:[	interface addToTheCart: 'invalidID' theBook: aBook aTotalOf: 1.]
		raise: Error 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Interface invalidCartIDError.
			self deny: (interface theBook: aBook wasAddedCorrectlyTo: aCartID)].	
	

	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:09:53'!
test05InterfaceCanAddABookToACartWithAValidCartID

	|interface userID aCartID |
	
	userID:= 41395965.
	
	interface:= 	objectsFactory anInterfaceWithAValidUser.
	
	aCartID := interface createCartFor: userID.
	
	interface addToTheCart: aCartID theBook: objectsFactory bookFromTheEditorial aTotalOf: 1.
		
	self assert: (interface theBook: objectsFactory bookFromTheEditorial wasAddedCorrectlyTo: aCartID).

	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:06:45'!
test06InterfaceCantListTheCartWithAInvalidCartID

	|interface userID aCartID cartContent|
	
	userID:= 41395965.
	
	interface:= 	objectsFactory anInterfaceWithAValidUser.
	
	aCartID := interface createCartFor: userID.
	
	interface addToTheCart: aCartID theBook: objectsFactory bookFromTheEditorial aTotalOf: 1.

	self should:[		cartContent := interface listTheCartWithID: 'invalidID'.]
		raise: Error 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Interface invalidCartIDError.
			self assert: cartContent = nil.].	
	


	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:07:29'!
test07InterfaceCanListTheCartWithAValidCartID

	|interface userID aCartID cartContent|
	
	userID:= 41395965.
	
	interface:= 	objectsFactory anInterfaceWithAValidUser.
		
	aCartID := interface createCartFor: userID.
	
	interface addToTheCart: aCartID theBook: objectsFactory bookFromTheEditorial aTotalOf: 1.
	
	cartContent := interface listTheCartWithID: aCartID.
	
	self assert: (interface theList: cartContent hasALengthOf: 1).

	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:08:26'!
test08InterfaceCanCheckoutCartWithAValidCartID

	|interface userID aCartID cashier debitedAmountFromCreditCard debitedCreditCard|
	
	userID:= 41395965.
	
	interface := objectsFactory anInterfaceWithAValidUser.
	
	aCartID := interface createCartFor: userID.
	
	interface addToTheCart: aCartID theBook: objectsFactory bookFromTheEditorial aTotalOf: 1.
	
	cashier := objectsFactory aCashier.

		self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | 
		debitedAmountFromCreditCard := anAmountToDebit.
		debitedCreditCard := aCreditCard].
	
	interface checkoutCart: aCartID using: objectsFactory aValidCreditCard with: cashier on: self merchantProcessorForTest.
	
	self assert: (interface checkoutWasDoneCorrectlyWith: cashier).

	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:08:54'!
test09InterfaceCantCheckoutCartWithAInvalidCartID
	
	|interface userID aCartID cashier debitedAmountFromCreditCard debitedCreditCard|
	
	userID:= 41395965.
	
	interface := objectsFactory anInterfaceWithAValidUser.
	
	aCartID := interface createCartFor: userID.
	
	interface addToTheCart: aCartID theBook: objectsFactory bookFromTheEditorial aTotalOf: 1.
	
	cashier := objectsFactory aCashier.
	
		self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | 
		debitedAmountFromCreditCard := anAmountToDebit.
		debitedCreditCard := aCreditCard.].

	self should:[		interface checkoutCart: 'invalidCartID' using: objectsFactory aValidCreditCard with: cashier on: self merchantProcessorForTest.]
		raise: Error 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Interface invalidCartIDError.
			self deny: (interface checkoutWasDoneCorrectlyWith: cashier)].	
	
	

	


	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LL 1/25/2021 18:50:24'!
initializeWithCatalog: aBookCatalog
	
	bookCatalog := aBookCatalog.
	books := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:24:07'!
add: aBook
	
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:23:42'!
add: aBook quantity: numberOfBooksToAdd

	self assertIsInCatalog: aBook.
	self assertValidNumberOfCopies: numberOfBooksToAdd.
	
	books add: aBook withOccurrences: numberOfBooksToAdd.! !


!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/24/2021 17:42:15'!
total
	
	^books sum: [ :aBook | bookCatalog at: aBook ].! !


!Cart methodsFor: 'testing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/24/2021 15:49:03'!
assertIsInCatalog: aBook

	^ (bookCatalog includesKey: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 18:15:57'!
books

	^books.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LL 1/25/2021 18:29:34'!
acceptingItemsOf: aBookCatalog
 
	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LL 1/20/2021 21:45:09'!
bookNotInCatalogErrorMessage

	^'Cannot add a book that is not from the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'LL 1/21/2021 21:27:21'!
invalidNumberOfCopiesErrorMessage

	^'Cannot add zero books'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook paymentStatus'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'LF 2/20/2021 21:01:30'!
initializeWithSalesBook: aSalesBook

	salesBook := aSalesBook.
	paymentStatus := false.! !


!Cashier methodsFor: 'checkout' stamp: 'LF 2/20/2021 20:59:16'!
checkout: aCart payingWith: aCreditCard through: aMerchantProcessor on: aCheckoutDateTime  

	| ticket |
	
	paymentStatus:= false.
	
	self assertCanCheckout: aCart using: aCreditCard on: aCheckoutDateTime.
	
	ticket := aCart total.
	
	self debit: ticket value from: aCreditCard using: aMerchantProcessor.
	
	self registerSale: ticket.
	
	paymentStatus := true.
	
	^ticket! !


!Cashier methodsFor: 'assertions' stamp: 'LF 2/20/2021 20:56:09'!
assertCanCheckout: aCart using: aCreditCard on: aDateTime 
	
	self assertContainsBooks: aCart.
	self assertIsNotExpired: aCreditCard on: aDateTime! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/24/2021 17:45:42'!
assertContainsBooks: aCart

	^ aCart isEmpty ifTrue: [	 self error: Cashier cannotCheckoutAnEmptyCart ]! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/25/2021 23:11:12'!
assertIsNotExpired: aCreditCard on: aDateTime 

	^ (aCreditCard isExpiredOn: aDateTime) ifTrue: [ self error: Cashier cannotCheckoutUsingAnExpiredCard ]! !


!Cashier methodsFor: 'private' stamp: 'LL 1/24/2021 18:23:28'!
debit: anAmount from: aCreditCard using: aMerchantProcessor

	^ [ aMerchantProcessor debit: anAmount from: aCreditCard ]
		on: Error - MessageNotUnderstood 
		do: [ :exceptionRaised |
			self error: self class couldNotProcessPaymentErrorMessage.
		]! !

!Cashier methodsFor: 'private' stamp: 'LF 2/20/2021 20:59:45'!
paymentWasDoneCorrectly

	^paymentStatus ! !

!Cashier methodsFor: 'private' stamp: 'LL 1/25/2021 19:50:24'!
registerSale: ticket

	^ salesBook add: ticket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/21/2021 21:50:07'!
cannotCheckoutAnEmptyCart
	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 16:44:06'!
cannotCheckoutUsingAnExpiredCard

	^'Cannot checkout using an expired card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:13:36'!
couldNotProcessPaymentErrorMessage

	^'Cart was rejected'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/25/2021 18:48:59'!
registeringSalesOn: aSalesBook

	^ self new initializeWithSalesBook: aSalesBook.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber owner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'LL 2/16/2021 18:05:42'!
initializeOf: aPerson number: aCreditCardNumber expiringOn: aMonthOfYear 

	owner := aPerson.
	creditCardNumber := aCreditCardNumber.
	expirationDate := aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'LL 2/16/2021 18:05:42'!
isExpiredOn: aDateTime

	^ aDateTime > (expirationDate lastDate)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LL 1/24/2021 18:15:40'!
of: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear

	nameOfTheOwner isEmpty ifTrue: [ self error: self nameCannotBeBlankErrorMessage ].
	
	^self new initializeOf: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear ! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:01:14'!
nameCannotBeBlankErrorMessage

	^'Name cannot be blank'! !


!classDefinition: #Interface category: 'TusLibros'!
Object subclass: #Interface
	instanceVariableNames: 'userDatabase merchantProcessorBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 19:23:47'!
addToTheCart: aCartID theBook: aBook aTotalOf: quantityOfTheBook 
	
	|cart|
	
	cart:= self cartWithID: aCartID.
	
	cart add: aBook quantity: quantityOfTheBook
	
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 18:45:53'!
cartWithID: aCartID

	userDatabase do:[:anUser | (anUser idNumber = aCartID) ifTrue:[^anUser cart]ifFalse:[self error: self class invalidCartIDError]].
! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 20:39:42'!
checkoutCart: aCartID using: aCreditCard with: aCashier on: anInterfaceTest 

	|cart |
	
	cart := self cartWithID: aCartID.
	
	aCashier checkout: cart payingWith: aCreditCard through: anInterfaceTest on: 	GregorianDateTime now.

	
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 20:58:07'!
checkoutWasDoneCorrectlyWith: aCashier 
	
	^aCashier paymentWasDoneCorrectly.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 17:24:26'!
createCartFor: anUserID
	
	|objectsFactory user| 
	
	userDatabase do:[:anUser | (anUser idNumber = anUserID) ifTrue:[ user := anUser]].
	
	objectsFactory:= PublisherTestObjectsFactory new.
	
	user assignCart: (objectsFactory anEmptyCart) withID: (anUserID).
	
	^user cartID.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:57:20'!
initializeInterface

	userDatabase := OrderedCollection new.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 19:24:59'!
listTheCartWithID: aCartID 
	
	|aCart|
	
	aCart := self cartWithID: aCartID.
	
	^aCart books.
	
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 20:27:57'!
merchantProcessorBehaviour: newBehaviour

	merchantProcessorBehaviour := newBehaviour! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 20:27:46'!
merchantProcessorForTest
	
	^self! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:56:59'!
signUpUserID: anUserID withPassword: anUserPassword
	
	|user|
	
	((anUserID isString) or:(anUserID asString size <8))ifTrue:[self error: self class invalidUserIDError].	
	
	user := User initializeWithID: anUserID andPassword:anUserPassword.
	
	userDatabase add: user.
! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 18:06:24'!
theBook: aBook wasAddedCorrectlyTo: aCartID 
	
	|aCart|
	
	aCart := (self userWithID: aCartID) cart.
	
	^aCart includes: aBook.
	
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 18:16:57'!
theList: aListOfProducts hasALengthOf: aPossibleLength 
	
	^aListOfProducts size = aPossibleLength .! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 17:28:35'!
theUserIsRegisteredOnTheDatabase: theUserIDToCheck

	userDatabase do:[:anUser | (anUser idNumber = theUserIDToCheck) ifTrue:[^true]].
	^false.

	
	
! !

!Interface methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 17:49:19'!
userWithID: anUserID

	userDatabase do:[:anUser | (anUser idNumber = anUserID) ifTrue:[^anUser]].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibros'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:15:29'!
initializeNewInterface

	^self new initializeInterface.! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 18:44:50'!
invalidCartIDError

	^'CartID does not match with any Cart from the user'.! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:04:14'!
invalidUserIDError
	^'User ID must be a 8 digit number'.! !


!classDefinition: #PublisherTestObjectsFactory category: 'TusLibros'!
Object subclass: #PublisherTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:41:18'!
aCashier

	| salesBook |
	salesBook := OrderedCollection new.
	^ Cashier registeringSalesOn: salesBook.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:45:08'!
aValidCreditCard

	| nextMonth |
	nextMonth := (FixedGregorianDate today next: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: nextMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/25/2021 18:29:34'!
anEmptyCart

	| aCatalog |
	aCatalog := Dictionary newFromPairs: {self bookFromTheEditorial. self bookFromTheEditorialPrice}.
	^Cart acceptingItemsOf: aCatalog.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:51:21'!
anEmptySalesBook

	^OrderedCollection new.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:43:38'!
anExpiredCreditCard
	
	| lastMonth |
	lastMonth := (FixedGregorianDate today previous: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: lastMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 21:04:04'!
anInterfaceWithAValidUser

	|userID userPassword interface|
	
	userID:= 41395965.
	
	userPassword:= 'todoBitcoin'.
	
	interface := Interface initializeNewInterface.
	
	interface signUpUserID: userID withPassword: userPassword	.
	
	^interface! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 15:59:26'!
bookFromTheEditorial

	^ 'ABC123'! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 17:11:28'!
bookFromTheEditorialPrice

	^ 1000 * peso! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:46:27'!
cartWithABook

	| cart |
	cart := self anEmptyCart.
	cart add: self bookFromTheEditorial.
	^cart! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:48:31'!
now 

	^GregorianDateTime now! !


!classDefinition: #User category: 'TusLibros'!
Object subclass: #User
	instanceVariableNames: 'id password cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!User methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 17:30:08'!
assignCart: anEmptyCart withID: theCartID.

	cart:= anEmptyCart.! !

!User methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:47:25'!
cart

	^cart.! !

!User methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 17:15:47'!
cartID

	^id.! !

!User methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:54:25'!
idNumber

	^id ! !

!User methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:46:10'!
setUpWith: anId and: aPassword.

	id:= anId.
	password:= aPassword.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'User class' category: 'TusLibros'!
User class
	instanceVariableNames: ''!

!User class methodsFor: 'as yet unclassified' stamp: 'LF 2/20/2021 16:45:24'!
initializeWithID: id andPassword: password

	^self new setUpWith: id and: password.! !
