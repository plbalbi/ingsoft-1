!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'P 4/23/2018 21:44:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = OOStack stackEmptyErrorDescription) ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'P 4/23/2018 21:47:22'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack |
		
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'firstElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'info' stamp: 'PO 4/26/2018 14:18:00'!
isEmpty

	^firstElement class = OOStackBase! !

!OOStack methodsFor: 'info' stamp: 'PO 4/26/2018 14:33:52'!
size
	^firstElement count! !


!OOStack methodsFor: 'accessing' stamp: 'PO 4/26/2018 14:21:36'!
pop
| poppedElement |
	poppedElement := firstElement value.
	firstElement := firstElement next.	
	
	^poppedElement 
	! !

!OOStack methodsFor: 'accessing' stamp: 'PO 4/26/2018 14:28:03'!
push: anObject
	| objectContainer |
	objectContainer _ OOStackCell new: anObject.
	
	objectContainer setFollowing: firstElement.
	firstElement _ objectContainer.! !

!OOStack methodsFor: 'accessing' stamp: 'PO 4/26/2018 14:30:57'!
top
	^firstElement value! !


!OOStack methodsFor: 'setter' stamp: 'PO 4/26/2018 14:17:15'!
setFirstElement: anOOStackBase 
	 firstElement := anOOStackBase! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'PO 4/26/2018 14:15:14'!
new
|newStack|
	newStack := super new.
	newStack setFirstElement: OOStackBase new.
	^newStack! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
Object subclass: #OOStackBase
	instanceVariableNames: 'element next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'info' stamp: 'PO 4/26/2018 14:06:33'!
hasNext
	^nil! !


!OOStackBase methodsFor: 'accessing' stamp: 'PO 4/26/2018 14:03:20'!
contain: anElement
	self error:'Cannot set element of base'! !

!OOStackBase methodsFor: 'accessing' stamp: 'PO 4/26/2018 14:07:33'!
next
	self error:'Cannot pop empty stack'! !

!OOStackBase methodsFor: 'accessing' stamp: 'PO 4/26/2018 14:05:49'!
setFollowing: anOOStackCell
	self error: 'Cannot set next of base'
	! !

!OOStackBase methodsFor: 'accessing' stamp: 'PO 4/26/2018 14:20:49'!
value
	Error signal: OOStack stackEmptyErrorDescription! !


!OOStackBase methodsFor: 'auxiliar' stamp: 'PO 4/26/2018 14:36:23'!
count
	^0! !

!OOStackBase methodsFor: 'auxiliar' stamp: 'PO 4/26/2018 14:36:19'!
count: previousSum
	^previousSum! !


!classDefinition: #OOStackCell category: #'Stack-Exercise'!
Object subclass: #OOStackCell
	instanceVariableNames: 'element next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackCell methodsFor: 'accessing' stamp: 'P 4/23/2018 20:24:35'!
contain: anElement
	element  := anElement! !

!OOStackCell methodsFor: 'accessing' stamp: 'P 4/23/2018 21:03:10'!
next
	^next! !

!OOStackCell methodsFor: 'accessing' stamp: 'P 4/23/2018 20:55:08'!
setFollowing: anOOStackElement
	next  := anOOStackElement ! !

!OOStackCell methodsFor: 'accessing' stamp: 'P 4/23/2018 20:32:29'!
value
	^element ! !


!OOStackCell methodsFor: 'info' stamp: 'P 4/23/2018 21:02:04'!
hasNext
	^next ~= nil! !


!OOStackCell methodsFor: 'auxiliar' stamp: 'PO 4/26/2018 14:35:11'!
count
	^next count:1! !

!OOStackCell methodsFor: 'auxiliar' stamp: 'PO 4/26/2018 14:35:40'!
count: previousSum
	^next count:(previousSum+1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackCell class' category: #'Stack-Exercise'!
OOStackCell class
	instanceVariableNames: ''!

!OOStackCell class methodsFor: 'instance creation' stamp: 'P 4/23/2018 20:41:07'!
new: anElement
	^self new contain: anElement ! !
