"
Board
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'maximumSquares',
		'sizeInParsec',
		'specialTiles',
		'lastSpecialTileEffect',
		'deck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Board class >> hasTheMinimumAmountOfSquares: aNumber [

	aNumber < 3 ifTrue: [ Error signal: 'Should have at least 3 squares' ]
]

{ #category : 'creation' }
Board class >> withNumberOfSquares: aNumberOfSquares
sizeInParsec: aSizeInParsec
deck: aDeck
tiles: someTiles [

    self hasTheMinimumAmountOfSquares: aNumberOfSquares.

    ^ self new
        initializeWithNumberOfSquares: aNumberOfSquares
        sizeInParsec: aSizeInParsec
        deck: aDeck
        tiles: someTiles

]

{ #category : 'action' }
Board >> applyEffectOfLastTileTo: spaceShip on: game [

	lastSpecialTileEffect applyEffectToSpecific: spaceShip on: self
]

{ #category : 'action' }
Board >> applySpecialTiletoA: spaceShip ofAll: spaceShips [

	lastSpecialTileEffect := self specialTileAt:
		                         spaceShip currentPosition.
	lastSpecialTileEffect
		applyConsequenceTo: spaceShips
		onBoardOfSize: self
]

{ #category : 'accessing' }
Board >> cardWasPlayed:aCard [

deck usesCard:aCard  .

]

{ #category : 'accessing' }
Board >> deckOfCards [
	^ deck
]

{ #category : 'accessing' }
Board >> discardDeck [
	^ deck discarded 
]

{ #category : 'action' }
Board >> distanceFrom: origin to: destination [

	^ (destination - origin) abs + maximumSquares rem: maximumSquares
]

{ #category : 'action' }
Board >> givesACardTo: aSpaceShip [
	aSpaceShip equipWith: deck draw


]

{ #category : 'initialization' }
Board >> initializeWithNumberOfSquares: aNumberOfSquares sizeInParsec: aSizeInParsec deck: aDeck tiles: someSpecialTiles [ 
	maximumSquares := aNumberOfSquares.
	sizeInParsec := aSizeInParsec.
	deck := aDeck.
	
	specialTiles := OrderedCollection new.
	lastSpecialTileEffect := NoEffect new.
	specialTiles := someSpecialTiles
]

{ #category : 'accessing' }
Board >> numberOfSquares [

	^ maximumSquares
]

{ #category : 'initialization' }
Board >> setLapsAndGetNewPositionFrom: totalPosition for: aSpaceShip [

	| lapsDone newPosition |
	lapsDone := totalPosition quo: maximumSquares.
	aSpaceShip actualLapsDone: lapsDone.
	newPosition := (totalPosition - 1 rem: maximumSquares) + 1.
	^ newPosition
]

{ #category : 'accessing' }
Board >> specialTileAt: position [

	^ specialTiles
		  detect: [ :tile | tile includesA: position ]
		  
]

{ #category : 'action' }
Board >> squaresInParsec: parsecsToMove [

	^ (parsecsToMove * maximumSquares / sizeInParsec) floor
]
