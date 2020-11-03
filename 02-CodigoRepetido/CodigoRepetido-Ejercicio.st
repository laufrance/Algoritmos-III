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

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/3/2020 16:43:31'!
checkCustomerBookContent: elLibro with: primerValor with: segundoValor with: tercerValor with: condicionExtra

	self assert: primerValor equals: elLibro numberOfActiveCustomers.
	self assert: segundoValor equals: elLibro numberOfSuspendedCustomers.
	self assert: tercerValor equals: elLibro numberOfCustomers.
	
	condicionExtra.
	

	

	
	
	
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/2/2020 21:08:45'!
contarMilisegundos: condicionAEvaluar

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	condicionAEvaluar.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/2/2020 21:27:40'!
crearLibroConUnClienteSuspendido

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	^customerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/2/2020 21:12:06'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| condicion customerBook |
	
	customerBook := CustomerBook new.
	condicion := [customerBook addCustomerNamed: 'John Lennon'] value.
	
	self assert: (self contarMilisegundos: condicion) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/2/2020 21:16:29'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| condicion customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	
	condicion := [paulMcCartney := 'Paul McCartney'. customerBook addCustomerNamed: paulMcCartney. 
		customerBook removeCustomerNamed: paulMcCartney.] value.
	
	self assert: (self contarMilisegundos: condicion) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'HAW 8/28/2017 08:57:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/3/2020 16:44:58'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := self crearLibroConUnClienteSuspendido.
	
	self checkCustomerBookContent: customerBook with: 0 with: 1 with: 1 with: [self assert: (customerBook includesCustomerNamed: 'Paul McCartney')].
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MW 11/3/2020 16:45:17'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self crearLibroConUnClienteSuspendido.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self checkCustomerBookContent: customerBook with: 0 with: 0 with: 0 with: [self deny: (customerBook includesCustomerNamed: 'Paul McCartney')].


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NR 4/30/2020 09:08:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
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
