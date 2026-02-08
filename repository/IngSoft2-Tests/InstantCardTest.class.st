Class {
	#name : 'InstantCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
InstantCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals:
				errorMessage ]
]

{ #category : 'tests' }
InstantCardTest >> test0WhenItsNotTheSpaceShipTurnitCanStillThrowAInatantaniousCard [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard aRedoCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.


	anAccelerationCard := CardAcceleration new.
	aGameSetUp equip: aPlayer1 with: anAccelerationCard.
	aRedoCard := CardRedo new.
	aCancellationCard := CancellationCard new.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                aCancellationCard.
		                aRedoCard } asOrderedCollection.
	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).


	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playCard: anAccelerationCard  by:aPlayer1 targeting: NoTarget new.
	aBoard playCard: anAccelerationCard by:aPlayer1 targeting: NoTarget new.
	aBoard playCard: aCancellationCard by:aPlayer2 targeting: anAccelerationCard.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.

	aBoard playCard: aRedoCard by:aPlayer2 targeting: anAccelerationCard .
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.

	aBoard playCard: anAccelerationCard by:aPlayer1 targeting: NoTarget new.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 5
]

{ #category : 'tests' }
InstantCardTest >> test12WhenACancellationCardIsUsedThenItCancelsTheEffectOfAPreviousCard [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration new.
	aCancellationCard := CancellationCard new.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsRandomly: (Deck withCards: (aDeckOfCards)).
	aGameSetUp equip: aPlayer2 with: aCancellationCard.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	aBoard playCard: anAccelerationCard by:aPlayer1 targeting: NoTarget new.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.

	aBoard playCard: aCancellationCard by:aPlayer2 targeting: anAccelerationCard .
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer2) equals: 1
]

{ #category : 'tests' }
InstantCardTest >> test13WhenThePermanentCardIWhichWantsToGetCancelledIsntBeingPlayedThenCancellationCardHasNoEffect [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration new.
	aCancellationCard := CancellationCard new.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsRandomly: (Deck withCards: (aDeckOfCards)).

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aPlayer2 equipWith: aCancellationCard.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.



	self
		should: [ aBoard playCard: aCancellationCard by:aPlayer2  targeting: anAccelerationCard ]
		raise: Error
		withMessageText: 'That card is not being played'
	"aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer2) equals: 1"
]

{ #category : 'tests' }
InstantCardTest >> test14NitroIncreasesOnlyTargetSpaceShipRoll [


	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aNitro |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aNitro := CardNitro new.

	aDeckOfCards := {
		                aNitro.
		                aNitro.
		                aNitro.
		                aNitro } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

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
	aGameSetUp withTiles: { }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playCard: aNitro by:aPlayer1 targeting: aPlayer2.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
]

{ #category : 'tests' }
InstantCardTest >> test15NitroAffectsTheTargetedSpaceshipOnlyFor3Turns [


	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aNitro |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 100.
	aDice setNumbersProvider: { 1 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aNitro := CardNitro new.

	aDeckOfCards := {
		                aNitro.
		                aNitro.
		                aNitro.
		                aNitro } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

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
	aGameSetUp withTiles: { }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playCard: aNitro by:aPlayer1 targeting: aPlayer2.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 8.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 12.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 13.
]

{ #category : 'tests' }
InstantCardTest >> test16NitroCardCanBePlayedAtAnyTimeBecauseItsAnInstantaniousCard [


	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aNitro |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 100.
	aDice setNumbersProvider: { 1 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aNitro := CardNitro new.

	aDeckOfCards := {
		                aNitro.
		                aNitro.
		                aNitro.
		                aNitro } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

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
	aGameSetUp withTiles: { }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	
	aBoard playNextTurn.
	aBoard playCard: aNitro by:aPlayer1 targeting: aPlayer2.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	
]

{ #category : 'tests' }
InstantCardTest >> test1ARepeatCardIsUsedAfterFallinginABonusTileThenTheAssignedSpaceshipGetsAnotherCard [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 2. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.


	anAccelerationCard := CardAcceleration new.

	aRepeat := CardRepeat new.
	aCancellationCard := CancellationCard new.

	aDeckOfCards := {
		                aRepeat.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

	aGameSetUp withTiles: { (BonusCard in: 1) }.


	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.


	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	self assert: aPlayer1 cardsInHand equals: (OrderedCollection
			 with: aRepeat
			 with: anAccelerationCard
			 with: anAccelerationCard).
	aBoard playCard: aRepeat by:aPlayer1 targeting: NoTarget new.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	self assert: aPlayer2 cardsInHand equals: (OrderedCollection
			 with: anAccelerationCard
			 with: anAccelerationCard
			 with: anAccelerationCard)
]

{ #category : 'tests' }
InstantCardTest >> test2ARepeatCardIsUsedAfterFallinginAAtomicBombTheTheSpaeShipTargetedGetsMoveToInitialPosition [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 2 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration new.

	aRepeat := CardRepeat new.
	aCancellationCard := CancellationCard new.

	aDeckOfCards := {
		                aRepeat.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).
	aGameSetUp withTiles: { (AtomicBomb in: 2) }.


	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	aBoard playCard: aRepeat by:aPlayer1 targeting: aPlayer2 .
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 0
]

{ #category : 'tests' }
InstantCardTest >> test3ARepeatCardIsUsedAfterFallinginABlackHole [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 1. 4. 4. 6 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.
	aRepeat := CardRepeat new.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.
	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

	aGameSetUp withTiles: { (BlackHole in: 5) }.


	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	aBoard playCard: aRepeat by:aPlayer1 targeting: aPlayer2 .
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 6
]

{ #category : 'tests' }
InstantCardTest >> test4ARepeatCardIsUsedAfterFallinginAHyperGravity [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 3. 1. 4. 4. 3. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.
	aRepeat := CardRepeat new.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.
	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

	aGameSetUp withTiles:
		{ (HyperGravity in: 3 requiringMinimumRoll: 3) }.


	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	aBoard playCard: aRepeat by:aPlayer1 targeting: aPlayer2 .
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4
]

{ #category : 'tests' }
InstantCardTest >> test5ARepeatCardIsUsedAfterFallinginAHyperJump [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 4. 1. 4. 4. 3. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.
	aRepeat := CardRepeat new.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).
	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withBoardsLengthInMetric: (Parsec distance: 100).
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: { (HyperJump in: 4 toMove: {
				 (Parsec distance: 8).
				 (Parsec distance: 4).
				 (Parsec distance: 2).
				 (Parsec distance: 1) }) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 12.
	aBoard playCard: aRepeat  by:aPlayer1 targeting: aPlayer2.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5
]

{ #category : 'tests' }
InstantCardTest >> test6ARepeatCardIsUsedAfterFallinginMoonWalk [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat new.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

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
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(MoonWalk in: 10 moveBack: 2) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	aBoard playCard: aRepeat by:aPlayer1 targeting: aPlayer2 .
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5
]

{ #category : 'tests' }
InstantCardTest >> test7ARepeatCardIsUsedAfterFallinginWormHole [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat new.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

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
	aGameSetUp withTiles: { (WormHole from: 1 to: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playCard: aRepeat by:aPlayer1 targeting: aPlayer2.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 8
]

{ #category : 'tests' }
InstantCardTest >> test8ARepeatCardIsUsedAfterFallinginNormalTile [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat new.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

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
	aGameSetUp withTiles: { (WormHole from: 1 to: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playCard: aRepeat by:aPlayer1 targeting: aPlayer2 .
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 6.
	self assert: (aBoard positionOf: aPlayer2) equals: 9
]

{ #category : 'tests' }
InstantCardTest >> test9ARepeatCardIsUsedButNoDiceWasRolledThenItDosentHaveAEfect [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 4. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat new.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: (Deck withCards: (aDeckOfCards)).

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
	aGameSetUp withTiles: { (WormHole from: 1 to: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playCard: aRepeat by:aPlayer1 targeting: aPlayer2 .
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 5
]
