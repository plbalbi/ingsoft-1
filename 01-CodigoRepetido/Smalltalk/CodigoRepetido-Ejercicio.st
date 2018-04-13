!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 20:41:58'!
assertDurationOfBlock: aBlock isLessThan: aDuration

	| durationOfBlock |
	
	durationOfBlock:= self getDurationOfBlock: aBlock.
	
	self assert: durationOfBlock < aDuration 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 20:33:03'!
getDurationOfBlock: aBlockClosure 
	|millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	^millisecondsAfterRunning - millisecondsBeforeRunning! !

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 21:24:08'!
on: aBlockClosure shouldRaise: anErrorClass asserting: assertions
	aBlockClosure
		on: anErrorClass 
		do: assertions! !

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 21:30:34'!
setUp
	customerBook := CustomerBook new! !

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 21:31:10'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	self assertDurationOfBlock: [customerBook addCustomerNamed: 'John Lennon'.] isLessThan: 50	
! !

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 21:32:07'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
		  
	self assertDurationOfBlock:[customerBook removeCustomerNamed: paulMcCartney] isLessThan: 100.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 21:36:30'!
test03CanNotAddACustomerWithEmptyName 

	self on:[ customerBook addCustomerNamed: ''.
		self fail ]
		shouldRaise: Error
		asserting: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!IdiomTest methodsFor: 'testing' stamp: 'PO 4/12/2018 21:32:50'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self on: [customerBook removeCustomerNamed: 'Paul McCartney'.
		self fail ] 
		shouldRaise: NotFound
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
