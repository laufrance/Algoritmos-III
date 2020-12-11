!classDefinition: #PortfolioTest category: 'ServiciosFinancieros2-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:32'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:38'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio hasAccount: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:45'!
test03PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:51'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:57'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:03'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/7/2020 13:15:29'!
test07PortfolioWithZeroAccountsHasAZeroValueBalance

	| portfolioToAnalize|

	portfolioToAnalize := Portfolio new.
	
	self assert: 0 * peso equals: portfolioToAnalize balance.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/7/2020 13:16:54'!
test08PortfolioWithOneAccountHasTheBalanceValueOfTheAccount

	| portfolioToAnalize accountToAnalize|

	accountToAnalize := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: accountToAnalize .
	
	portfolioToAnalize := Portfolio with: accountToAnalize.
	
	self assert: accountToAnalize balance equals: portfolioToAnalize balance.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/7/2020 13:19:01'!
test09PortfolioWithMoreThanOneAccountHasThatSummatoryOfTheirBalancesAsItsBalance

	| portfolioToAnalize oneAccount anotherAccount|

	oneAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: oneAccount .
	Deposit register: 300 * peso on: anotherAccount .
	
	portfolioToAnalize := Portfolio with: oneAccount with: anotherAccount.
	
	self assert: 400 * peso equals: portfolioToAnalize balance.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/7/2020 13:18:32'!
test10PortfolioWithAccountsAndAnEmptyPortfolioBalanceIsTheSummatoryOfTheirBalances

	| portfolioToAnalize oneAccount anotherAccount anotherPortfolio|

	oneAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: oneAccount .	
	Deposit register: 300 * peso on: anotherAccount .
	
	portfolioToAnalize := Portfolio with: oneAccount with: anotherAccount.
	
	anotherPortfolio := Portfolio new.
	
	portfolioToAnalize add: anotherPortfolio.
	
	self assert: 400 * peso equals: portfolioToAnalize balance.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/7/2020 13:21:53'!
test11PortfolioWithAccountsAndAPortfolioWithAnAccountBalanceIIsTheSummatoryOfTheirBalances

	| portfolioToAnalize oneAccount anotherAccount anotherPortfolio accountForAPorfolio anotherAccountForAPortfolio|

	oneAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	accountForAPorfolio := ReceptiveAccount new.
	anotherAccountForAPortfolio := ReceptiveAccount new.
	Deposit register: 100 * peso on: oneAccount .	
	Deposit register: 300 * peso on: anotherAccount .
	Deposit register: 200 * peso on: accountForAPorfolio .	
	Deposit register: 50 * peso on: anotherAccountForAPortfolio .
	
	portfolioToAnalize := Portfolio with: oneAccount with: anotherAccount.
	
	anotherPortfolio := Portfolio with: accountForAPorfolio with: anotherAccountForAPortfolio.
	
	portfolioToAnalize add: anotherPortfolio.
	
	self assert: 650 * peso equals: portfolioToAnalize balance.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/6/2020 16:51:04'!
test12PortfolioWithAnAccountWithNoTransactionsHasZeroTransactions

	| portfolioToAnalize oneAccount |

	oneAccount := ReceptiveAccount new.

	portfolioToAnalize := Portfolio with: oneAccount.
	

	self assert: 0 equals: portfolioToAnalize transactionsRegistered.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/6/2020 16:50:42'!
test13PortfolioWithAnAccountWithTransactionsHasItsNumberOfTransactions

	| portfolioToAnalize oneAccount |

	oneAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: oneAccount.
	Withdraw register: 50 * peso on: oneAccount.

	portfolioToAnalize := Portfolio with: oneAccount.
	
	self assert: 2 equals: portfolioToAnalize transactionsRegistered.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/6/2020 16:49:49'!
test14PortfolioWithAPortfolioWithAccountsWithTransactionsHasItsNumberOfTransactions

	| anotherPortfolio portfolioToAnalize oneAccount |

	oneAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: oneAccount.
	Withdraw register: 50 * peso on: oneAccount.

	anotherPortfolio := Portfolio with: oneAccount.
	
	portfolioToAnalize := Portfolio with: anotherPortfolio.	
	
	self assert: 2 equals: portfolioToAnalize transactionsRegistered.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LF 12/6/2020 16:53:34'!
test15PortfolioWithAnAccountAndAPortfolioWithAccountsWithTransactionsHasItsNumberOfTransactions

	| anotherPortfolio portfolioToAnalize oneAccount anotherAccount|

	oneAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: oneAccount.
	Deposit register: 50 * peso on: anotherAccount.

	anotherPortfolio := Portfolio with: oneAccount.
	
	portfolioToAnalize := Portfolio with: anotherPortfolio.	
	
	portfolioToAnalize add: anotherAccount .
	
	self assert: 2 equals: portfolioToAnalize transactionsRegistered.
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros2-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:33'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LF 12/4/2020 08:48:59'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:54'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:01'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #ReportTest category: 'ServiciosFinancieros2-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:53:20'!
test01AccountSummaryIsEmptyWhenNoTransactionsWereMade

	| accountToBeReported theReport |
	
	accountToBeReported := ReceptiveAccount new.
	
	theReport := AccountSummary of: accountToBeReported.
	
	self assert: 1 equals: (theReport summary) size.
	self assert: 0 * peso equals: (theReport balance).
	self assert: (theReport summary) includes: 'Balance = 0'.
	
	

	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:55:06'!
test02AccountSummaryContainsADepositWhenADepositWasMade

	| accountToBeReported theReport |
	
	accountToBeReported := ReceptiveAccount new.
	
	Deposit register: 30 * peso on: accountToBeReported.
	
	theReport := AccountSummary of: accountToBeReported.
	
	self assert: 2 equals: (theReport summary) size.
	self assert: 30 * peso equals: (theReport balance).
	self assert: (theReport summary) includes: 'Deposito por 30 pesos'.
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:55:30'!
test03AccountSummaryContainsAWithdrawWhenAWithdrawWasMade

	| accountToBeReported theReport |
	
	accountToBeReported := ReceptiveAccount new.
	
	Deposit register: 60 * peso on: accountToBeReported.
	Withdraw register: 10 * peso on: accountToBeReported.
	
	theReport := AccountSummary of: accountToBeReported.
	
	self assert: 3 equals: (theReport summary) size.
	self assert: 50 * peso equals: (theReport balance).
	self assert: (theReport summary) includes: 'Extraccion por 10 pesos'.
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:57:02'!
test04AccountSummaryContainsATransferWithdrawWhenATransferWithdrawWasMade

	| accountToBeReported anotherAccount theReport |
	
	accountToBeReported := ReceptiveAccount new.
	
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 60 * peso on: accountToBeReported.
	
	TransferTransaction register: 60*peso on: accountToBeReported for: anotherAccount. 
	
	theReport := AccountSummary of: accountToBeReported.
	
	self assert: 3 equals: (theReport summary) size.
	self assert: 0 * peso equals: (theReport balance).
	self assert: (theReport summary) includes: 'Salida por transferencia de 60 pesos'.
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:57:21'!
test05AccountSummaryContainsATransferDepositWhenATransferDepositWasMade

	| accountToBeReported anotherAccount theReport |
	
	accountToBeReported := ReceptiveAccount new.
	
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 60 * peso on: anotherAccount.
	
	TransferTransaction register: 60*peso on: anotherAccount for: accountToBeReported. 
	
	theReport := AccountSummary of: accountToBeReported.
	
	self assert: 2 equals: (theReport summary) size.
	self assert: 60 * peso equals: (theReport balance).
	self assert: (theReport summary) includes: 'Entrada por transferencia de 60 pesos'.! !


!classDefinition: #TransferTransactionTest category: 'ServiciosFinancieros2-Ejercicio'!
TestCase subclass: #TransferTransactionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!TransferTransactionTest methodsFor: 'as yet unclassified' stamp: 'Mirko Wu 12/6/2020 15:04:24'!
test01TransferIncreasesReceptiveAccountBalanceOnTransferValue

	| accountWhoSendsTheDeposit accountWhoRecivesTheDeposit  |
	
	accountWhoSendsTheDeposit := ReceptiveAccount new.
	
	accountWhoRecivesTheDeposit := ReceptiveAccount new.
	
	Deposit register: 100*peso on: accountWhoSendsTheDeposit.
		
	TransferTransaction register: 50 * peso on: accountWhoSendsTheDeposit for: accountWhoRecivesTheDeposit.
	
	self assert: 50 * peso equals: accountWhoRecivesTheDeposit balance.
	
! !

!TransferTransactionTest methodsFor: 'as yet unclassified' stamp: 'LF 12/6/2020 12:29:22'!
test02TransferDecreasesSenderAccountBalanceOnTransferValue

	| accountWhoSendsTheDeposit accountWhoRecivesTheDeposit  |
	
	accountWhoSendsTheDeposit := ReceptiveAccount new.
	
	accountWhoRecivesTheDeposit := ReceptiveAccount new.
	
	Deposit register: 100*peso on: accountWhoSendsTheDeposit.
		
	TransferTransaction register: 50 * peso on: accountWhoSendsTheDeposit for: accountWhoRecivesTheDeposit.
	
	self assert: 50 * peso equals: accountWhoSendsTheDeposit balance.
! !

!TransferTransactionTest methodsFor: 'as yet unclassified' stamp: 'Mirko Wu 12/6/2020 14:58:33'!
test03TransferDepositValueMustBePositive

	| accountWhoSendsTheDeposit accountWhoRecivesTheDeposit transferValue |
	
	accountWhoSendsTheDeposit := ReceptiveAccount new.
	
	accountWhoRecivesTheDeposit := ReceptiveAccount new.
	
	transferValue := 50 * peso.
		
	self assert: transferValue equals: (TransferTransaction register: transferValue on: accountWhoSendsTheDeposit for: accountWhoRecivesTheDeposit) value.! !

!TransferTransactionTest methodsFor: 'as yet unclassified' stamp: 'Mirko Wu 12/6/2020 15:16:24'!
test04TransferWithValueZeroDoesNotChangeTheReciverBalance

	| accountWhoSendsTheDeposit accountWhoRecivesTheDeposit |
	
	accountWhoSendsTheDeposit := ReceptiveAccount new.
	
	accountWhoRecivesTheDeposit := ReceptiveAccount new.
	
	TransferTransaction register: 0 * peso on: accountWhoSendsTheDeposit for: accountWhoRecivesTheDeposit.
	
	self assert: 0 * peso equals: ( accountWhoRecivesTheDeposit balance ).! !

!TransferTransactionTest methodsFor: 'as yet unclassified' stamp: 'Mirko Wu 12/6/2020 15:16:32'!
test05TransferWithValueZeroDoesNotChangeTheSenderBalance

	| accountWhoSendsTheDeposit accountWhoRecivesTheDeposit |
	
	accountWhoSendsTheDeposit := ReceptiveAccount new.
	
	accountWhoRecivesTheDeposit := ReceptiveAccount new.
	
	TransferTransaction register: 0 * peso on: accountWhoSendsTheDeposit for: accountWhoRecivesTheDeposit.
	
	self assert: 0 * peso equals: ( accountWhoSendsTheDeposit  balance ).! !

!TransferTransactionTest methodsFor: 'as yet unclassified' stamp: 'LF 12/7/2020 13:25:01'!
test06TransferDepositValueIsEqualToTheTransferWithdrawValue

	| transferDeposit |
	
	transferDeposit := TransferDeposit for: 100 * peso.
	
	self assert: 100 * peso equals: ( transferDeposit valueWithdrawned ).! !

!TransferTransactionTest methodsFor: 'as yet unclassified' stamp: 'LF 12/7/2020 13:25:36'!
test07TransferWithdrawValueIsEqualToTheTransferDepositValue

	| transferWithdraw |
	
	transferWithdraw := TransferWithdraw for: 100 * peso.
	
	self assert: 100 * peso equals: ( transferWithdraw valueDeposited ).! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros2-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros2-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros2-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'LF 12/6/2020 16:56:08'!
transactionValueWith: aBalance

	^aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:40:06'!
summaryName
	^'Deposito por ', (value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros2-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'LF 12/6/2020 16:56:08'!
transactionValueWith: aBalance

	^aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:40:42'!
summaryName
	
	^'Extraccion por ', (value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros2-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !


!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accessing' stamp: 'LF 12/6/2020 15:51:21'!
balance
	
	
	| balance |
	
	balance := 0.
	
	accounts do: [:anAccount | balance:= balance + anAccount balance].
	
	^balance.
! !

!Portfolio methodsFor: 'accessing' stamp: 'LF 12/6/2020 16:45:24'!
transactionsRegistered
	
	|transactions|
	
	transactions := 0.
	
	accounts do: [:anAccount| transactions := transactions + anAccount transactionsRegistered].
	
	^transactions.! !


!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros2-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros2-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LF 12/6/2020 16:56:08'!
balance
	|balance|
	balance := 0.
	transactions do: [ :aTransaction | balance := aTransaction transactionValueWith: balance.].
	^balance! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LF 12/3/2020 21:34:33'!
register: aTransaction
	
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LF 12/6/2020 16:41:01'!
transactionsRegistered

	^transactions size.
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'MW 12/10/2020 21:20:56'!
transactions
	
	^transactions.
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:38:41'!
summary
	
	|accountSummary|
	accountSummary := OrderedCollection new.
	transactions do: [:aTransaction | accountSummary add: aTransaction summaryName].
	^accountSummary! !


!classDefinition: #Report category: 'ServiciosFinancieros2-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!


!classDefinition: #AccountSummary category: 'ServiciosFinancieros2-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!AccountSummary methodsFor: 'initialization' stamp: 'MW 12/10/2020 21:08:08'!
initializeFor: anAccount 
	
	account := anAccount.
	summary := OrderedCollection new.! !


!AccountSummary methodsFor: 'as yet unclassified' stamp: 'MW 12/10/2020 21:11:51'!
balance
	
	^account balance.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:41:21'!
summary
	
	summary := account summary.
	summary add: 'Balance = ', (self balance) asString.
	
	^summary.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros2-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'MW 12/10/2020 20:52:46'!
of: anAccount 
	
	^self new initializeFor: anAccount.! !


!classDefinition: #TransferTransaction category: 'ServiciosFinancieros2-Ejercicio'!
Object subclass: #TransferTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'ServiciosFinancieros2-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'Mirko Wu 12/6/2020 15:07:22'!
register: anAmountOfMoney on: aSenderAccount for: aReceptiveAccount 
	
	|deposit withdraw|
	
	deposit := TransferDeposit for: anAmountOfMoney.
	
	withdraw := TransferWithdraw for: anAmountOfMoney.
	
	aSenderAccount register: withdraw.
		
	aReceptiveAccount register: deposit.
	
	^deposit
	
	
! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros2-Ejercicio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'LF 12/6/2020 12:16:04'!
initializeFor: aValue 
	
	value := aValue.! !


!TransferDeposit methodsFor: 'value' stamp: 'LF 12/6/2020 16:56:08'!
transactionValueWith: aBalance

	^aBalance + value.! !

!TransferDeposit methodsFor: 'value' stamp: 'LF 12/6/2020 12:25:02'!
value

	^ value! !

!TransferDeposit methodsFor: 'value' stamp: 'LF 12/6/2020 15:25:06'!
valueWithdrawned
	
	^self value. ! !


!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:48:17'!
summaryName
	
	^'Entrada por transferencia de ', (value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros2-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'LF 12/6/2020 12:15:31'!
for: aValue 

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros2-Ejercicio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'LF 12/6/2020 16:56:08'!
transactionValueWith: aBalance

	^aBalance - value.! !

!TransferWithdraw methodsFor: 'value' stamp: 'LF 12/6/2020 12:24:59'!
value

	^ value! !

!TransferWithdraw methodsFor: 'value' stamp: 'LF 12/6/2020 15:24:41'!
valueDeposited
	^value! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'LF 12/6/2020 12:17:36'!
initializeFor: aValue 
	
	value := aValue.! !


!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'LF 12/11/2020 13:46:26'!
summaryName
	
	^'Salida por transferencia de ', (value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros2-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'LF 12/6/2020 12:17:09'!
for: aValue 

	^ self new initializeFor: aValue ! !
