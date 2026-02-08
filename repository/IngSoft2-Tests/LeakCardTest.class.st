Class {
	#name : 'LeakCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LeakCardTest >> test1WhenLeakIsPlayedThenTargetSpaceShipConsumesDoubleFuel [


	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aLeakCard |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 4.
	aDice setNumbersProvider: { 2 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.
	

	aLeakCard := CardLeak new.

	aDeckOfCards := {
		                aLeakCard.
		                aLeakCard.
		                aLeakCard.
		                aLeakCard } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

	aGameSetUp withPlayers: {
			aPlayer1.aPlayer2
			 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.aPlayer2
			                 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: { }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:8.
	aBoard playCard: aLeakCard by:aPlayer1 targeting: aPlayer2.
	
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:4.
	self assert: (aBoard positionOf: aPlayer2) equals:2.
	
]

{ #category : 'tests' }
LeakCardTest >> test2LeakDoublesFuelConsumptionUntilTheSpaceshipRunsOutOfFuel [



	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aLeakCard |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 4.
	aDice setNumbersProvider: { 2 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.
	

	aLeakCard := CardLeak new.

	aDeckOfCards := {
		                aLeakCard.
		                aLeakCard.
		                aLeakCard.
		                aLeakCard } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

	aGameSetUp withPlayers: {
			aPlayer1.aPlayer2
			 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.aPlayer2
			                 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: { }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:8.
	aBoard playCard: aLeakCard by:aPlayer1 targeting: aPlayer2.
	
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:4.
	self assert: (aBoard positionOf: aPlayer2) equals:2.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:0.
	self assert: (aBoard positionOf: aPlayer2) equals:4.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:8.
	self assert: (aBoard positionOf: aPlayer2) equals:0.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:8.
	self assert: (aBoard positionOf: aPlayer2) equals:0.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals:6.
	self assert: (aBoard positionOf: aPlayer2) equals:2.
	
	
]

{ #category : 'tests' }
LeakCardTest >> test3LeakDoublesFuelConsumptionUntilThatCardIsCancelld [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aCancellationCard aLeakCard |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 4.
	aDice setNumbersProvider: { 2 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.


	aLeakCard := CardLeak new.
	aCancellationCard := CancellationCard new.
	aDeckOfCards := {
		                aLeakCard.
		                aCancellationCard.
		                aLeakCard.
		                aLeakCard } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: aDeckOfCards).

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: {  }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 8.
	aBoard playCard: aLeakCard by: aPlayer1 targeting: aPlayer2.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	aBoard playCard: aCancellationCard by: aPlayer1 targeting: aLeakCard.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 2.
	self assert: (aBoard positionOf: aPlayer2) equals: 4
]
