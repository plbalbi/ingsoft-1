!classDefinition: #TicTacToeConsoleTest category: #TicTacToe!
TestCase subclass: #TicTacToeConsoleTest
	instanceVariableNames: 'ticTacToeConsole ticTacToeGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsoleTest methodsFor: 'preparation' stamp: 'PB 6/3/2018 19:36:25'!
setUp
	ticTacToeConsole _ TicTacToeConsole new.
	ticTacToeGame _ TicTacToe withObserver: ticTacToeConsole.! !


!TicTacToeConsoleTest methodsFor: 'testing' stamp: 'PB 6/3/2018 19:36:43'!
test01ConsoleLogsXPlays
	| expectedLogs |
	
	expectedLogs := {
		'X marcó en 2@2'.
		'Estado: Jugando O'.	
	}.
	
	ticTacToeGame markAll: {2@2}.
	
	self assertExpectedLogs: expectedLogs equalTo: ticTacToeConsole logs.! !

!TicTacToeConsoleTest methodsFor: 'testing' stamp: 'PB 6/3/2018 19:36:55'!
test02ConsoleLogsOPlaysAndXPlays
	| expectedLogs |
	expectedLogs _ {'X marcó en 2@2'. 'Estado: Jugando O'. 'O marcó en 1@1'. 'Estado: Jugando X'}.

	ticTacToeGame markAll:
		{2 @ 2. 1 @ 1}.
	self
		assertExpectedLogs: expectedLogs
		equalTo: ticTacToeConsole logs.! !

!TicTacToeConsoleTest methodsFor: 'testing' stamp: 'PB 6/3/2018 19:37:12'!
test03ConsoleLogsPlayerChangeAndBack
	| expectedLogs |
	expectedLogs _ {'X marcó en 2@2'. 'Estado: Jugando O'. 'O marcó en 1@1'. 'Estado: Jugando X'. 'X marcó en 1@3'. 'Estado: Jugando O'}.

	ticTacToeGame markAll:
		{2 @ 2. 1 @ 1. 1 @ 3}.
	self
		assertExpectedLogs: expectedLogs
		equalTo: ticTacToeConsole logs.! !

!TicTacToeConsoleTest methodsFor: 'testing' stamp: 'PB 6/3/2018 19:37:22'!
test04ConsoleLogsXWon
	| expectedLogs |
	expectedLogs _ {'X marcó en 2@2'. 'Estado: Jugando O'. 'O marcó en 1@1'. 'Estado: Jugando X'. 'X marcó en 1@3'. 'Estado: Jugando O'. 'O marcó en 1@2'. 'Estado: Jugando X'. 'X marcó en 3@1'. 'Estado: Juego terminado - Ganó X!!'}.

	ticTacToeGame markAll:
		{2 @ 2. 1 @ 1. 1 @ 3. 1 @ 2. 3 @ 1}.
	self
		assertExpectedLogs: expectedLogs
		equalTo: ticTacToeConsole logs.! !

!TicTacToeConsoleTest methodsFor: 'testing' stamp: 'PB 6/3/2018 20:35:00'!
test05ConsoleLogsOWon
	| expectedLogs |
	
	expectedLogs _ {
    'X marcó en 1@3'.
    'Estado: Jugando O'.
    'O marcó en 2@2'.
    'Estado: Jugando X'.
    'X marcó en 2@1'.
    'Estado: Jugando O'.
    'O marcó en 1@1'.
    'Estado: Jugando X'.
    'X marcó en 1@2'.
    'Estado: Jugando O'.
    'O marcó en 3@3'.
    'Estado: Juego terminado - Ganó O!!'.
}.
	
	ticTacToeGame markAll: { 1@3. 2@2. 2@1. 1@1. 1@2. 3@3. }.
	
	self
		assertExpectedLogs: expectedLogs
		equalTo: ticTacToeConsole logs.! !

!TicTacToeConsoleTest methodsFor: 'testing' stamp: 'PB 6/3/2018 19:37:38'!
test06ConsoleLogsGameTied
	| expectedLogs |
	expectedLogs _ {'X marcó en 2@2'. 'Estado: Jugando O'. 'O marcó en 1@1'. 'Estado: Jugando X'. 'X marcó en 1@3'. 'Estado: Jugando O'. 'O marcó en 3@1'. 'Estado: Jugando X'. 'X marcó en 2@1'. 'Estado: Jugando O'. 'O marcó en 2@3'. 'Estado: Jugando X'. 'X marcó en 1@2'. 'Estado: Jugando O'. 'O marcó en 3@2'. 'Estado: Jugando X'. 'X marcó en 3@3'. 'Estado: Juego terminado - Hubo empate!!'}.
	
	ticTacToeGame markAll:
		{2 @ 2. 1 @ 1. 1 @ 3. 3 @ 1. 2 @ 1. 2 @ 3. 1 @ 2. 3 @ 2. 3 @ 3}.
	self
		assertExpectedLogs: expectedLogs
		equalTo: ticTacToeConsole logs.! !


!TicTacToeConsoleTest methodsFor: 'asserts' stamp: 'PB 6/3/2018 18:06:36'!
assertExpectedLogs: expectedLogs equalTo: logs

	self assert: expectedLogs size equals: logs size.
	
	(1 to: logs size) do: [ :index |
		self assert: (expectedLogs at: index) equals: (logs at: index).
		].! !


!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 6/3/2018 16:29:06'!
test27LastPlayWhenCorrespondsToX
	game _ TicTacToe new.
	game markAll:
		{1 @ 1. 2 @ 1. 1 @ 2}.
	self
		assert: 1 @ 2
		equals: game lastPlay.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'PB 6/3/2018 16:32:39'!
test28LastPlayWhenCorrespondsToO
	game _ TicTacToe new.
	game markAll:
		{1 @ 1. 2 @ 1. 1 @ 2. 3@3}.
	self
		assert: 3 @ 3
		equals: game lastPlay.! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToeViewerTests category: #TicTacToe!
TestCase subclass: #TicTacToeViewerTests
	instanceVariableNames: 'viewer game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeViewerTests methodsFor: 'testing' stamp: 'PB 6/3/2018 23:47:32'!
test01ViewerShowsXPlays

	game markAll: {2 @ 2}.
	self assert: 
' | | 
-----
 |X| 
-----
 | | 
Playing O'
		equals: viewer view.! !

!TicTacToeViewerTests methodsFor: 'testing' stamp: 'PB 6/3/2018 23:47:41'!
test02ViewerShowsOPlaysAfterX

	game markAll: {1 @ 1. 2 @ 2}.
	self assert: 
'X| | 
-----
 |O| 
-----
 | | 
Playing X'
		equals: viewer view.! !

!TicTacToeViewerTests methodsFor: 'testing' stamp: 'PB 6/3/2018 23:47:51'!
test03ViewerShowsXPlaysAgainAfterO

	game markAll: {1 @ 1. 2 @ 2. 2 @ 1}.
	self assert: 
'X| | 
-----
X|O| 
-----
 | | 
Playing O'
		equals: viewer view.! !

!TicTacToeViewerTests methodsFor: 'testing' stamp: 'PB 6/3/2018 23:48:18'!
test04ViewerShowsPlaysAfterXWinning

	game markAll: {2 @ 2. 1 @ 1. 1 @ 3. 1 @ 2. 3 @ 1}.
	self assert: 
'O|O|X
-----
 |X| 
-----
X| | 
X has won!!'
		equals: viewer view.! !

!TicTacToeViewerTests methodsFor: 'testing' stamp: 'PB 6/3/2018 23:48:03'!
test05ViewerShowsPlaysAfterOWinning

	game markAll: { 1@3. 2@2. 2@1. 1@1. 1@2. 3@3. }.
	self assert: 
'O|X|X
-----
X|O| 
-----
 | |O
O has won!!'
		equals: viewer view.! !

!TicTacToeViewerTests methodsFor: 'testing' stamp: 'PB 6/3/2018 23:48:22'!
test06ViewerShowsPlaysAfterTie

	game markAll: {2 @ 2. 1 @ 1. 1 @ 3. 3 @ 1. 2 @ 1. 2 @ 3. 1 @ 2. 3 @ 2. 3 @ 3}.
	self assert: 
'O|X|X
-----
X|X|O
-----
O|O|X
Game end in tie'
		equals: viewer view.! !


!TicTacToeViewerTests methodsFor: 'preparation' stamp: 'PB 6/3/2018 20:25:21'!
setUp
	viewer _ TicTacToeViewer new.
	game _ TicTacToe withObserver: viewer.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions console lastPlay notifier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'PB 6/4/2018 00:35:49'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	notifier := TicTacToeNotifier new withGame: self.! !

!TicTacToe methodsFor: 'initialization' stamp: 'PB 6/4/2018 00:29:49'!
initializeWithObserver: aTicTacToeObserver
	notifier attach: aTicTacToeObserver ! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'PB 6/3/2018 16:35:31'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	lastPlay := aPosition.
	
	state markWithOAt: aPosition.! !

!TicTacToe methodsFor: 'marking board' stamp: 'PB 6/3/2018 16:35:20'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	lastPlay := aPosition.
	
	state markWithXAt: aPosition.
	
	! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'PB 6/4/2018 00:31:18'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self.
	
	notifier notify.
		
	^self
	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'JG 5/12/2018 12:34:04'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'PB 5/31/2018 20:22:37'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !

!TicTacToe methodsFor: 'testing game result' stamp: 'PB 6/3/2018 16:32:11'!
lastPlay
	^lastPlay.! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'accessing' stamp: 'PB 6/3/2018 17:34:13'!
currentStateNameFor: aTicTacToeStateConsumer
	^state stateName: aTicTacToeStateConsumer! !


!TicTacToe methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:43:15'!
lastPlayerName
	^state lastPlayerName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!TicTacToe class methodsFor: 'instance creation' stamp: 'PB 6/3/2018 19:33:54'!
withObserver: aTicTacToeObserver
	^ self new initializeWithObserver: aTicTacToeObserver.! !


!classDefinition: #TicTacToeNotifier category: #TicTacToe!
Object subclass: #TicTacToeNotifier
	instanceVariableNames: 'observers game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeNotifier methodsFor: 'notifications' stamp: 'PB 6/4/2018 00:26:31'!
initialize
	observers := OrderedCollection new.! !

!TicTacToeNotifier methodsFor: 'notifications' stamp: 'PB 6/4/2018 00:26:02'!
notify
	observers do: [ :observer | observer notify].! !


!TicTacToeNotifier methodsFor: 'observers' stamp: 'PB 6/4/2018 00:34:56'!
attach: aTicTacToeObserver
	observers add: (aTicTacToeObserver attachGame: game).! !


!TicTacToeNotifier methodsFor: 'initialization' stamp: 'PB 6/4/2018 00:34:09'!
withGame: aGame.
	game := aGame.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeNotifier class' category: #TicTacToe!
TicTacToeNotifier class
	instanceVariableNames: ''!

!TicTacToeNotifier class methodsFor: 'as yet unclassified' stamp: 'PB 6/4/2018 00:33:48'!
with: aGame
	^self new withGame: aGame.! !


!classDefinition: #TicTacToeObserver category: #TicTacToe!
Object subclass: #TicTacToeObserver
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserver methodsFor: 'initializing' stamp: 'PB 6/4/2018 00:05:51'!
attachGame: aTicTacToeGame
	game := aTicTacToeGame.
	^self! !


!TicTacToeObserver methodsFor: 'notifications' stamp: 'PB 6/4/2018 00:06:26'!
notify
	self subclassResponsibility ! !


!TicTacToeObserver methodsFor: 'state naming' stamp: 'PB 6/4/2018 00:06:49'!
stateNameForGameTied
	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'state naming' stamp: 'PB 6/4/2018 00:06:53'!
stateNameForPlayerOWon
	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'state naming' stamp: 'PB 6/4/2018 00:06:56'!
stateNameForPlayerXWon
	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'state naming' stamp: 'PB 6/4/2018 00:07:00'!
stateNameForPlayingO
	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'state naming' stamp: 'PB 6/4/2018 00:07:05'!
stateNameForPlayingX
	self subclassResponsibility ! !


!TicTacToeObserver methodsFor: 'game querying' stamp: 'PB 6/4/2018 00:08:09'!
currentGameState
	^ game currentStateNameFor: self.! !


!classDefinition: #TicTacToeConsole category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeConsole
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsole methodsFor: 'notification' stamp: 'PB 6/3/2018 23:53:56'!
notify
	logs addLast: self lastMove.
	logs addLast: self currentGameState.! !


!TicTacToeConsole methodsFor: 'logging' stamp: 'PB 6/4/2018 00:11:49'!
logs
	^logs copy! !


!TicTacToeConsole methodsFor: 'game querying' stamp: 'PB 6/3/2018 23:53:56'!
lastMove
	^ game lastPlayerName , ' marcó en ' , game lastPlay printString.! !


!TicTacToeConsole methodsFor: 'initializing' stamp: 'PB 5/31/2018 20:07:39'!
initialize

	logs := OrderedCollection new.! !


!TicTacToeConsole methodsFor: 'state naming' stamp: 'PB 6/3/2018 17:40:50'!
stateNameForGameTied
	^'Estado: Juego terminado - Hubo empate!!'! !

!TicTacToeConsole methodsFor: 'state naming' stamp: 'PB 6/3/2018 20:40:41'!
stateNameForPlayerOWon
	^'Estado: Juego terminado - Ganó O!!'! !

!TicTacToeConsole methodsFor: 'state naming' stamp: 'PB 6/3/2018 17:39:19'!
stateNameForPlayerXWon
	^'Estado: Juego terminado - Ganó X!!'! !

!TicTacToeConsole methodsFor: 'state naming' stamp: 'PB 6/3/2018 17:36:51'!
stateNameForPlayingO
	^'Estado: Jugando O'! !

!TicTacToeConsole methodsFor: 'state naming' stamp: 'PB 6/3/2018 17:38:18'!
stateNameForPlayingX
	^'Estado: Jugando X'! !


!classDefinition: #TicTacToeViewer category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeViewer
	instanceVariableNames: 'currentState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeViewer methodsFor: 'initializing' stamp: 'PB 6/4/2018 00:21:49'!
initalize
	currentState := 'No moves made yet'! !


!TicTacToeViewer methodsFor: 'notifications' stamp: 'PB 6/4/2018 00:24:59'!
notify
"""
	currentState := self currentGameState.
	self updateGameView.
"""! !


!TicTacToeViewer methodsFor: 'viewing' stamp: 'PB 6/4/2018 00:16:19'!
view

| gameView |

gameView := ''.

(1 to: 3) do:[ :row |
	(1 to: 3) do: [ :column |
			gameView := gameView , (self whoPlayedInMark: row@column).
			column ~= 3 ifTrue: [gameView := gameView , '|'] 
		].
		gameView := gameView , self class newLine.
		row ~= 3 ifTrue: [
			gameView := gameView , self class rowSeparator , self class newLine.
			].
	].

gameView := gameView , self currentGameState .

^gameView! !


!TicTacToeViewer methodsFor: 'state naming' stamp: 'PB 6/3/2018 20:43:34'!
stateNameForGameTied
	^'Game end in tie'! !

!TicTacToeViewer methodsFor: 'state naming' stamp: 'PB 6/3/2018 20:41:01'!
stateNameForPlayerOWon
	^'O has won!!'! !

!TicTacToeViewer methodsFor: 'state naming' stamp: 'PB 6/3/2018 20:27:28'!
stateNameForPlayerXWon
	^'X has won!!'! !

!TicTacToeViewer methodsFor: 'state naming' stamp: 'PB 6/3/2018 20:15:48'!
stateNameForPlayingO
	^'Playing O'! !

!TicTacToeViewer methodsFor: 'state naming' stamp: 'PB 6/3/2018 20:18:16'!
stateNameForPlayingX
	^'Playing X'! !


!TicTacToeViewer methodsFor: 'game querying' stamp: 'PB 6/4/2018 00:24:43'!
whoPlayedInMark: aPosition
	(game playerXPositions includes: aPosition) ifTrue: [^'X'].
	(game playerOPositions includes: aPosition) ifTrue: [^'O'].
	^' '
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeViewer class' category: #TicTacToe!
TicTacToeViewer class
	instanceVariableNames: ''!

!TicTacToeViewer class methodsFor: 'predefined strings' stamp: 'PB 6/4/2018 00:14:25'!
newLine
	^Character newLineCharacter asString! !

!TicTacToeViewer class methodsFor: 'predefined strings' stamp: 'PB 6/4/2018 00:15:00'!
rowSeparator
	^'-----'! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!GameTied methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:47:47'!
lastPlayerName
	^'X'! !

!GameTied methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:40:24'!
stateName: aTicTacToeStateConsumer
	^aTicTacToeStateConsumer stateNameForGameTied! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!PlayerOWon methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:47:37'!
lastPlayerName
	^'O'! !

!PlayerOWon methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 20:40:22'!
stateName: aTicTacToeStateConsumer
	^aTicTacToeStateConsumer stateNameForPlayerOWon! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!PlayerXWon methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:47:27'!
lastPlayerName
	^'X'! !

!PlayerXWon methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:38:52'!
stateName: aTicTacToeStateConsumer
	^aTicTacToeStateConsumer stateNameForPlayerXWon! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!PlayingO methodsFor: 'accessing' stamp: 'PB 6/3/2018 17:36:09'!
stateName: aTicTacToeStateConsumer
	^aTicTacToeStateConsumer stateNameForPlayingO! !


!PlayingO methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:43:56'!
lastPlayerName
	^'X'! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !


!PlayingX methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:44:07'!
lastPlayerName
	^'O'! !

!PlayingX methodsFor: 'as yet unclassified' stamp: 'PB 6/3/2018 17:37:48'!
stateName: aTicTacToeStateConsumer
	^aTicTacToeStateConsumer stateNameForPlayingX! !
