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

!OOStack methodsFor: 'info' stamp: 'P 4/23/2018 20:26:36'!
isEmpty

	^firstElement = nil! !

!OOStack methodsFor: 'info' stamp: 'P 4/23/2018 21:48:11'!
raiseExceptionIfEmpty
	self isEmpty ifTrue: [Error signal: OOStack stackEmptyErrorDescription].! !

!OOStack methodsFor: 'info' stamp: 'P 4/23/2018 20:52:52'!
size
	^1! !


!OOStack methodsFor: 'accessing' stamp: 'P 4/23/2018 21:48:28'!
pop
| poppedElement |
	self raiseExceptionIfEmpty.
	poppedElement := firstElement value.
	firstElement hasNext 
		ifFalse: [
			firstElement := nil.
			] 
		ifTrue: [
			firstElement := firstElement next.
			].
	
	^poppedElement 
	! !

!OOStack methodsFor: 'accessing' stamp: 'P 4/23/2018 20:57:35'!
push: anObject
| objectContainer |
	objectContainer  := OOStackElement new: anObject.
	self isEmpty 
	ifTrue: [
		firstElement  := objectContainer.
		]
	ifFalse: [
		objectContainer setFollowing: firstElement .
		firstElement := objectContainer .
		]
	! !

!OOStack methodsFor: 'accessing' stamp: 'P 4/23/2018 21:48:40'!
top
	self raiseExceptionIfEmpty.
	^firstElement value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'element next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accessing' stamp: 'P 4/23/2018 20:24:35'!
contain: anElement
	element  := anElement! !

!OOStackElement methodsFor: 'accessing' stamp: 'P 4/23/2018 21:03:10'!
next
	^next! !

!OOStackElement methodsFor: 'accessing' stamp: 'P 4/23/2018 20:55:08'!
setFollowing: anOOStackElement
	next  := anOOStackElement ! !

!OOStackElement methodsFor: 'accessing' stamp: 'P 4/23/2018 20:32:29'!
value
	^element ! !


!OOStackElement methodsFor: 'info' stamp: 'P 4/23/2018 21:02:04'!
hasNext
	^next ~= nil! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: #'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'instance creation' stamp: 'P 4/23/2018 20:41:07'!
new: anElement
	^self new contain: anElement ! !
