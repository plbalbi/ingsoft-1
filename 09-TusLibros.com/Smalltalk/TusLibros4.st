!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:41'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:43'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier toCheckout: cart charging: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today registeringOn: OrderedCollection new.
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:45'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:45'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook.
	total := cashier checkOut.
					
	self assert: salesBook notEmpty.
	self assert: salesBook first total = total.! !


!CashierTest methodsFor: 'preparation' stamp: 'HernanWilkinson 6/17/2013 18:11'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #MerchantProcessorTest category: #TusLibros!
TestCase subclass: #MerchantProcessorTest
	instanceVariableNames: 'testObjectsFactory cart salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorTest methodsFor: 'setup' stamp: 'PB 6/13/2018 22:11:07'!
setUp 

	testObjectsFactory _ StoreTestObjectsFactory new.
	cart _ testObjectsFactory createCart.
	salesBook _ OrderedCollection new.! !


!MerchantProcessorTest methodsFor: 'tests' stamp: 'PB 6/13/2018 22:30:52'!
test01MerchantProcessorNotUsedWhenCreditCardExpired
	| merchantProcessor |
	merchantProcessor _ MerchantProcessorMock doing: [ ].
	cart add: testObjectsFactory itemSellByTheStore.
	self
		should: [
			Cashier
				toCheckout: cart
				charging: testObjectsFactory expiredCreditCard
				on: testObjectsFactory today
				registeringOn: salesBook
				with: merchantProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: Cashier canNotChargeAnExpiredCreditCardErrorMessage
				equals: error messageText.
			self deny: merchantProcessor performedDebit ].! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'PB 6/13/2018 22:30:52'!
test02MerchantProcessorFailsAndDoesntChargesWhenCardIsStolen
	| merchantProcessor cashier card |
	card _ testObjectsFactory notExpiredCreditCard.
	merchantProcessor _ MerchantProcessorMock doing: [ self error: MerchantProcessorMock stolenCardErrorMessage ].
	cart add: testObjectsFactory itemSellByTheStore.
	cashier _ Cashier
		toCheckout: cart
		charging: card
		on: testObjectsFactory today
		registeringOn: salesBook
		with: merchantProcessor.
	self
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: MerchantProcessorMock stolenCardErrorMessage
				equals: error messageText.
			self deny: merchantProcessor performedDebit ].! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'PB 6/13/2018 22:30:52'!
test03MerchantProcessorFailsAndDoesntChargesWhenCardHasInsufficientFunds
	| merchantProcessor cashier card |
	card _ testObjectsFactory notExpiredCreditCard.
	merchantProcessor _ MerchantProcessorMock doing: [ self error: MerchantProcessorMock insufficientFundsErrorMessage ].
	cart add: testObjectsFactory itemSellByTheStore.
	cashier _ Cashier
		toCheckout: cart
		charging: card
		on: testObjectsFactory today
		registeringOn: salesBook
		with: merchantProcessor.
	self
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: MerchantProcessorMock insufficientFundsErrorMessage
				equals: error messageText.
			self deny: merchantProcessor performedDebit ].! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'PB 6/13/2018 22:30:52'!
test04MerchantProcessorChargesCorrectly
	| merchantProcessor cashier card |
	card _ testObjectsFactory notExpiredCreditCard.
	merchantProcessor _ MerchantProcessorMock doing: [ ].
	cart add: testObjectsFactory itemSellByTheStore.
	cashier _ Cashier
		toCheckout: cart
		charging: card
		on: testObjectsFactory today
		registeringOn: salesBook
		with: merchantProcessor.
	self
		assert: 10
		equals: cashier checkOut.
	self assert: merchantProcessor performedDebit.! !


!classDefinition: #RestTest category: #TusLibros!
TestCase subclass: #RestTest
	instanceVariableNames: 'testObjectsFactory carts catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestTest methodsFor: 'preparation' stamp: 'PB 6/18/2018 00:21:29'!
setUp
	testObjectsFactory _ StoreTestObjectsFactory new.
	carts _ Dictionary new.
	catalog _ testObjectsFactory defaultCatalog.
! !


!RestTest methodsFor: 'test objects' stamp: 'PO 6/14/2018 21:00:37'!
invalidPassword
	^'4321'! !

!RestTest methodsFor: 'test objects' stamp: 'PO 6/14/2018 20:49:27'!
invalidUser
	^'InvalidUsername'! !

!RestTest methodsFor: 'test objects' stamp: 'PO 6/14/2018 20:56:18'!
validPassword
	^ '1234'.! !

!RestTest methodsFor: 'test objects' stamp: 'PO 6/14/2018 20:56:27'!
validUser
	^ 'PSANCHEZ'.! !


!RestTest methodsFor: 'enviroment' stamp: 'PB 6/18/2018 00:20:39'!
addNewCartWith: aCartId
	carts at: aCartId put: (Cart acceptingItemsOf: catalog).
	! !

!RestTest methodsFor: 'enviroment' stamp: 'PB 6/17/2018 22:53:33'!
getCart: aCartId
	^carts at: aCartId
	! !

!RestTest methodsFor: 'enviroment' stamp: 'PO 6/14/2018 21:32:27'!
hasCartWith: aCartId 
	^carts includesKey: aCartId ! !

!RestTest methodsFor: 'enviroment' stamp: 'PO 6/14/2018 21:06:04'!
isValidUser: anUsername
	^anUsername  = self validUser ! !

!RestTest methodsFor: 'enviroment' stamp: 'PB 6/17/2018 23:05:01'!
isValidWith: anUsername and: aPassword
	^anUsername = self validUser & aPassword = self validPassword ! !

!RestTest methodsFor: 'enviroment' stamp: 'PO 6/14/2018 20:55:42'!
newCartId
	^42! !


!RestTest methodsFor: 'tests' stamp: 'PO 6/14/2018 20:56:27'!
test01CreatesCartWithValidUserAndPassword
	| algo createdCartId timeOfCartCreation |
	algo _ TusLibrosSystem newWithEnvironment: self.
	timeOfCartCreation _ Time now.
	createdCartId _ algo
		createCartFor: self validUser
		with: self validPassword
		at: timeOfCartCreation.
	self assert: (self hasCartWith: createdCartId).! !

!RestTest methodsFor: 'tests' stamp: 'PB 6/17/2018 23:06:56'!
test02CantCreateCartWIthInvalidUser
	| algo createdCartId timeOfCartCreation |
	algo _ TusLibrosSystem newWithEnvironment: self.
	timeOfCartCreation _ Time now.
	self
		should: [
			createdCartId _ algo
				createCartFor: self invalidUser
				with: self validPassword
				at: timeOfCartCreation ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: TusLibrosSystem cannotCreateCartWithInvalidUsernameOrPassword 
				equals: error messageText.
			self deny: (self hasCartWith: createdCartId) ].! !

!RestTest methodsFor: 'tests' stamp: 'PB 6/17/2018 23:05:57'!
test03CantCreateCartWIthValidUserAndInvalidPassword
	| algo createdCartId timeOfCartCreation |
	algo _ TusLibrosSystem newWithEnvironment: self.
	timeOfCartCreation _ Time now.
	self
		should: [
			createdCartId _ algo
				createCartFor: self validUser
				with: self invalidPassword
				at: timeOfCartCreation ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: TusLibrosSystem cannotCreateCartWithInvalidUsernameOrPassword
				equals: error messageText.
			self deny: (self hasCartWith: createdCartId) ].! !

!RestTest methodsFor: 'tests' stamp: 'PB 6/18/2018 00:36:38'!
test04AddToCartAddsACart
	| algo cart |
	algo _ TusLibrosSystem newWithEnvironment: self.
	cart _ testObjectsFactory createCart.
	carts add: 123 -> cart.
	algo
		addToCart: 123
		an: testObjectsFactory itemSellByTheStore
		times: 10.
	self deny: cart isEmpty.! !

!RestTest methodsFor: 'tests' stamp: 'PB 6/18/2018 01:16:22'!
test05CannotAddToCartIfCartDoesNotExist
	| algo |
	algo _ TusLibrosSystem newWithEnvironment: self.
	self
		should: [
			algo
				addToCart: 123
				an: testObjectsFactory itemSellByTheStore
				times: 10 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: TusLibrosSystem invalidCartIdError 
				equals: error messageText ].! !

!RestTest methodsFor: 'tests' stamp: 'PB 6/18/2018 00:47:09'!
test06AllItemInCartCanBeListedCorrectly
	| algo cartWithItems |
	algo _ TusLibrosSystem newWithEnvironment: self.
	cartWithItems _ testObjectsFactory createCartWithItems.
	carts add: 123 -> cartWithItems.
	
	self assert: (cartWithItems listItems) equals: (algo listCart: 123).
	
	! !

!RestTest methodsFor: 'tests' stamp: 'PB 6/18/2018 01:04:58'!
test07WarnWhenListingEmptyCart
	| algo emptyCart |
	algo _ TusLibrosSystem newWithEnvironment: self.
	emptyCart _ testObjectsFactory createCart.
	carts add: 123 -> emptyCart.
	
	self 
		should: [ algo listCart: 123 ]  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: TusLibrosSystem cannotListEmptyCartWarning equals: error messageText.
			]! !

!RestTest methodsFor: 'tests' stamp: 'PB 6/18/2018 01:08:09'!
test08CantListNonExistingCart
	| algo |
	algo _ TusLibrosSystem newWithEnvironment: self.
	
	self 
		should: [ algo listCart: 123 ]  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: TusLibrosSystem invalidCartIdError equals: error messageText.
			]! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:04'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:05'!
itemsDo: aBlock
	
	^items do: aBlock ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'PB 6/18/2018 00:51:18'!
listItems
	^items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'PB 6/13/2018 22:05:24'!
initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook
	
	merchantProcessor _ NoMerchantProcessor new.
	cart := aCart.
	creditCard := aCreditCard.
	salesBook := aSalesBook! !

!Cashier methodsFor: 'initialization' stamp: 'PO 6/11/2018 19:41:18'!
initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook with: aMerchantProcessor 
	cart := aCart.
	creditCard := aCreditCard.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	! !


!Cashier methodsFor: 'billing' stamp: 'PO 6/11/2018 19:40:43'!
checkOut
	
	| priceList total |
	
	priceList := cart catalog.
	total := 0.
	cart itemsDo: [ :anItem | total := total + (priceList at: anItem)].
	
	salesBook add: (Sale of: total).
	
	merchantProcessor debit: total from: creditCard.
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:42'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'PO 6/11/2018 20:26:26'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook with: aMerchantProcessor 
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	^self new initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook with: aMerchantProcessor ! !


!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !


!CreditCard methodsFor: 'expirancy' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'billing' stamp: 'PB 6/13/2018 22:33:05'!
debit: anAmount from: aCreditCard 
	self subclassResponsibility 
	! !

!MerchantProcessor methodsFor: 'billing' stamp: 'PB 6/13/2018 22:33:23'!
performedDebit
	self subclassResponsibility ! !


!classDefinition: #MerchantProcessorMock category: #TusLibros!
MerchantProcessor subclass: #MerchantProcessorMock
	instanceVariableNames: 'actionToPerform debitPerformed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!MerchantProcessorMock commentStamp: '<historical>' prior: 0!
Test oriented merchant processor. Simulates the behaiviour wanted by a closure passed when instanced.!


!MerchantProcessorMock methodsFor: 'billing' stamp: 'PO 6/11/2018 20:21:41'!
debit: anAmount from: aCreditCard 
	actionToPerform value.
	debitPerformed _ true.
	! !

!MerchantProcessorMock methodsFor: 'billing' stamp: 'PO 6/11/2018 20:26:50'!
performedDebit
	^debitPerformed ! !


!MerchantProcessorMock methodsFor: 'initialization' stamp: 'PO 6/11/2018 20:21:53'!
initialize
	debitPerformed _ false.! !

!MerchantProcessorMock methodsFor: 'initialization' stamp: 'PO 6/11/2018 20:24:11'!
initializeWithAction: aDebitAction 
	actionToPerform _ aDebitAction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorMock class' category: #TusLibros!
MerchantProcessorMock class
	instanceVariableNames: 'stolenCards'!

!MerchantProcessorMock class methodsFor: 'errors' stamp: 'PB 6/13/2018 22:18:06'!
insufficientFundsErrorMessage
	^ 'The are no sufficient funds to process this purchase.'.! !

!MerchantProcessorMock class methodsFor: 'errors' stamp: 'PO 6/11/2018 19:54:34'!
stolenCardErrorMessage
	^'Cannot debit from stolen credit card.'! !


!MerchantProcessorMock class methodsFor: 'instance creation' stamp: 'PO 6/11/2018 20:23:50'!
doing: aDebitAction 
	^self new initializeWithAction: aDebitAction.! !


!classDefinition: #NoMerchantProcessor category: #TusLibros!
MerchantProcessor subclass: #NoMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!NoMerchantProcessor commentStamp: '<historical>' prior: 0!
Null Object merchant processor. Used for old tests compatibility, and to represent the absence of a merchant processor.!


!NoMerchantProcessor methodsFor: 'billing' stamp: 'PB 6/13/2018 22:29:53'!
debit: anAmount from: aCreditCard! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'info' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'PB 6/18/2018 00:54:06'!
createCartWithItems
	| cartWithItems |
	
	cartWithItems _ Cart acceptingItemsOf: self defaultCatalog.
	cartWithItems add: 2 of: self itemSellByTheStore.
	cartWithItems add: 5 of: self anotherItemSellByTheStore.
	^cartWithItems ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'PB 6/18/2018 00:55:04'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStore;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'dates' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'credit cards' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit cards' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PB 6/18/2018 00:53:06'!
anotherItemSellByTheStore
	
	^128390! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PB 6/18/2018 00:53:32'!
itemSellByTheStore
	
	^ 23148! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!classDefinition: #TusLibrosSystem category: #TusLibros!
Object subclass: #TusLibrosSystem
	instanceVariableNames: 'environment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'PB 6/18/2018 01:16:38'!
addToCart: aCartId an: anISBN times: aQuantity

	(self getCart: aCartId) add: aQuantity of: anISBN.
		! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'PB 6/17/2018 23:08:43'!
createCartFor: anUsername with: aPassword at: aTime
	| newCartId |
	(environment isValidWith: anUsername and: aPassword) 
	ifFalse: [ 
		self error: self class cannotCreateCartWithInvalidUsernameOrPassword 
		].
	newCartId _ environment newCartId.
	environment addNewCartWith: newCartId.
	^ newCartId 

	! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'PB 6/18/2018 01:14:16'!
getCart: aCartId
	^[ environment getCart: aCartId ] ifError: [self error: self class invalidCartIdError ].! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'PB 6/18/2018 01:14:54'!
listCart: aCartId 
	| itemsList |
	itemsList _ (self getCart: aCartId) listItems.
	(itemsList isEmpty) ifTrue: [self error: self class cannotListEmptyCartWarning].
	^itemsList
	! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'PO 6/14/2018 20:24:39'!
withEnvironment: anEnvironment
	environment _ anEnvironment.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystem class' category: #TusLibros!
TusLibrosSystem class
	instanceVariableNames: ''!

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'PO 6/14/2018 21:56:00'!
cannotAddItemToCartIfDoesNotExist
	^'Cannot add item to cart that does not exist'! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'PO 6/14/2018 20:43:35'!
cannotCreateCartWithInvalidUserMessage
	^'Cannot create cart with invalid username'! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'PB 6/17/2018 23:06:43'!
cannotCreateCartWithInvalidUsernameOrPassword
	^ 'Cannot create cart with invalid username or password'.! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'PO 6/14/2018 20:24:58'!
newWithEnvironment: anEnviroment
	^ self new withEnvironment: anEnviroment.! !


!TusLibrosSystem class methodsFor: 'error messages' stamp: 'PB 6/18/2018 01:02:56'!
cannotListEmptyCartWarning
	^'Cannot list cart without items'! !

!TusLibrosSystem class methodsFor: 'error messages' stamp: 'PB 6/18/2018 01:08:29'!
invalidCartIdError
	^'Invalid cart id provided'! !
