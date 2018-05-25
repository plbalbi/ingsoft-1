!classDefinition: #TicTacToeTest category: #TicTacToeGame!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeGame'!

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 19:26:29'!
test01GameCreatesOk
	| game |
	game _ TicTacToe new.
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 19:26:48'!
test02XMakesFirstMoveFine
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self
		assert: 1
		equals: game Xs size.
	self assert: (game Xs includes: 1 @ 1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 19:27:04'!
test03XMakesMoveAndOFollowsFine
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 1 @ 2.
	self
		assert: 1
		equals: game Xs size.
	self
		assert: 1
		equals: game Os size.
	self assert: (game Xs includes: 1 @ 1).
	self assert: (game Os includes: 1 @ 2).! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 19:48:31'!
test04GameFailsWhenXPlaysTwiceInARow
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notXTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 19:48:20'!
test05GameFailsWhenOPlaysTwiceInARowAfterXPlayed
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 1 @ 2.
	self
		should: [ game putOAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notOTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self
				assert: 1
				equals: game Os size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: (game Os includes: 1 @ 2) ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 19:55:43'!
test06
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 1 equals: game Xs size.
			self assert: 1 equals: game Os size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: (game Os includes: 2 @ 2) 
		].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 20:03:29'!
test07
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 1 equals: game Xs size.
			self assert: 1 equals: game Os size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: (game Os includes: 2 @ 2) 
		].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 20:05:45'!
test08
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self
		should: [ game putOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 1 equals: game Xs size.
			self assert: game Os isEmpty.
			self assert: (game Xs includes: 1 @ 1).
		].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 20:08:25'!
test09
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 3 @ 3.
	self
		should: [ game putOAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assert: 2 equals: game Xs size.
			self assert: 1 equals: game Os size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: (game Xs includes: 3 @ 3).
			self assert: (game Os includes: 2 @ 2).
		].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 20:40:19'!
test10
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 3.

	self deny: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 20:53:40'!
test11
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 3.
	game putXAt: 1 @ 3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:06:25'!
test12
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 3.
	game putXAt: 1 @ 3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:06:22'!
test13
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 3.
	game putXAt: 1 @ 3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:04:15'!
test14
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 3.
	game putXAt: 3 @ 1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:07:38'!
test15
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 3 @ 3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:06:56'!
test16
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 3.
	game putXAt: 3 @ 1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:29:36'!
test17
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 3.
	game putOAt: 1 @ 1.
	game putXAt: 3 @ 2.
	game putOAt: 2 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 3 @ 3.

	self deny: game XHasWon.
	self assert: game OHasWon.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:28:49'!
test18
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	
	self 
		should: [game putXAt: 2@2 ]
	 	raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe cannotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 3@1).
			].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:32:03'!
test19
"TODO: O gana, X quiere jugar"
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	
	self 
		should: [game putXAt: 2@2 ]
	 	raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe cannotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 3@1).
			].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 5/24/2018 21:36:54'!
test20
"TODO: empate"
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 2 @ 3.
	game putXAt: 3 @ 1.
	game putOAt: 3 @ 2.
	game putXAt: 3 @ 3.
			
	self assert: game isOver.
	self assert: game XHasWon.
	self assert: game OHasWon .
	self assert: game isTied.! !


!classDefinition: #TicTacToe category: #TicTacToeGame!
Object subclass: #TicTacToe
	instanceVariableNames: 'xs os turn winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeGame'!

!TicTacToe methodsFor: 'accessing' stamp: 'PB 5/24/2018 19:17:40'!
Os
	^os! !

!TicTacToe methodsFor: 'accessing' stamp: 'PB 5/24/2018 19:17:26'!
Xs
	^xs! !

!TicTacToe methodsFor: 'accessing' stamp: 'PB 5/24/2018 20:19:40'!
failOnOccupiedSlot: aMove 
	(self Xs includes: aMove) | (self Os includes: aMove) 
		ifTrue:
			[ self error: self class positionTakenErrorMessage. ].! !


!TicTacToe methodsFor: 'playing' stamp: 'PB 5/24/2018 21:30:26'!
putOAt: aMove 
	(turn = #x) ifTrue: 
		[
		self error: self class notOTurnErrorMessage.
		].
	self failOnOccupiedSlot: aMove.
	self Os add: aMove.
	(self anyRowCompleted: self Os) ifTrue: [
		winner := #o.
		].
	(self anyColumnCompleted: self Os) ifTrue: [
		winner := #o.
		].
	(self anyDiagonalCompleted: self Os) ifTrue: [
		winner := #o.
		].
	
	turn := #x.! !

!TicTacToe methodsFor: 'playing' stamp: 'PB 5/24/2018 21:08:03'!
putXAt: aMove
	(turn = #o) ifTrue: 
		[
		self error: self class notXTurnErrorMessage.
		].
	self failOnOccupiedSlot: aMove.
	self Xs add: aMove.
	(self anyRowCompleted: self Xs) ifTrue: [
		winner := #x.
		].
	(self anyColumnCompleted: self Xs) ifTrue: [
		winner := #x.
		].
	(self anyDiagonalCompleted: self Xs) ifTrue: [
		winner := #x.
		].
	turn := #o.! !


!TicTacToe methodsFor: 'instance creation' stamp: 'PB 5/24/2018 19:39:38'!
initialize
	xs := Set new.
	os := Set new.
	turn := #x.! !


!TicTacToe methodsFor: 'winning' stamp: 'PB 5/24/2018 20:58:51'!
OHasWon
	^winner = #o.! !

!TicTacToe methodsFor: 'winning' stamp: 'PB 5/24/2018 20:58:36'!
XHasWon
	^winner = #x.! !

!TicTacToe methodsFor: 'winning' stamp: 'PB 5/24/2018 21:05:40'!
anyColumnCompleted: positions
	^(1 to: 3) anySatisfy: [ :y |
		(positions count: [ :aPosition |
			aPosition y = y .
			]) = 3.
		]! !

!TicTacToe methodsFor: 'winning' stamp: 'PB 5/24/2018 21:22:00'!
anyDiagonalCompleted: positions
	^(
		(positions count: [ :aPosition | aPosition x = aPosition y ]) = 3
	) | (
		(positions count: [ :aPosition | positions includes: aPosition transposed ]) = 3
	).! !

!TicTacToe methodsFor: 'winning' stamp: 'PB 5/24/2018 21:17:15'!
anyRowCompleted: positions
	^(1 to: 3) anySatisfy: [ :x |
		(positions count: [ :aPosition |
			aPosition x = x.
			]) = 3.
		]! !

!TicTacToe methodsFor: 'winning' stamp: 'PB 5/24/2018 21:46:04'!
isOver
self halt.
"agregar caso en que gano alguno"
	^((self Xs size + self Os size) = 9) &
		(winner = nil).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToeGame!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'PB 5/24/2018 19:41:32'!
notOTurnErrorMessage
	^'Not O turn to play'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'PB 5/24/2018 19:37:23'!
notXTurnErrorMessage
	^'Not X turn to play'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'PB 5/24/2018 19:55:04'!
positionTakenErrorMessage
	^'Position already taken'! !


!TicTacToe class methodsFor: 'error messages' stamp: 'PB 5/24/2018 21:31:00'!
cannotPlayWhenGameIsOverErrorMessage
	^'Game is over. Cannot continue playing'! !
