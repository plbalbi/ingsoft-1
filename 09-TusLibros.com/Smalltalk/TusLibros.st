!classDefinition: #MarketTest category: #TusLibros!
TestCase subclass: #MarketTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:32:31'!
test001NewBookHasName

	|book|
	book := Book withName: 'awesome book'.
	self assert: (book name) equals: 'awesome book'.
	! !

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 21:18:37'!
test01EmptyCartHasNoElements
	
	|cart|
	
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:41:54'!
test02BookCanBeAddedToCart
	
	|cart book|
	
	book := Book withName: 'awesome book'.
	
	cart := Cart new.
	cart addBook: book.
	
	self deny: cart isEmpty.
	self assert: (cart contains: book).! !

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:42:56'!
test03SameBookCanBeAddedMultipleTimes
	
	|cart book bookQuantity |
	
	book := Book withName: 'awesome book'.
	bookQuantity := 3.
	
	cart := Cart new.
	bookQuantity timesRepeat: [ cart addBook: book. ].	
	
	self deny: cart isEmpty.
	self assert: (cart contains: book).
	self assert: (cart quantity: book) equals: bookQuantity.! !

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:43:50'!
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

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:44:12'!
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

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:44:21'!
test06ABookCanBeRemovedFromCart

	| cart book |
	
	book := Book withName: 'awesome book'.
	
	cart _ Cart new.
	cart addBook: book.
	cart removeBook: book.
	
	self assert: cart isEmpty.! !

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:44:26'!
test07BookCanBeRemovedMultipleTimesFromCart

	| cart book bookQuantity |
	
	book := Book withName: 'awesome book'.
	bookQuantity := 3.
	
	cart _ Cart new.
	bookQuantity timesRepeat: [ cart addBook: book. ].
	bookQuantity timesRepeat: [ cart removeBook: book. ].
	
	self assert: cart isEmpty.! !

!MarketTest methodsFor: 'as yet unclassified' stamp: 'PO 6/6/2018 15:44:32'!
test08CantRemoveBookThatIsNotInCart

	| cart book |
	
	book := Book withName: 'awesome book'.
	
	cart _ Cart new.
	
	
	
	self 
		should: [ cart removeBook: book. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: cart isEmpty.
			self assert: Cart cantRemoveBookNotAdded equals: error messageText.
			]! !


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
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 21:21:55'!
addBook: aBook 
	books add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 21:26:29'!
contains: aBook 
	^books includes: aBook ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 21:22:28'!
initialize

	books := OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 21:23:48'!
isEmpty
	^books isEmpty ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 21:38:29'!
quantity: aBook
	^books count: [ :bookInCart | bookInCart = aBook ]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 21:50:12'!
removeBook: aBook 
	[ books remove: aBook ] 
		on: Error
		do: [self error: self class cantRemoveBookNotAdded ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'accessing class hierarchy' stamp: 'PB 6/4/2018 21:47:46'!
cantRemoveBookNotAdded
	^'Cannot remove book that was not added to cart'! !
