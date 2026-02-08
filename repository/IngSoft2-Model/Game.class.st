"
game
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'turnManager',
		'rewardAsignation',
		'dicesInGameBoard',
		'spaceShips',
		'winnerSystem',
		'cardEffects'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> onBoard: aBoard
dices: someDices
spaceships: someSpaceShips
rules: aWinnerSystem
turnManager: aTurnManager
rewards: aRewardDistribution [

    ^ self new
        initializeWithBoard: aBoard
        dices: someDices
        spaceships: someSpaceShips
        rules: aWinnerSystem
        turnManager: aTurnManager
        rewards: aRewardDistribution

]

{ #category : 'action' }
Game >> applyRepeatEffectWith: aSpaceship [

	board applyEffectOfLastTileTo: aSpaceship on: self
]

{ #category : 'accessing' }
Game >> cardsOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) cardsInHand
]

{ #category : 'accessing' }
Game >> completedLapsBy: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentLap
]

{ #category : 'accessing' }
Game >> currentFuleOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentFule
]

{ #category : 'accessing' }
Game >> deckOfCards [
	^board deckOfCards  deepCopy 
]

{ #category : 'action' }
Game >> discardDeck [
	^board discardDeck deepCopy 
]

{ #category : 'action' }
Game >> handleRunOutOfFuleOf:spaceShip [

cardEffects handleRunOutOfFuleOf:spaceShip in:self.

]

{ #category : 'testing' }
Game >> hasActiveCard: aCard [

cardEffects hasActiveCard: aCard.

]

{ #category : 'initialization' }
Game >> initializeWithBoard: aBoard dices: someDices spaceships: someSpaceShips rules: aWinnerSystem turnManager: aTurnManager rewards: aRewardDistribution [ 
	board := aBoard.
	turnManager := aTurnManager.
	dicesInGameBoard := someDices.

	cardEffects :=CardEffects new.
	rewardAsignation := aRewardDistribution.
	spaceShips := someSpaceShips.
	winnerSystem := aWinnerSystem.
	winnerSystem withPotentialWinner: spaceShips
]

{ #category : 'action' }
Game >> move: aSpaceShip forwardBy: rolledNumber [

	| totalPosition newPosition |
	totalPosition := aSpaceShip currentPosition + rolledNumber.
	newPosition := board
		               setLapsAndGetNewPositionFrom: totalPosition
		               for: aSpaceShip.
	aSpaceShip moveTo: newPosition consuming: rolledNumber.
	aSpaceShip hasFule
]

{ #category : 'action' }
Game >> move: aSpaceShip with: dices [

	| rolledNumber  |
	winnerSystem thereIsAWinner ifTrue: [ ^ self ].

	
	rolledNumber := (self rolledNumberSumOf: dices ).
	
	(aSpaceShip canMoveWith: rolledNumber) ifFalse: [ ^ self ].
	self move: aSpaceShip forwardBy: (rolledNumber + (cardEffects rollAdjustmentFor: aSpaceShip)).
	
	board applySpecialTiletoA: aSpaceShip ofAll: spaceShips.
	cardEffects applyIEffectIn:self to:aSpaceShip .
	
	rewardAsignation for: aSpaceShip with: dices

   

]

{ #category : 'action' }
Game >> playCard: aCard by: aSpaceShip targeting: aTarget [

	aSpaceShip isEquipWith: aCard.

	aCard playedBy: aSpaceShip targeting: aTarget in: self.
	aSpaceShip removeFromHand: aCard.
	board cardWasPlayed: aCard
]

{ #category : 'action' }
Game >> playNextTurn [

	| spaceShip |
	spaceShip := self spaceShipMoving .
	turnManager updateTurn: spaceShips.
	spaceShip verifyCanPlayAgain.
	spaceShip canPlay
		ifTrue: [ self move: spaceShip with: dicesInGameBoard ]
		ifFalse: [
			
			spaceShip losesTwoRounds.
			spaceShip rechargeFule.
			spaceShip moveTo:0 consuming:0. 
			self handleRunOutOfFuleOf:spaceShip.
			]
]

{ #category : 'action' }
Game >> playsInstantaneousCard: aCard [
	|spaceShipMoving|
	spaceShipMoving:=self spaceShipMoving .
	aCard applyIEffectIn:self to:spaceShipMoving .
	cardEffects registerPlayedCard:aCard .


	

  

]

{ #category : 'action' }
Game >> playsPermanentCard: aCard [ 
	

	cardEffects add: aCard.
	
	

]

{ #category : 'action' }
Game >> playsRedoCard: anInicialization targeting: targetSpaceship [

	cardEffects redoLastCardPlayedBy: anInicialization targeting: targetSpaceship in: self.

]

{ #category : 'accessing' }
Game >> positionOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentPosition
]

{ #category : 'removing' }
Game >> remove: cardToCancel [

	cardEffects remove: cardToCancel
]

{ #category : 'accessing' }
Game >> rolledNumberSumOf: dices [

	^ (dices collect: [ :dice | dice rolledNumber ]) sum
]

{ #category : 'action' }
Game >> skipNextTurn [

	| spaceShip |
	spaceShip := self spaceShipMoving .
	turnManager updateTurn: spaceShips.
	spaceShip losesOneRound.
	spaceShip rechargeFule
]

{ #category : 'accessing' }
Game >> spaceShipMatching: aSpaceShip [

	^ spaceShips detect: [ :each | each = aSpaceShip ]
]

{ #category : 'accessing' }
Game >> spaceShipMoving [
^ turnManager spaceShipWhoseTurnItIsFrom: spaceShips .
]

{ #category : 'testing' }
Game >> validateCanBePlayedBy:aSpaceShip [

(turnManager isMoving:aSpaceShip )ifFalse: [Error signal: 'Its not the spaceship turn' ].
]
