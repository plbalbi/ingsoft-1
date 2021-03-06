!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PO 6/7/2018 19:38:55'!
costOfItemSellByTheStore
	^10! !

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PO 6/7/2018 18:58:55'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PB 6/10/2018 16:46:00'!
createInvalidCard
	| invalidExpirationDate |
	invalidExpirationDate _ GregorianMonthOfYear year: 2001 month: 1.
	^TestCard withNumber: 4321 andExpirationDate: invalidExpirationDate andOwner: 'Juancito' andToday: self today! !

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PB 6/10/2018 16:50:50'!
createValidCard
	| validExpirationDate |
	validExpirationDate _ GregorianMonthOfYear year: 2003 month: 1.
	^TestCard withNumber: 1234 andExpirationDate: validExpirationDate andOwner: 'Pepito' andToday: self today! !

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PO 6/7/2018 18:59:05'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PO 6/7/2018 18:59:14'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PO 6/7/2018 18:59:27'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTest methodsFor: 'mock entities' stamp: 'PB 6/10/2018 16:56:06'!
today
	^ GregorianMonthOfYear
		year: 2002
		month: 1! !


!classDefinition: #CartTest category: #TusLibros!
TusLibrosTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!classDefinition: #CashierTest category: #TusLibros!
TusLibrosTest subclass: #CashierTest
	instanceVariableNames: 'cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'PB 6/10/2018 16:36:43'!
setUp
	| aPriceList |
	aPriceList _ Dictionary newFrom:
		{self itemSellByTheStore -> 10}.
	cashier _ Cashier withPriceList: aPriceList.! !

!CashierTest methodsFor: 'tests' stamp: 'PB 6/10/2018 17:00:18'!
test01CannotCheckoutEmptyCart
	|cart|
	cart := self createCart.
	
	self 
		should: [ cashier checkout: cart with: self createValidCard. ]  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Cashier cannotCheckoutEmptyCartError equals: error messageText.
			]

	! !

!CashierTest methodsFor: 'tests' stamp: 'PO 6/7/2018 19:40:37'!
test02CanCheckoutCartWithSingleItem
	|cart card|
	cart := self createCart.
	cart add: self itemSellByTheStore.
	card := self createValidCard.
	cashier checkout: cart with: card.
	
	
	
	

	! !

!CashierTest methodsFor: 'tests' stamp: 'PB 6/10/2018 21:35:02'!
test03CashierCalculatesCostCorrectly
	| cart cost |
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	cost _ CostCalculator priceOf: cart with: cashier.
	self
		assert: cost
		equals: self costOfItemSellByTheStore.! !

!CashierTest methodsFor: 'tests' stamp: 'PB 6/10/2018 21:34:48'!
test04CashierCalculatesCostOfManyItemsCart
	| cart cost |
	cart _ self createCart.
	cart add: 3 of: self itemSellByTheStore.
	cost _ CostCalculator priceOf: cart with: cashier.
	self
		assert: self costOfItemSellByTheStore * 3
		equals: cost.! !

!CashierTest methodsFor: 'tests' stamp: 'PO 6/7/2018 20:52:34'!
test05CashierCantCheckoutWithInvalidCard
	|cart card|
	cart := self createCart.
	cart add: self itemSellByTheStore.
	card := self createInvalidCard.
	self should:[cashier checkout: cart with: card.]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[:error |
		self assert: Card expiredCardError equals: error messageText]
	
	
	
	
	

	! !

!CashierTest methodsFor: 'tests' stamp: 'PO 6/11/2018 14:24:10'!
test06CheckoutAddsItemsToHistory
	|cart card|
	cart := self createCart.
	cart add: self itemSellByTheStore.
	card := self createValidCard.
	cashier checkout: cart with: card.
	self 
		assert: (Dictionary newFrom: {self itemSellByTheStore -> 1}) 
		equals:  (cashier historyOf: card).
	
	
	
	

	! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'initialization' stamp: 'PO 6/7/2018 19:21:24'!
initializeWith: aNumber andExpirationDate: aDate andOwner: aName 
	number := aNumber.
	expirationDate := aDate.
	owner := aName! !

!Card methodsFor: 'initialization' stamp: 'PB 6/10/2018 16:57:13'!
isExpired
	^ expirationDate < GregorianMonthOfYear current.! !


!Card methodsFor: 'accessing' stamp: 'PO 6/11/2018 13:47:06'!
number
	^number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'initialization' stamp: 'PO 6/7/2018 19:30:45'!
withNumber: aNumber andExpirationDate: aDate andOwner: aName 
	^self new initializeWith: aNumber andExpirationDate: aDate andOwner: aName! !


!Card class methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 20:58:48'!
expiredCardError
	^'The card has expired'! !


!classDefinition: #TestCard category: #TusLibros!
Card subclass: #TestCard
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestCard methodsFor: 'initialization' stamp: 'PO 6/7/2018 20:44:03'!
initializeToday: anAhoraDate
	today _ anAhoraDate.
	^self! !

!TestCard methodsFor: 'initialization' stamp: 'PO 6/7/2018 21:00:05'!
isExpired
	^ expirationDate < today.! !

!TestCard methodsFor: 'initialization' stamp: 'PO 6/7/2018 20:43:35'!
withNumber: aNumber andExpirationDate: anExpirationDate andOwner: aName andToday: anAhoraDate
	^(self initializeWith: aNumber andExpirationDate: anExpirationDate  andOwner: aName) initializeToday: anAhoraDate 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestCard class' category: #TusLibros!
TestCard class
	instanceVariableNames: ''!

!TestCard class methodsFor: 'instance creation' stamp: 'PO 6/7/2018 20:41:57'!
withNumber: aNumber andExpirationDate: anExpirationDate andOwner: aName andToday: todayDate 
	^self new withNumber: aNumber andExpirationDate: anExpirationDate  andOwner: aName  andToday: todayDate.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'PB 6/10/2018 21:37:09'!
checkoutElementsWith: aPriceCalculator 
	items do: [ :item | aPriceCalculator checkoutItem: item ].! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList history'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'PO 6/11/2018 14:23:27'!
checkout: aCart with: aCard
	aCart isEmpty ifTrue: [ self error: self class cannotCheckoutEmptyCartError ].
	aCard isExpired ifTrue: [ self error: Card expiredCardError ].
	self
		debit: (CostCalculator of: aCart with: self with: aCard number) calculate
		from: aCard.
		
	! !

!Cashier methodsFor: 'checkout' stamp: 'PB 6/10/2018 21:32:48'!
priceOf: anItem 
	^priceList at: anItem.! !


!Cashier methodsFor: 'initialization' stamp: 'PO 6/11/2018 14:20:39'!
initialize
	history _ Dictionary new.! !

!Cashier methodsFor: 'initialization' stamp: 'PO 6/11/2018 13:40:30'!
withPriceList: aPriceList 
	priceList := aPriceList.
	history := Dictionary new.! !


!Cashier methodsFor: 'accessing' stamp: 'PO 6/11/2018 13:46:39'!
historyOf: aCard 
	^history at: aCard number! !


!Cashier methodsFor: 'billing' stamp: 'PO 6/7/2018 19:30:11'!
debit: anAmount from: aCard
	 
	! !

!Cashier methodsFor: 'billing' stamp: 'PO 6/11/2018 14:27:51'!
register: anItem in: aCardNumber
	| currentItems anItemPurchases |
	currentItems _ history at: aCardNumber ifAbsent: [Dictionary new].
	anItemPurchases _ currentItems at: anItem ifAbsent: [0].
	anItemPurchases _ anItemPurchases + 1.
	currentItems add: anItem -> anItemPurchases.
	history add: aCardNumber -> currentItems.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'PO 6/7/2018 19:06:21'!
cannotCheckoutEmptyCartError
	^'Cannot checkout an empty cart'! !


!Cashier class methodsFor: 'instance creation' stamp: 'PO 6/7/2018 20:01:06'!
withPriceList: aPriceList
	^self new withPriceList: aPriceList.! !


!classDefinition: #CostCalculator category: #TusLibros!
Object subclass: #CostCalculator
	instanceVariableNames: 'cart cashier price cardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CostCalculator methodsFor: 'initialization' stamp: 'PB 6/10/2018 21:31:30'!
initialize
	price _ 0.
	^self! !

!CostCalculator methodsFor: 'initialization' stamp: 'PB 6/10/2018 21:29:04'!
initializeOf: aCart with: aCashier 
	cart _ aCart.
	cashier _ aCashier.
	^self! !

!CostCalculator methodsFor: 'initialization' stamp: 'PO 6/11/2018 14:10:40'!
initializeOf: aCart with: aCashier with: aCardNumber
	cart _ aCart.
	cashier _ aCashier.
	cardNumber _ aCardNumber.! !


!CostCalculator methodsFor: 'calculation' stamp: 'PB 6/10/2018 21:31:46'!
calculate
	cart checkoutElementsWith: self.
	^price! !

!CostCalculator methodsFor: 'calculation' stamp: 'PO 6/11/2018 14:15:07'!
checkoutItem: anItem
	price _ price + (cashier priceOf: anItem).
	cashier register: anItem in: cardNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CostCalculator class' category: #TusLibros!
CostCalculator class
	instanceVariableNames: ''!

!CostCalculator class methodsFor: 'instance creation' stamp: 'PB 6/10/2018 21:28:37'!
of: aCart with: aCashier 
	^self new initializeOf: aCart with: aCashier! !

!CostCalculator class methodsFor: 'instance creation' stamp: 'PO 6/11/2018 14:10:20'!
of: aCart with: aCashier with: aCardNumber
	^self new initializeOf: aCart with: aCashier with: aCardNumber! !


!CostCalculator class methodsFor: 'price calculation' stamp: 'PB 6/10/2018 21:33:49'!
priceOf: aCart with: aCashier
	^ (self new
		initializeOf: aCart
		with: aCashier) calculate.! !
