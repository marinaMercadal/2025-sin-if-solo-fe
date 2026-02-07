Class {
	#name : 'FiniteDeckTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
FiniteDeckTest >> should:anErrorBlock raise:anErrorClass withMessegeText:errorMessage [

self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
FiniteDeckTest >> test1WhenADeckDistributionIsBuiltThenCardsFollowTheConfiguredProbabilities [

	| deckSize aDeckDistribution  |
	deckSize := 1000.
	aDeckDistribution := DeckDistribution new.

	aDeckDistribution forOverload: 0.20.
	aDeckDistribution forAlly: 0.15.
	aDeckDistribution forAcceleration: 0.15.
	aDeckDistribution forCancellation: 0.20.
	aDeckDistribution forRepeat: 0.15.
	aDeckDistribution forRedo: 0.15.

	aDeckDistribution build: deckSize.

	self assert:
		((aDeckDistribution percentageOf: CardOverLoad ) between: 0.18 and: 0.22).

	self assert:
		((aDeckDistribution percentageOf: CardAlly ) between: 0.13 and: 0.17).

	self assert: ((aDeckDistribution percentageOf: CardAcceleration )
			 between: 0.13
			 and: 0.17).

	self assert: ((aDeckDistribution percentageOf: CancellationCard )
			 between: 0.18
			 and: 0.22).

	self assert:
		((aDeckDistribution percentageOf: CardRepeat ) between: 0.13 and: 0.17).

	self assert:
		((aDeckDistribution percentageOf: CardRedo) between: 0.13 and: 0.17)
		
	


]

{ #category : 'tests' }
FiniteDeckTest >> test2TheSumOfTheProbabilitysShouldAlwaysBeOne [

	| deckSize aDeckDistribution  |
	deckSize := 1000.
	aDeckDistribution := DeckDistribution new.

	aDeckDistribution forOverload: 0.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 0.
	aDeckDistribution forCancellation: 0.
	aDeckDistribution forRepeat: 0.
	aDeckDistribution forRedo: 0.

	

		self
		should: [ aDeckDistribution build: deckSize. ]
		raise: Error
		withMessegeText: 'Deck probabilities do not sum to 1'
]

{ #category : 'tests' }
FiniteDeckTest >> test3WhenNoSpaceShipPlaysACardThenDeckRemainsUnchanged [

	| deckSize aDeckDistribution initialCards  deck |
	deckSize := 1.
	aDeckDistribution := DeckDistribution new.

	aDeckDistribution forOverload: 0.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 0.
	aDeckDistribution forCancellation: 1.
	aDeckDistribution forRepeat: 0.
	aDeckDistribution forRedo: 0.

	initialCards:=aDeckDistribution build: deckSize.

	deck:=Deck withCards: initialCards.
	self assert: deck cards  equals: initialCards 
	
	
]

{ #category : 'tests' }
FiniteDeckTest >> test4WhenGameStartsEachSpaceShipReceivesTwoCardsAndDeckReducesByFour [

	| aGameSetUp aDeckDistribution deckSize aPlayer1 aPlayer2 aDice initialCards aTurnManager aDeck aBoard |
	deckSize := 10.
	aDeckDistribution := DeckDistribution new.

	aDeckDistribution forOverload: 1.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 0.
	aDeckDistribution forCancellation: 0.
	aDeckDistribution forRepeat: 0.
	aDeckDistribution forRedo: 0.

	aGameSetUp := GameSetup new.

	initialCards := aDeckDistribution build: deckSize.

	aDeck := Deck withCards: initialCards.
	aGameSetUp assignsRandomly: aDeck.


	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.


	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	self assert: aBoard deckOfCards equals: (Deck withCards: {
				 CardOverLoad new.
				 CardOverLoad new.
				 CardOverLoad new.
				 CardOverLoad new.
				 CardOverLoad new.
				 CardOverLoad new } asOrderedCollection).
	self assert: (aBoard cardsOf: aPlayer1) size equals: 2.
	self assert: (aBoard cardsOf: aPlayer2) size equals: 2
]

{ #category : 'tests' }
FiniteDeckTest >> test5WhenThereIsNoCardPlayedThenTheDiscardDeckIsEmpty [

	| aGameSetUp aDeckDistribution deckSize aPlayer1 aPlayer2 aDice initialCards  aTurnManager aDeck aBoard |

	deckSize := 10.
	aDeckDistribution := DeckDistribution new.

	aDeckDistribution forOverload: 1.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 0.
	aDeckDistribution forCancellation: 0.
	aDeckDistribution forRepeat: 0.
	aDeckDistribution forRedo: 0.

	aGameSetUp := GameSetup new.

	initialCards:=aDeckDistribution build: deckSize.

	aDeck:=Deck withCards: initialCards.
	aGameSetUp assignsRandomly: aDeck .
	
	
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aGameSetUp withPlayers: { aPlayer1. aPlayer2 }.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	
	
	aGameSetUp createGameInstance.
	aBoard:=aGameSetUp board .
	
	self assert: (aBoard cardsOf:aPlayer1) size equals: 2.
	self assert: (aBoard cardsOf:aPlayer2) size equals: 2.

	self assert: (aBoard discardDeck) equals: ({}asOrderedCollection ).
	
	

]

{ #category : 'tests' }
FiniteDeckTest >> test6WhenACardIsPlayedThenItGoesToTheDiscardDeck [


	| aGameSetUp aDeckDistribution deckSize aPlayer1 aPlayer2 aDice initialCards  aTurnManager aDeck aBoard anAcelerationCard |

	deckSize := 10.
	aDeckDistribution := DeckDistribution new .

	aDeckDistribution forOverload: 0.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 1.
	aDeckDistribution forCancellation: 0.
	aDeckDistribution forRepeat: 0.
	aDeckDistribution forRedo: 0.

	aGameSetUp := GameSetup new.

	initialCards:=aDeckDistribution build: deckSize.

	aDeck:=Deck withCards: initialCards.
	aGameSetUp assignsRandomly: aDeck .
	
	
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aGameSetUp withPlayers: { aPlayer1. aPlayer2 }.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	
	self assert: initialCards size equals:10.
	aGameSetUp createGameInstance.
	aBoard:=aGameSetUp board .
	anAcelerationCard:=(CardAcceleration new).
	aPlayer1 equipWith: anAcelerationCard.
	
	self assert: (aBoard cardsOf:aPlayer1) size equals: 3.
	aBoard playCard: anAcelerationCard by:aPlayer1 targeting: NoTarget new. 
	self assert: (aBoard cardsOf:aPlayer1) size equals: 2.
	self assert: (aBoard cardsOf:aPlayer2) size equals: 2.
	
	self assert: (aBoard discardDeck) equals: ({CardAcceleration new}asOrderedCollection ).
	
	

]

{ #category : 'tests' }
FiniteDeckTest >> test7WhenACardCannotBePlayedThenItIsNotDiscarded [



	| aGameSetUp aDeckDistribution deckSize aPlayer1 aPlayer2 aDice initialCards  aTurnManager aDeck aBoard  anOverload |

	deckSize := 10.
	aDeckDistribution := DeckDistribution new .

	aDeckDistribution forOverload: 1.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 0.
	aDeckDistribution forCancellation: 0.
	aDeckDistribution forRepeat: 0.
	aDeckDistribution forRedo: 0.

	aGameSetUp := GameSetup new.

	initialCards:=aDeckDistribution build: deckSize.

	aDeck:=Deck withCards: initialCards.
	aGameSetUp assignsRandomly: aDeck .
	
	
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aGameSetUp withPlayers: { aPlayer1. aPlayer2 }.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1. aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	
	self assert: initialCards size equals:10.
	aGameSetUp createGameInstance.
	aBoard:=aGameSetUp board .
	anOverload:=CardOverLoad new.
	
	aBoard playNextTurn.
	self assert: (aBoard cardsOf:aPlayer1) size equals: 2.
	self should: [  aBoard playCard: anOverload by:aPlayer1 targeting: NoTarget new. ] raise: Error  withMessegeText:'Its not the spaceship turn'. 
	
	
	
	
	self assert: (aBoard cardsOf:aPlayer1) size equals: 2.
	self assert: (aBoard cardsOf:aPlayer2) size equals: 2.
	
	self assert: (aBoard discardDeck) equals: ({}asOrderedCollection ) .
	
	

]

{ #category : 'tests' }
FiniteDeckTest >> test8WhenSpaceShipFallsInBonusCardThenItTakesOneFromTheDeck [

	| aGameSetUp aDeckDistribution deckSize aPlayer1 aPlayer2 aDice initialCards aTurnManager aDeck aBoard aRepeat |
	deckSize := 10.
	aDeckDistribution := DeckDistribution new.

	aDeckDistribution forOverload: 0.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 0.
	aDeckDistribution forCancellation: 0.
	aDeckDistribution forRepeat: 1.
	aDeckDistribution forRedo: 0.

	aGameSetUp := GameSetup new.

	initialCards := aDeckDistribution build: deckSize.

	aDeck := Deck withCards: initialCards.
	aGameSetUp assignsRandomly: aDeck.


	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 1) }.
	self assert: initialCards size equals: 10.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aRepeat := CardRepeat new.
	aBoard playNextTurn.
	self assert: (aBoard cardsOf: aPlayer1) size equals: 3.

	self assert: aBoard deckOfCards equals: (Deck withCards: {
				 CardRepeat new.
				 CardRepeat new.
				 CardRepeat new.
				 CardRepeat new.
				 CardRepeat new } asOrderedCollection).

]

{ #category : 'tests' }
FiniteDeckTest >> test9WhenDeckIsEmptyThenDiscardDeckIsShuffledAndBecomesTheDeck [

	| aGameSetUp aDeckDistribution deckSize aPlayer1 aPlayer2 aDice initialCards aTurnManager aDeck aBoard aRepeat |
	deckSize := 4.
	aDeckDistribution := DeckDistribution new.

	aDeckDistribution forOverload: 0.
	aDeckDistribution forAlly: 0.
	aDeckDistribution forAcceleration: 0.
	aDeckDistribution forCancellation: 0.
	aDeckDistribution forRepeat: 1.
	aDeckDistribution forRedo: 0.

	aGameSetUp := GameSetup new.

	initialCards := aDeckDistribution build: deckSize.

	aDeck := Deck withCards: initialCards.
	aGameSetUp assignsRandomly: aDeck.


	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 1) }.
	
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aRepeat := CardRepeat new.
	
	aBoard playCard: aRepeat by:aPlayer2 targeting: NoTarget new.
	aBoard playCard: aRepeat by:aPlayer2 targeting: NoTarget new.
	
	self assert: aBoard deckOfCards size equals:0.
	self assert: aBoard discardDeck size equals:2.
	aBoard playNextTurn .
	self assert: aBoard deckOfCards size equals:1.
	self assert: aBoard discardDeck size equals:0.
	
	

	

]
