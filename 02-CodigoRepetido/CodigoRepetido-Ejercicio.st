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

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:46:55'!
checkCustomerBookContent: customerBook with: firstValue with: secondVaule with: thirdValue with: extraCondition

	self assert: firstValue equals: customerBook numberOfActiveCustomers.
	self assert: secondVaule equals:  customerBook numberOfSuspendedCustomers.
	self assert: thirdValue equals:  customerBook numberOfCustomers.
	
	extraCondition.
	

	

	
	
	
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:31:47'!
checkExecutionTimeUnder: operationToExecute with: milliseconds

	self assert: operationToExecute < (milliseconds * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:41:06'!
checkIfCustomerIsOnTheCustomerBook: customerBook with: customerName
			
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: customerName) 
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:21:28'!
countMilliseconds: condition

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	condition.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:35:47'!
createCustomerBookWithASuspendedCustomer

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	^customerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:45:51'!
createCustomerBookWithCustomerNamed: customersName

	| customerBook customer|
	
	customerBook := CustomerBook new.
	customer := customersName.
	
	customerBook addCustomerNamed: customer.

	
	^customerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:24:23'!
createEmptyCustomerBook

	| customerBook|
	
	customerBook := CustomerBook new.
	
	^customerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:46:24'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self checkExecutionTimeUnder: [self countMilliseconds: (self createCustomerBookWithCustomerNamed: 'Paul McCartney')] value with: 50.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:47:09'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	self checkExecutionTimeUnder: [self countMilliseconds: ((self createCustomerBookWithCustomerNamed: 'Paul McCartney') removeCustomerNamed: 'Paul McCartney')] value with: 100.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:47:41'!
test03CanNotAddACustomerWithEmptyName 

	[ self createCustomerBookWithCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: self createEmptyCustomerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:48:13'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook|
			
	customerBook := self createCustomerBookWithCustomerNamed: 'Paul McCartney'.
	
	[customerBook removeCustomerNamed: 'John Lennon'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'Paul McCartney'.]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:40:20'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	
	self checkCustomerBookContent: self createCustomerBookWithASuspendedCustomer 
		with: 0 
			with: 1 
				with: 1 
					with: [self assert: (self createCustomerBookWithASuspendedCustomer  includesCustomerNamed: 'Paul McCartney')].
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:51:02'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self createCustomerBookWithASuspendedCustomer. 
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self checkCustomerBookContent: customerBook value with: 0 with: 0 with: 0 with: [self deny: (customerBook includesCustomerNamed: 'Paul McCartney')].


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:41:43'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := self createCustomerBookWithASuspendedCustomer.
	
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'Paul McCartney'.]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 14:42:30'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := self createCustomerBookWithASuspendedCustomer.
		
	[ customerBook suspendCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'Paul McCartney'.]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


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
