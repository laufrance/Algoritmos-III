!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 12:55:13'!
checkCustomersInCustomerBook: customerBook withArgument: firstDesiredQuantityOfCustomers withArgument: secondDesiredQuantityOfCustomers withArgument: thirdDesiredQuantityOfCustomers withCondition: extraConditionToEvaluate

	self assert: firstDesiredQuantityOfCustomers equals: customerBook numberOfActiveCustomers.
	self assert: secondDesiredQuantityOfCustomers equals:  customerBook numberOfSuspendedCustomers.
	self assert: thirdDesiredQuantityOfCustomers equals:  customerBook numberOfCustomers.
	self assert: extraConditionToEvaluate.

	

	

	
	
	
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 12:51:21'!
checkExecutionTimeUnder: operationTime with: timeExpected

	self assert: operationTime < (timeExpected)
	
		! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/4/2020 15:15:36'!
checkIfCustomerIsOnTheCustomerBook: customerBook with: customerName
			
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: customerName) 
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 12:50:53'!
countExecutionTimeInMilliseconds: operationToExecute

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	
	operationToExecute.
	
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 11:41:57'!
createCustomerBookSuspendingCustomerNamed: customerToSuspend
	
	^(self createCustomerBookWithCustomerNamed: customerToSuspend) suspendCustomerNamed: customerToSuspend.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/4/2020 15:15:03'!
createCustomerBookWithCustomerNamed: customersName
	
	^(self createEmptyCustomerBook) addCustomerNamed: customersName.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:24:23'!
createEmptyCustomerBook

	| customerBook|
	
	customerBook := CustomerBook new.
	
	^customerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 12:50:53'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self checkExecutionTimeUnder: [self countExecutionTimeInMilliseconds: (self createCustomerBookWithCustomerNamed: 'Paul McCartney')] value 
		with: (50 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 12:50:53'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	self checkExecutionTimeUnder: [self countExecutionTimeInMilliseconds: ((self createCustomerBookWithCustomerNamed: 'Paul McCartney') 
		removeCustomerNamed: 'Paul McCartney')] value 
			with: (100 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/6/2020 15:07:45'!
test03CanNotAddACustomerWithEmptyName 

	[ self createCustomerBookWithCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: self createEmptyCustomerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 11:44:46'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook|
			
	customerBook := self createCustomerBookWithCustomerNamed: 'John Lennon'.
	
	[customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'John Lennon'.]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/6/2020 15:08:33'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self createCustomerBookSuspendingCustomerNamed: 'Paul McCartney'. 
	
	self checkCustomersInCustomerBook: (customerBook)
		withArgument: 0 
			withArgument: 1 
				withArgument: 1 
					withCondition: [(customerBook  includesCustomerNamed: 'Paul McCartney')].! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/6/2020 15:08:11'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self createCustomerBookSuspendingCustomerNamed: 'Paul McCartney'. 
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self checkCustomersInCustomerBook: customerBook value 
		withArgument: 0 
			withArgument: 0 
				withArgument: 0 
					withCondition: [(customerBook includesCustomerNamed: 'Paul McCartney') not].! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/6/2020 11:41:57'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := self createCustomerBookSuspendingCustomerNamed: 'Paul McCartney'.
	
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'Paul McCartney'.]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/6/2020 15:08:19'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := self createCustomerBookSuspendingCustomerNamed: 'Paul McCartney'.
		
	[ customerBook suspendCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'Paul McCartney'.]! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'MW 11/4/2020 15:58:40'!
initialize

	active := OrderedCollection new.
	suspended := OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MW 11/6/2020 14:52:00'!
removeCustomerNamed: aName 
	
	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^NotFound signal]].
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'LF 11/6/2020 13:01:20'!
numberOfActiveCustomers
	
	^active size
	! !

!CustomerBook methodsFor: 'accessing' stamp: 'LF 11/6/2020 12:56:50'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'LF 11/6/2020 13:00:51'!
isEmpty
	
	^self numberOfCustomers = 0.! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
