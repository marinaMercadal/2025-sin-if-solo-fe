"
GameSetUp
"
Class {
	#name : 'GameSetup',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'lapsToWin',
		'board',
		'spaceShips',
		'winnerSystem',
		'maximumRolledNumber',
		'boardSizeInParsec',
		'dices',
		'turnManager',
		'deckOfCards',
		'tiles',
		'rewardDistribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
GameSetup >> assignsInOrder: aDeckOfCards [

	deckOfCards := aDeckOfCards copy
]

{ #category : 'testing' }
GameSetup >> assignsRandomly: aDeckOfCards [

	aDeckOfCards shuffle.
	deckOfCards := aDeckOfCards copy
]

{ #category : 'accessing' }
GameSetup >> board [

	^ board
]

{ #category : 'creation' }
GameSetup >> buildGameWithDices: aDices spaceShips: aSpaceShips rules: aWinnerSystem [

	| aBoard aCopyOfSpaceships aGame |
	self initializeDefaults.

	aBoard := Board
		          withNumberOfSquares: boardSize
		          sizeInParsec: boardSizeInParsec
		          deck: deckOfCards
		          tiles: tiles.

	aCopyOfSpaceships := aSpaceShips collect: [ :each | each copy ].

	aGame := Game
		         onBoard: aBoard
		         withDices: aDices
		         spaceships: aCopyOfSpaceships
		         rules: aWinnerSystem
		         turnManager: turnManager
		         rewards: rewardDistribution.


	^ aGame
]

{ #category : 'creation' }
GameSetup >> createGameInstance [

	| aBoard aWinnerSystem |
	self createSpaceShipsInstance.
	aWinnerSystem := WinnerSystem withMaximunLaps: lapsToWin.

	aBoard := self
		          buildGameWithDices: dices
		          spaceShips: spaceShips
		          rules: aWinnerSystem.
	board := aBoard.
	winnerSystem := aWinnerSystem.
	self validateSpecialTileCreation
]

{ #category : 'creation' }
GameSetup >> createSpaceShipsInstance [

	deckOfCards ifNotNil: [
		spaceShips do: [ :spaceShip |
			| card1 card2 |
			card1 := deckOfCards first.
			deckOfCards remove: card1.

			card2 := deckOfCards first.
			deckOfCards remove: card2.

			spaceShip equipWith: card1.
			spaceShip equipWith: card2 ] ].

	spaceShips do: [ :spaceShip |
		spaceShip has: (Fuel withAnAmount: maximumRolledNumber * 2) ]
]

{ #category : 'action' }
GameSetup >> equip: aSpaceShip with: aCard [

	aSpaceShip equipWith: aCard
]

{ #category : 'action' }
GameSetup >> fillEmptyPositionsWithNoEffectTile [

	| occupiedPositions |
	occupiedPositions := tiles collect: [ :tile | tile position ] as: Set.

	0 to: boardSize do: [ :pos |
		(occupiedPositions includes: pos) ifFalse: [
			tiles add: (NoEffect in: pos) ] ]
]

{ #category : 'initialization' }
GameSetup >> initializeDefaults [
	
    boardSizeInParsec ifNil: [ boardSizeInParsec := boardSize ].
    tiles ifNil: [ tiles := OrderedCollection new ].
    deckOfCards ifNil: [ deckOfCards := OrderedCollection new ].
    rewardDistribution ifNil: [
        rewardDistribution := RewardDistribution new.
        rewardDistribution forDecreaseFuel: 0.
        rewardDistribution forRestartFuel: 0 ].
	self fillEmptyPositionsWithNoEffectTile.

]

{ #category : 'accessing' }
GameSetup >> maximumRollFromDices [

	| total |
	total := 0.
	dices do: [ :aDice | total := total + aDice numberOfFaces ].

	^ total
]

{ #category : 'validating' }
GameSetup >> validateSpecialTileCreation [

	tiles do: [ :specialTile |
		specialTile validateCreationIn: boardSize and: maximumRolledNumber ]
]

{ #category : 'accessing' }
GameSetup >> winnerSystem [

	^ winnerSystem
]

{ #category : 'initialization' }
GameSetup >> withABoardNumberOfSquares: numberOfSqueares andTurnManager: aTurnManager [

	boardSize := numberOfSqueares.
	turnManager := aTurnManager
]

{ #category : 'creation' }
GameSetup >> withARewardDistribution: aRewardDistribution [

	rewardDistribution := aRewardDistribution
]

{ #category : 'initialization' }
GameSetup >> withBoardsLengthInMetric: aBoardSizeInParsec [

	boardSizeInParsec := aBoardSizeInParsec asParsecs
]

{ #category : 'accessing' }
GameSetup >> withDices: someDices [

	dices := someDices.
	maximumRolledNumber := self maximumRollFromDices
]

{ #category : 'initialization' }
GameSetup >> withMaximumLapsToWin: aLapsToWin [

	lapsToWin := aLapsToWin
]

{ #category : 'creation' }
GameSetup >> withPlayers: someSpaceShips [

	spaceShips := someSpaceShips
]

{ #category : 'initialization' }
GameSetup >> withTiles: someTiles [

	tiles := someTiles asOrderedCollection
]
