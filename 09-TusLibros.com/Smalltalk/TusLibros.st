!classDefinition: #MarketTest category: #TusLibros!
TestCase subclass: #MarketTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketTest methodsFor: 'tests' stamp: 'PB 6/4/2018 21:18:37'!
test01EmptyCartHasNoElements
	
	|cart|
	
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!MarketTest methodsFor: 'tests' stamp: 'PO 6/6/2018 15:41:54'!
test02BookCanBeAddedToCart
	
	|cart book|
	
	book := Book withName: 'awesome book'.
	
	cart := Cart new.
	cart addBook: book.
	
	self deny: cart isEmpty.
	self assert: (cart contains: book).! !

!MarketTest methodsFor: 'tests' stamp: 'PO 6/6/2018 15:42:56'!
test03SameBookCanBeAddedMultipleTimes
	
	|cart book bookQuantity |
	
	book := Book withName: 'awesome book'.
	bookQuantity := 3.
	
	cart := Cart new.
	bookQuantity timesRepeat: [ cart addBook: book. ].	
	
	self deny: cart isEmpty.
	self assert: (cart contains: book).
	self assert: (cart quantity: book) equals: bookQuantity.! !

!MarketTest methodsFor: 'tests' stamp: 'PO 6/6/2018 15:43:50'!
test04DifferentBooksCanBeAddedToCart
	
	|cart book anotherBook |
	
	book := Book withName: 'awesome book'.
	anotherBook := Book withName: 'another awesome book'.
	
	cart := Cart new.
	cart addBook: book.
	cart addBook: anotherBook .
	
	self deny: cart isEmpty.
	self assert: (cart contains: book).
	self assert: (cart contains: anotherBook).! !

!MarketTest methodsFor: 'tests' stamp: 'PO 6/6/2018 15:44:12'!
test05DifferentBooksCanBeAddedToCartMultipleTimes

	| cart book anotherBook anotherBookQuantity bookQuantity |
	
	book := Book withName: 'awesome book'.
	bookQuantity := 3.
	anotherBook _ Book withName: 'another awesome book'.
	anotherBookQuantity := 5.
	
	cart _ Cart new.
	bookQuantity timesRepeat: [ cart addBook: book. ].
	anotherBookQuantity timesRepeat: [ cart addBook: anotherBook. ].
	
	self deny: cart isEmpty.
	self assert: bookQuantity equals: (cart quantity: book).
	self assert: anotherBookQuantity equals: (cart quantity: anotherBook).
! !

!MarketTest methodsFor: 'tests' stamp: 'PO 6/6/2018 15:44:21'!
test06ABookCanBeRemovedFromCart

	| cart book |
	
	book := Book withName: 'awesome book'.
	
	cart _ Cart new.
	cart addBook: book.
	cart removeBook: book.
	
	self assert: cart isEmpty.! !

!MarketTest methodsFor: 'tests' stamp: 'PO 6/6/2018 15:44:26'!
test07BookCanBeRemovedMultipleTimesFromCart

	| cart book bookQuantity |
	
	book := Book withName: 'awesome book'.
	bookQuantity := 3.
	
	cart _ Cart new.
	bookQuantity timesRepeat: [ cart addBook: book. ].
	bookQuantity timesRepeat: [ cart removeBook: book. ].
	
	self assert: cart isEmpty.! !

!MarketTest methodsFor: 'tests' stamp: 'PB 6/7/2018 08:57:08'!
test08CantRemoveBookThatIsNotInCart

	| cart book |
	
	book := Book withName: 'awesome book'.
	
	cart _ Cart new.
	
	
	
	self 
		should: [ cart removeBook: book. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: cart isEmpty.
			self assert: error messageText equals: Cart cantRemoveBookNotAdded.
			]! !

!MarketTest methodsFor: 'tests' stamp: 'PB 6/7/2018 08:58:00'!
test09NewBookHasName
	| book |
	book _ Book withName: 'awesome book'.
	self
		assert: book name
		equals: 'awesome book'.! !

!MarketTest methodsFor: 'tests' stamp: 'PB 6/7/2018 09:26:31'!
test10BookCannotBeAddedIfNotInCatalog

	| cart book bookNotInCatalog catalog |
	
	book := Book withName: 'awesome book'.
	bookNotInCatalog := Book withName: 'im not in the catalog'.
	catalog := Catalog with: {book}.
	
	cart _ Cart newWithCatalog: catalog.

	self 
		should: [cart addBook: bookNotInCatalog] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Cart errorCannotAddBookNotInCatalog equals: error messageText.
			self assert: cart isEmpty.
			].! !

!MarketTest methodsFor: 'tests' stamp: 'PB 6/7/2018 09:34:16'!
test11BookInCatalogCanBeAdded

	| cart book catalog |
	
	book := Book withName: 'awesome book'.
	catalog := Catalog with: {book}.
	
	cart _ Cart newWithCatalog: catalog.

	cart addBook: book.

	self deny: cart isEmpty.
	self assert: (cart contains: book).! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialization' stamp: 'PO 6/6/2018 15:31:11'!
withName: aName 
	name := aName.! !


!Book methodsFor: 'accessing' stamp: 'PO 6/6/2018 15:39:07'!
name
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #TusLibros!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'initialization' stamp: 'PO 6/6/2018 15:29:50'!
withName: aName 
	^ self new withName: aName.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'querying' stamp: 'PB 6/4/2018 21:26:29'!
contains: aBook 
	^books includes: aBook ! !

!Cart methodsFor: 'querying' stamp: 'PB 6/4/2018 21:23:48'!
isEmpty
	^books isEmpty ! !

!Cart methodsFor: 'querying' stamp: 'PB 6/4/2018 21:38:29'!
quantity: aBook
	^books count: [ :bookInCart | bookInCart = aBook ]! !


!Cart methodsFor: 'buying' stamp: 'PB 6/7/2018 09:30:04'!
addBook: aBook 
	(catalog isPresent: aBook) ifFalse: [ self error: self class errorCannotAddBookNotInCatalog. ].
	books add: aBook.! !

!Cart methodsFor: 'buying' stamp: 'PB 6/4/2018 21:50:12'!
removeBook: aBook 
	[ books remove: aBook ] 
		on: Error
		do: [self error: self class cantRemoveBookNotAdded ]! !


!Cart methodsFor: 'initialization' stamp: 'PB 6/7/2018 09:28:03'!
initialize
	catalog := NoCatalog new.
	books := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'PB 6/7/2018 09:22:45'!
withCatalog: aCatalog 
	catalog := aCatalog.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'accessing class hierarchy' stamp: 'PB 6/4/2018 21:47:46'!
cantRemoveBookNotAdded
	^'Cannot remove book that was not added to cart'! !


!Cart class methodsFor: 'class initialization' stamp: 'PB 6/7/2018 09:22:16'!
newWithCatalog: aCatalog 
	^self new withCatalog: aCatalog.! !


!Cart class methodsFor: 'error messages' stamp: 'PB 6/7/2018 09:26:20'!
errorCannotAddBookNotInCatalog
	^'Cannot add book that is not in catalog'! !


!classDefinition: #Catalog category: #TusLibros!
Object subclass: #Catalog
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalog methodsFor: 'initialization' stamp: 'PB 6/7/2018 09:31:17'!
initialize
	books := OrderedCollection new.! !

!Catalog methodsFor: 'initialization' stamp: 'PB 6/7/2018 09:21:41'!
with: someBooks
	books := OrderedCollection new.
	someBooks do: [:book | books add: book].
	^self! !


!Catalog methodsFor: 'querying' stamp: 'PB 6/7/2018 09:31:33'!
isPresent: aBook 
	^books includes: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalog class' category: #TusLibros!
Catalog class
	instanceVariableNames: ''!

!Catalog class methodsFor: 'as yet unclassified' stamp: 'PB 6/7/2018 09:20:34'!
with: someBooks
	^self new with: someBooks.! !


!classDefinition: #NoCatalog category: #TusLibros!
Catalog subclass: #NoCatalog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!NoCatalog commentStamp: '<historical>' prior: 0!
Equivalent to not having a catalog. Null object pattern.!


!NoCatalog methodsFor: 'as yet unclassified' stamp: 'PB 6/7/2018 09:32:06'!
isPresent: aBook.
	^true.! !
