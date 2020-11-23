!classDefinition: #CoffeeShopTest category: 'AlgoIII-2020-2C-1Parcial'!
TestCase subclass: #CoffeeShopTest
	instanceVariableNames: 'billGates adaLovelace alanKay salesSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopTest methodsFor: 'setUp/tearDown' stamp: 'LF 11/21/2020 16:42:25'!
setUp

	adaLovelace := CoffeeShopCustomer named: 'Ada Lovelace' ofType: #Gold.
	alanKay := CoffeeShopCustomer named: 'Alan Kay' ofType: #Silver.
	billGates := CoffeeShopCustomer named: 'Bill Gates' ofType: #Normal! !


!CoffeeShopTest methodsFor: 'test objects' stamp: 'LF 11/21/2020 16:50:10'!
combo1
	
 ^#Combo1.
	

	
	! !

!CoffeeShopTest methodsFor: 'test objects' stamp: 'LF 11/21/2020 16:50:17'!
combo2

^#Combo2.
	
	
	! !


!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'LF 11/21/2020 14:43:46'!
checkProductSalesOf: theProduct withQuatityEqualTo: quantityOfProductSold toCustomerNamed: customersName

	| salesToCustomer |
	
	salesToCustomer := salesSystem salesMadeTo: customersName.
	
	self assert: quantityOfProductSold equals: salesToCustomer size.
	self assert: quantityOfProductSold equals: (salesToCustomer count: [ :aProduct | aProduct = theProduct value ])! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'LL 9/22/2020 21:41:51'!
test01ThereAreNoSalesWhenSalesSystemIsCreated

	salesSystem := CoffeeShopSalesSystem new.

	self assert: (salesSystem salesMadeTo: adaLovelace) isEmpty! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'LF 11/21/2020 14:43:46'!
test02CanQuerySalesByCustomer

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	
	self checkProductSalesOf: [self combo1] withQuatityEqualTo: 1 toCustomerNamed: adaLovelace
! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'LF 11/21/2020 14:43:46'!
test03SalesAreDistinguishedByCustomer

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.
	
	self checkProductSalesOf: [self combo1] withQuatityEqualTo: 2 toCustomerNamed: adaLovelace.

	self checkProductSalesOf: [self combo2] withQuatityEqualTo: 1 toCustomerNamed: alanKay.

! !


!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'LL 9/22/2020 21:41:51'!
test04VolumeSoldToCustomerIsZeroWhenCustomerHasNoSaleRegistered

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 0*milliliter equals: volumeSoldToCustomer! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'LL 9/22/2020 21:46:19'!
test05VolumeIs_250_WhenOnlyCombo1WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 250*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'LL 9/22/2020 21:46:07'!
test06VolumeIs_100_WhenOnlyCombo2WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 100*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'LL 9/22/2020 21:46:41'!
test07VolumeSoldToCustomerIsTheSumOfAllSoldProducts

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: (250*milliliter)+(100*milliliter) equals: volumeSoldToCustomer ! !


!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LF 11/21/2020 15:08:37'!
checkIf: theCustomersRewards hasAQuantityOfRewardsEqualTo: theQuantityOfRewards andAppliesOn: theProductToCheckDiscount discountingATotalOf: thePriceOfTheProductWithDiscount

	self assert: theQuantityOfRewards equals: theCustomersRewards quantity.
	self assert: theProductToCheckDiscount value.
	self assert: thePriceOfTheProductWithDiscount value equals: theCustomersRewards price.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LL 9/22/2020 21:48:39'!
test08NoRewardExpectedWhenCustomerHasNotBuyAnything

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem rewardOf: adaLovelace ifNone: [ ^self ].
	
	self failWith: 'No reward expected when customer has not buy anything'! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LF 11/21/2020 15:12:04'!
test09GoldCustomerGetsRewardedWithOneCombo2With50PercentItsPriceWhenRule1Holds

	| adaLovelaceReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].
	
	self checkIf: adaLovelaceReward hasAQuantityOfRewardsEqualTo: 1 andAppliesOn: [adaLovelaceReward isForCombo2] discountingATotalOf: [60*peso].
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LF 11/21/2020 15:11:30'!
test10SilverCustomerGetsRewardedWithOneCombo2With75PercentItsPriceWhenRule1Holds

	| alaKayReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: alanKay of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.

	alaKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].
	
	self checkIf: alaKayReward hasAQuantityOfRewardsEqualTo: 1 andAppliesOn: [alaKayReward isForCombo2] discountingATotalOf: [120*3/4*peso].
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LF 11/21/2020 15:10:35'!
test11NormalCustomerGetsRewardedWithOneCombo2With90PercentItsPriceWhenRule1Holds

	| billGatesReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: billGates of: self combo1.
	salesSystem registerSaleTo: billGates of: self combo2.

	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].
	
	self checkIf: billGatesReward hasAQuantityOfRewardsEqualTo: 1 andAppliesOn: [billGatesReward isForCombo2] discountingATotalOf: [120*9/10*peso].

! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LF 11/21/2020 15:10:07'!
test12GoldCustomerGetsRewardedWithOneCombo1At75PesosWhenRule2Holds

	| adaLovelaceReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].
	
	self checkIf: adaLovelaceReward hasAQuantityOfRewardsEqualTo: 2 andAppliesOn: [adaLovelaceReward isForCombo1] discountingATotalOf: [75*peso].

! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LF 11/21/2020 15:09:27'!
test13SilverCustomerGetsRewardedWithOneCombo1At83PesosWhenRule2Holds

	| alanKayReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: alanKay of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.

	alanKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].

	self checkIf: alanKayReward hasAQuantityOfRewardsEqualTo: 2 andAppliesOn: [alanKayReward isForCombo1] discountingATotalOf: [83*peso].
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'LF 11/21/2020 15:08:51'!
test14NormalCustomerGetsRewardedWithOneCombo1At97PesosWhenRule2Holds

	| billGatesReward |
	
	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: billGates of: self combo1.
	salesSystem registerSaleTo: billGates of: self combo1.
	salesSystem registerSaleTo: billGates of: self combo2.
	
	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].
	
	self checkIf: billGatesReward hasAQuantityOfRewardsEqualTo: 2 andAppliesOn: [billGatesReward isForCombo1] discountingATotalOf: [97*peso] 

! !


!classDefinition: #CoffeeShopCustomer category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopCustomer
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopCustomer methodsFor: 'type' stamp: 'LF 11/21/2020 15:22:41'!
type

	self subclassResponsibility ! !


!CoffeeShopCustomer methodsFor: 'initialization' stamp: 'LF 11/21/2020 19:07:41'!
initializeNamed: aName ofType: aType
	
	self subclassResponsibility ! !


!CoffeeShopCustomer methodsFor: 'printing' stamp: 'LL 9/22/2020 18:57:07'!
printOn: aStream

	aStream
		nextPutAll: 'Customer named ';
		nextPutAll: name! !


!CoffeeShopCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:33:13'!
canHandle: aValue

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopCustomer class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer class
	instanceVariableNames: ''!

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'LF 11/21/2020 16:14:09'!
named: aName ofType: aType
	
	^(CoffeeShopCustomer allSubclasses detect:[:aClass | aClass canHandle: aType]) with: aName! !


!classDefinition: #GoldCustomer category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer subclass: #GoldCustomer
	instanceVariableNames: 'type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!GoldCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:22:24'!
initializeNamed: aName ofType: aType

	name := aName.
	type := #Gold
	! !

!GoldCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/23/2020 13:16:01'!
rewardPriceForCombo1 
	
	^75*peso
	
"Hubiera unificado los rewardPriceForCombo1 y 2 como ""rewardPriceFor: aProduct."" Pero los precios estan mal, los dtos son diferentes entre combos segun la categoria, solo se cumplen en el GoldCustomer que tiene un dto del 0,5 en los dos combos."! !

!GoldCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/23/2020 13:13:37'!
rewardPriceForCombo2 
	
	^120*peso/2! !

!GoldCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:22:47'!
type

	^type! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GoldCustomer class' category: 'AlgoIII-2020-2C-1Parcial'!
GoldCustomer class
	instanceVariableNames: ''!

!GoldCustomer class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:36:25'!
canHandle: aType

	^#Gold=aType! !

!GoldCustomer class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:38:09'!
with: aName

	^self new initializeNamed: aName ofType: #Gold ! !


!classDefinition: #NormalCustomer category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer subclass: #NormalCustomer
	instanceVariableNames: 'type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!NormalCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:42:29'!
initializeNamed: aName ofType: aType

	name := aName.
	type := #Normal
	! !

!NormalCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/23/2020 13:13:19'!
rewardPriceForCombo1. 
	
	^97*peso.! !

!NormalCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/23/2020 13:13:37'!
rewardPriceForCombo2. 
	
	^120*peso*9/10.! !

!NormalCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:42:49'!
type

	^type! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NormalCustomer class' category: 'AlgoIII-2020-2C-1Parcial'!
NormalCustomer class
	instanceVariableNames: ''!

!NormalCustomer class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:39:31'!
canHandle: aType

	^#Normal=aType! !

!NormalCustomer class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:39:51'!
with: aName

	^self new initializeNamed: aName ofType: #Normal ! !


!classDefinition: #SilverCustomer category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopCustomer subclass: #SilverCustomer
	instanceVariableNames: 'type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!SilverCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:42:23'!
initializeNamed: aName ofType: aType

	name := aName.
	type := #Silver
	! !

!SilverCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/23/2020 13:13:56'!
rewardPriceForCombo1.
	
	^83*peso.! !

!SilverCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/23/2020 13:13:37'!
rewardPriceForCombo2.
	
	^120*peso*3/4.! !

!SilverCustomer methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:42:59'!
type

	^type! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SilverCustomer class' category: 'AlgoIII-2020-2C-1Parcial'!
SilverCustomer class
	instanceVariableNames: ''!

!SilverCustomer class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:39:38'!
canHandle: aType

	^#Silver=aType! !

!SilverCustomer class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 15:39:59'!
with: aName

	^self new initializeNamed: aName ofType: #Silver ! !


!classDefinition: #CoffeeShopReward category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopReward
	instanceVariableNames: 'price quantity product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopReward methodsFor: 'accessing' stamp: 'LL 9/20/2020 17:54:42'!
price

	^price! !

!CoffeeShopReward methodsFor: 'accessing' stamp: 'LL 9/21/2020 16:31:13'!
quantity

	^quantity ! !


!CoffeeShopReward methodsFor: 'initialization' stamp: 'LL 9/22/2020 19:08:08'!
initializeOf: aProduct at: aPrice quantity: aQuantity

	product := aProduct.
	price := aPrice.
	quantity := aQuantity
	! !


!CoffeeShopReward methodsFor: 'testing' stamp: 'LL 9/22/2020 19:07:57'!
isForCombo1
	
	^product = #Combo1! !

!CoffeeShopReward methodsFor: 'testing' stamp: 'LL 9/22/2020 19:07:57'!
isForCombo2
	
	^product = #Combo2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopReward class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopReward class
	instanceVariableNames: ''!

!CoffeeShopReward class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 17:53:14'!
of: aComboType at: aPrice quantity: aQuantity

	^self new initializeOf: aComboType at: aPrice quantity: aQuantity
! !


!classDefinition: #CoffeeShopSalesSystem category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #CoffeeShopSalesSystem
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!CoffeeShopSalesSystem methodsFor: 'product volume' stamp: 'LF 11/21/2020 19:39:50'!
volumeOf: aProduct
	
	|aEspecificProduct|
	aEspecificProduct := ProductCatalogue typeOfProduct: aProduct.
	^aEspecificProduct volumeOfProduct.
! !


!CoffeeShopSalesSystem methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:17:34'!
initialize

	sales := Dictionary new! !


!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'LL 9/22/2020 19:06:50'!
registerSaleTo: aCustomer of: aProduct

	| salesToCustomer |

	salesToCustomer := sales at: aCustomer ifAbsentPut: [ OrderedCollection new ].
	salesToCustomer add: aProduct ! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'LL 9/20/2020 17:24:49'!
salesMadeTo: aCustomer

	^sales at: aCustomer ifAbsent: [ #() ]! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'LL 9/22/2020 19:51:19'!
volumeSoldTo: aCustomer

	 ^(self salesMadeTo: aCustomer) sum: [ :aProduct | self volumeOf: aProduct ] ifEmpty: [ 0*milliliter ]! !


!CoffeeShopSalesSystem methodsFor: 'rewarding' stamp: 'LL 9/22/2020 19:53:42'!
rewardOf: aCustomer ifNone: noneBlock 

	| salesToCustomer volumeSoldToCustomer rewardRule |

	salesToCustomer := self salesMadeTo: aCustomer.
	volumeSoldToCustomer := self volumeSoldTo: aCustomer.
	
	rewardRule := RewardRule for: volumeSoldToCustomer ifNone: [^noneBlock value].
	^rewardRule createRewardFor: aCustomer.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopSalesSystem class' category: 'AlgoIII-2020-2C-1Parcial'!
CoffeeShopSalesSystem class
	instanceVariableNames: ''!

!CoffeeShopSalesSystem class methodsFor: 'initialization' stamp: 'LL 9/23/2020 08:50:03'!
initialize

	Smalltalk at: #milliliter put: (BaseUnit named: 'milliliter')! !


!classDefinition: #ProductCatalogue category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #ProductCatalogue
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!ProductCatalogue methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:32:47'!
initializePriced: aPrice ofVolume: aVolume

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProductCatalogue class' category: 'AlgoIII-2020-2C-1Parcial'!
ProductCatalogue class
	instanceVariableNames: ''!

!ProductCatalogue class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:47:00'!
typeOfProduct: aName

	^(ProductCatalogue allSubclasses detect:[:aClass | aClass canHandle: aName]) initialized.
	! !


!classDefinition: #Combo1 category: 'AlgoIII-2020-2C-1Parcial'!
ProductCatalogue subclass: #Combo1
	instanceVariableNames: 'price volume'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo1 methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:46:24'!
initializePriced: aPrice ofVolume: aVolume

	name := #Combo1.
	volume := aVolume.
	price := aPrice.
	

	! !

!Combo1 methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:47:22'!
priceOfProduct

	^price.! !

!Combo1 methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:47:29'!
volumeOfProduct
	
	^volume! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo1 class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo1 class
	instanceVariableNames: ''!

!Combo1 class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 16:22:07'!
canHandle: aName
	
	^aName = #Combo1! !

!Combo1 class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:46:45'!
initialized
	
	^self new initializePriced: 150*peso ofVolume: 250*milliliter
	! !

!Combo1 class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:41:23'!
withName: aName
	
	^self new initializePriced: 150 ofVolume: 250
	! !


!classDefinition: #Combo2 category: 'AlgoIII-2020-2C-1Parcial'!
ProductCatalogue subclass: #Combo2
	instanceVariableNames: 'price volume'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo2 methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:47:59'!
initializePriced: aPrice ofVolume: aVolume

	name := #Combo2.
	volume := aVolume.
	price := aPrice.
	
! !

!Combo2 methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:47:41'!
priceOfProduct

	^price.! !

!Combo2 methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:47:49'!
volumeOfProduct

	^volume! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo2 class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo2 class
	instanceVariableNames: ''!

!Combo2 class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 17:25:11'!
canHandle: aName
	
	^aName = #Combo2! !

!Combo2 class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:48:47'!
initialized
	
	^self new initializePriced: 120*peso ofVolume: 100*milliliter
	! !

!Combo2 class methodsFor: 'as yet unclassified' stamp: 'LF 11/21/2020 19:41:37'!
withName: aName
	
	^self new initializePriced: 120 ofVolume: 100
	! !


!classDefinition: #RewardRule category: 'AlgoIII-2020-2C-1Parcial'!
Object subclass: #RewardRule
	instanceVariableNames: 'product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 19:03:50'!
createRewardFor: aCustomer 
	
	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 10:51:26'!
productQuantity

	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 10:51:33'!
rewardedProduct

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
RewardRule class
	instanceVariableNames: ''!

!RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 
		
	self subclassResponsibility ! !


!RewardRule class methodsFor: 'instance creation' stamp: 'LL 9/22/2020 19:53:42'!
for: volumeSoldToCustomer ifNone: aNoneBlock

	^self subclasses 
		detect: [ :aRuleClass | aRuleClass isFor: volumeSoldToCustomer ] 
		ifFound: [ :aRuleClass | aRuleClass new ]
		ifNone: aNoneBlock ! !


!classDefinition: #Combo1RewardRule category: 'AlgoIII-2020-2C-1Parcial'!
RewardRule subclass: #Combo1RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'LF 11/23/2020 13:13:56'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	price := aCustomer rewardPriceForCombo1.
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 19:54:35'!
productQuantity
	
	^2! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 19:01:41'!
rewardedProduct
	
	^#Combo1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo1RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo1RewardRule class
	instanceVariableNames: ''!

!Combo1RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer > (500*milliliter)! !


!classDefinition: #Combo2RewardRule category: 'AlgoIII-2020-2C-1Parcial'!
RewardRule subclass: #Combo2RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial'!

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'LF 11/23/2020 13:13:37'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	price := aCustomer rewardPriceForCombo2.
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 10:23:07'!
productQuantity

	^1! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'LL 9/22/2020 19:00:28'!
rewardedProduct
	
	^#Combo2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo2RewardRule class' category: 'AlgoIII-2020-2C-1Parcial'!
Combo2RewardRule class
	instanceVariableNames: ''!

!Combo2RewardRule class methodsFor: 'testing' stamp: 'LL 9/22/2020 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer between: 300*milliliter and: 500*milliliter
	! !

CoffeeShopSalesSystem initialize!