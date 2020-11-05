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

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 20:00:46'!
checkExecutionTimeUnder: operationToExecute with: milliseconds

	self assert: operationToExecute < (milliseconds * millisecond)
	
		"ver milliseconds, time expected to run o alguna huevada asi, que no solo lo defina un milliseconds"! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/4/2020 15:15:36'!
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

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/4/2020 15:14:49'!
createCustomerBookWithASuspendedCustomer
	
	^(self createCustomerBookWithCustomerNamed: 'Paul McCartney') suspendCustomerNamed: 'Paul McCartney'.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/4/2020 15:15:03'!
createCustomerBookWithCustomerNamed: customersName
	
	^(self createEmptyCustomerBook) addCustomerNamed: customersName.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/4/2020 13:24:23'!
createEmptyCustomerBook

	| customerBook|
	
	customerBook := CustomerBook new.
	
	^customerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 19:44:06'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self checkExecutionTimeUnder: [self countMilliseconds: (self createCustomerBookWithCustomerNamed: 'Paul McCartney')] value 
		with: 50.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 19:42:53'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	self checkExecutionTimeUnder: [self countMilliseconds: ((self createCustomerBookWithCustomerNamed: 'Paul McCartney') 
		removeCustomerNamed: 'Paul McCartney')] value 
			with: 100.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 19:44:24'!
test03CanNotAddACustomerWithEmptyName 

	[ self createCustomerBookWithCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: self createEmptyCustomerBook isEmpty ]
		
		"ver tema de asserts"! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 19:44:39'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook|
			
	customerBook := self createCustomerBookWithCustomerNamed: 'Paul McCartney'.
	
	[customerBook removeCustomerNamed: 'John Lennon'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'Paul McCartney'.]


"invertir beatles"! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 19:45:23'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	
	self checkCustomerBookContent: self createCustomerBookWithASuspendedCustomer 
		with: 0 
			with: 1 
				with: 1 
					with: [self assert: (self createCustomerBookWithASuspendedCustomer  includesCustomerNamed: 'Paul McCartney')].
					
					"resolver semantica, inentendible check customer book content"
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 19:55:49'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self createCustomerBookWithASuspendedCustomer. 
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self checkCustomerBookContent: customerBook value 
		with: 0 
			with: 0 
				with: 0 
					with: [self assert: (customerBook includesCustomerNamed: 'Paul McCartney') not].


	
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

!CustomerBookTest methodsFor: 'tests' stamp: 'LF 11/5/2020 19:45:54'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := self createCustomerBookWithASuspendedCustomer.
		
	[ customerBook suspendCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self checkIfCustomerIsOnTheCustomerBook: customerBook with: 'Paul McCartney'.]
		
		"el suspended, pasar que beatle se crea y se suspende"
! !


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

!CustomerBook methodsFor: 'customer management' stamp: 'LF 11/5/2020 19:47:58'!
removeCustomerIn: theCollection with: aName 

	1 to: theCollection size do: 	
	[ :index |
		aName = (theCollection at: index)
			ifTrue: [
				theCollection removeAt: index.
				^ aName 
			]
			ifFalse:[
				^ NotFound signal
			]
	].
	
	"ver propiedades de colecciones"
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MW 11/4/2020 16:10:16'!
removeCustomerNamed: aName 
	
	self removeCustomerIn: active with: aName.
	self removeCustomerIn: suspended with: aName.
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'LF 11/5/2020 19:50:42'!
numberOfActiveCustomers
	
	^active size
	
	
	"existe implementacion?"! !

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
