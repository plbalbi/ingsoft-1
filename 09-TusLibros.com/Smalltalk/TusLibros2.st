!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'support' stamp: 'PO 6/7/2018 19:38:55'!
costOfItemSellByTheStore
	^10! !

!TusLibrosTest methodsFor: 'support' stamp: 'PO 6/7/2018 18:58:55'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'PB 6/10/2018 16:46:00'!
createInvalidCard
	| invalidExpirationDate |
	invalidExpirationDate _ GregorianMonthOfYear year: 2001 month: 1.
	^TestCard withNumber: 4321 andExpirationDate: invalidExpirationDate andOwner: 'Juancito' andToday: self today! !

!TusLibrosTest methodsFor: 'support' stamp: 'PB 6/10/2018 16:50:50'!
createValidCard
	| validExpirationDate |
	validExpirationDate _ GregorianMonthOfYear year: 2003 month: 1.
	^TestCard withNumber: 1234 andExpirationDate: validExpirationDate andOwner: 'Pepito' andToday: self today! !

!TusLibrosTest methodsFor: 'support' stamp: 'PO 6/7/2018 18:59:05'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!TusLibrosTest methodsFor: 'support' stamp: 'PO 6/7/2018 18:59:14'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'PO 6/7/2018 18:59:27'!
itemSellByTheStore
	
	^ 'validBook'! !


!TusLibrosTest methodsFor: '*DenotativeObject' stamp: 'PB 6/10/2018 16:44:33'!
today
	^GregorianMonthOfYear year: 2002 month: 1.

"	^ FixedGregorianDate
		yearNumber: 2002
		monthNumber: 1
		dayNumber: 10. "! !


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

!CashierTest methodsFor: 'tests' stamp: 'PO 6/7/2018 19:40:30'!
test01CannotCheckoutEmptyCart
	|cart|
	cart := self createCart.
	
	self 
		should: [ cashier checkout: cart. ]  
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

!CashierTest methodsFor: 'tests' stamp: 'PO 6/7/2018 19:40:43'!
test03CashierCalculatesCostCorrectly
	|cart cost |
	cart := self createCart.
	cart add: self itemSellByTheStore.
	cost := cashier calculateCost: cart.
	self assert: cost equals: self costOfItemSellByTheStore.
	
	
	
	

	! !

!CashierTest methodsFor: 'tests' stamp: 'PB 6/10/2018 16:39:35'!
test04CashierCalculatesCostOfManyItemsCart
	| cart cost |
	cart _ self createCart.
	cart
		add: 3
		of: self itemSellByTheStore.
	cost _ cashier calculateCost: cart.
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

!Card methodsFor: 'initialization' stamp: 'PO 6/7/2018 21:00:05'!
isExpired
	^ expirationDate < Date today.! !

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

!TestCard methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 20:44:03'!
initializeToday: anAhoraDate
	today _ anAhoraDate.
	^self! !

!TestCard methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 21:00:05'!
isExpired
	^ expirationDate < today.! !

!TestCard methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 20:43:35'!
withNumber: aNumber andExpirationDate: anExpirationDate andOwner: aName andToday: anAhoraDate
	^(self initializeWith: aNumber andExpirationDate: anExpirationDate  andOwner: aName) initializeToday: anAhoraDate 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestCard class' category: #TusLibros!
TestCard class
	instanceVariableNames: ''!

!TestCard class methodsFor: 'accessing' stamp: 'PO 6/7/2018 20:41:57'!
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


!Cart methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 19:54:43'!
checkoutElementsWith: aCashier 
	items do: [ :item | aCashier checkoutItem: item ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'price priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 19:53:37'!
calculateCost: aCart 
	aCart checkoutElementsWith: self.
	^price! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 19:07:33'!
checkout: aCart 
	aCart isEmpty ifTrue: [self error: self class cannotCheckoutEmptyCartError ]! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 21:00:44'!
checkout: aCart with: aCard
	aCard isExpired ifTrue: [self error: Card expiredCardError ].
	self debit: (self calculateCost: aCart) from: aCard
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 19:56:34'!
checkoutItem: anItem
	price := price + (priceList at: anItem).! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 19:30:11'!
debit: anAmount from: aCard
	 
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 20:02:43'!
withPriceList: aPriceList 
	priceList := aPriceList.
	price := 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'PO 6/7/2018 19:06:21'!
cannotCheckoutEmptyCartError
	^'Cannot checkout an empty cart'! !


!Cashier class methodsFor: 'accessing class hierarchy' stamp: 'PO 6/7/2018 20:01:06'!
withPriceList: aPriceList
	^self new withPriceList: aPriceList.! !
