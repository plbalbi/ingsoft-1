!classDefinition: #TicTacToeTest category: #TicTacToStep21!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:30'!
test01NewGameIsEmpty

	|game|
	
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:31'!
test02XMakesOneMove

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.
	
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:31'!
test03XMovesAndOMoves

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: 1 equals: game Os size.
	self assert: (game Os includes: 2@2).
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PB 5/28/2018 21:37:41'!
test04GameFailsWhenXMovesTwice

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: (TicTacToe notTurnErrorMessage: #x) equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PB 5/28/2018 21:37:50'!
test05GameFailsWhenOMovesTwice

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putOAt: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: (TicTacToe notTurnErrorMessage: #o) equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:33'!
test06GameFailsWhenXMovesIntoPositionOccupiedByX

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putXAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:33'!
test07GameFailsWhenXMovesIntoPositionOccupiedByO

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:33'!
test08GameFailsWhenOMovesIntoPositionOccupiedByX

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	self
	should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert:  game Os isEmpty.

		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:34'!
test09GameFailsWhenOMovesIntoPositionOccupiedByO

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	self
	should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 3@3).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:34'!
test10NoPlayerHasWon

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	
		self deny: game OHasWon.
		self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:36'!
test11XHasWonInFirstRow

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:36'!
test12XHasWonInSecondRow

	|game|
	
	game := TicTacToe new.

	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 2@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:36'!
test13XHasWonInThirdRow

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:36'!
test14XHasWonInFirstColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:36'!
test15XHasWonInSecondColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:36'!
test16XHasWonInThirdColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 1@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:37'!
test17OHasWon

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	game putOAt: 1@3.
	
		self assert: game OHasWon.
		self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:37'!
test18OCannotPlayWhenXHasWon

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.	
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@1.	
	game putXAt: 1@3.

	self 
		should: [ game putOAt: 3@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:37'!
test19XCannotPlayWhenOHasWon

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 1@3.

	self 
		should: [ game putXAt: 3@2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game Xs size.
			self assert: (game Xs includes: 2@2).
			self assert: (game Xs includes: 2@1).
			self assert: (game Xs includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:38'!
test20GameIsTied

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.	
	game putOAt: 2@3.
	game putXAt: 1@2.	
	game putOAt: 3@2.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self deny: game XHasWon. 
	self deny: game OHasWon. 
	self assert: game isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'PabloBalbi 5/28/2018 20:38'!
test21GameOverAndNotTiedWhenPlayerWon

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@2.	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	game putXAt: 3@2.	
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self assert: game XHasWon. 
	self deny: game OHasWon. 
	self deny: game isTied
! !


!classDefinition: #TicTacToe category: #TicTacToStep21!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs turn winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToe methodsFor: 'initialization' stamp: 'PabloBalbi 5/28/2018 21:00'!
initialize
	
	xs:= PlayedTokens withGame: self andPlayer: #x.
	os:= PlayedTokens withGame: self andPlayer: #o.
	
	turn:= #x.! !


!TicTacToe methodsFor: 'playing' stamp: 'PB 5/28/2018 21:23:16'!
putOAt: aPosition

	os add: aPosition.
	turn := #x
! !

!TicTacToe methodsFor: 'playing' stamp: 'PB 5/28/2018 21:31:09'!
putXAt: aPosition

	xs add: aPosition.
	turn := #o
! !


!TicTacToe methodsFor: 'accessing' stamp: 'jg 5/22/2018 12:21:33'!
OHasWon
	
	^winner = #o! !

!TicTacToe methodsFor: 'accessing' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'accessing' stamp: 'jg 5/22/2018 12:21:43'!
XHasWon
	
	^winner = #x! !

!TicTacToe methodsFor: 'accessing' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !

!TicTacToe methodsFor: 'accessing' stamp: 'PB 5/28/2018 21:24:06'!
currentTurn
	^turn! !


!TicTacToe methodsFor: 'winning' stamp: 'PB 5/28/2018 21:13:15'!
canPlayAndIsValidPosition: aPosition
	self isGameOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].! !

!TicTacToe methodsFor: 'winning' stamp: 'jg 5/22/2018 13:17:25'!
isGameOver
	
	^winner = #x or: [ winner = #o ]! !

!TicTacToe methodsFor: 'winning' stamp: 'jg 5/22/2018 15:07:08'!
isOver
	
	^self XHasWon or: [ self OHasWon or: [ self isTied ]]
! !

!TicTacToe methodsFor: 'winning' stamp: 'PB 5/28/2018 21:50:48'!
isTied
	
	^xs size = 5 and: [ os size = 4 and: [ self XHasWon not ]]  and: [ self OHasWon not ]! !

!TicTacToe methodsFor: 'winning' stamp: 'PB 5/28/2018 21:30:40'!
win: aPlayer
	winner := aPlayer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToStep21!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:15:31'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:35:57'!
notTurnErrorMessage: aPlayer

	^'Not ', aPlayer asString asUppercase ,' turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #PlayedTokens category: #TicTacToStep21!
ProtoObject subclass: #PlayedTokens
	instanceVariableNames: 'game player tokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!PlayedTokens methodsFor: 'intialization' stamp: 'PB 5/28/2018 21:11:55'!
intializeWithGame: aGame andPlayer: aPlayer
	game := aGame.
	player := aPlayer.
	tokens := Set new.! !


!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/31/2018 01:25:07'!
add: aMove

	self canPlayAndIsValidPosition: aMove.
	(game currentTurn = player) ifFalse: [ self error: (TicTacToe notTurnErrorMessage: player) ].
	tokens add: aMove.
	(self won) ifTrue: [ game win: player ].! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/31/2018 01:30:52'!
canPlayAndIsValidPosition: aPosition
	game isGameOver ifTrue: [ self error: TicTacToe canNotPlayWhenGameIsOverErrorMessage ].
	(game Xs includes: aPosition) ifTrue: [ self error: TicTacToe positionTakenErrorMessage ].
	(game Os includes: aPosition) ifTrue: [ self error: TicTacToe positionTakenErrorMessage ].! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:14:32'!
doesNotUnderstand: aMessage
	^aMessage sendTo: tokens.! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:27:36'!
hasCompletedColumn
	
	^ (1 to: 3) anySatisfy: [ :y | (tokens count: [ :position | position y = y ]) = 3 ]! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:28:45'!
hasCompletedRow

	^ (1 to: 3) anySatisfy: [ :x | (tokens count: [ :posicion | posicion x = x ]) = 3 ]! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:29:12'!
hasDownDiagonal

	^(1 to: 3) allSatisfy: [ :n | tokens includes: n@n ]
! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:29:38'!
hasUpDiagonal

	^(1 to: 3) allSatisfy: [ :n | tokens includes: n@(4-n) ]! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:11:10'!
inspectorClass

	^Inspector ! !

!PlayedTokens methodsFor: 'as yet unclassified' stamp: 'PB 5/28/2018 21:28:26'!
won
	^(self hasCompletedRow )
		or: [(self hasCompletedColumn) 
				or: [(self hasDownDiagonal)
					or: [(self hasUpDiagonal)]]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayedTokens class' category: #TicTacToStep21!
PlayedTokens class
	instanceVariableNames: ''!

!PlayedTokens class methodsFor: 'class initialization' stamp: 'PabloBalbi 5/28/2018 21:05'!
withGame: aGame andPlayer: aPlayer 	^self new intializeWithGame: aGame andPlayer: aPlayer! !
