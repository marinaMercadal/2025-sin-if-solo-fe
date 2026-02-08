"
Class Tile Distribution
"
Class {
	#name : 'TileDistribution',
	#superclass : 'ProbabilityDistribution',
	#instVars : [
		'noEffectProbability',
		'blackHoleProbability',
		'hyperGravityProbability',
		'moonWalkProbabilty',
		'hyperJumpProbability',
		'atomicBombProability',
		'bonusCardProbability'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
TileDistribution class >> withABoardNumberOfSquares: aNumberOfTiles [

^self new initializeWithABoardSize: aNumberOfTiles.
]

{ #category : 'accessing' }
TileDistribution >> build: aSize [
    self theSumIsOne.
    ^ super build: aSize

]

{ #category : 'accessing' }
TileDistribution >> elementFor: aRandomProbability [
    ^ self tileFor: aRandomProbability

]

{ #category : 'initialization' }
TileDistribution >> forAtomicBomb: aProbability [

	atomicBombProability := aProbability
]

{ #category : 'initialization' }
TileDistribution >> forBlackHole: aProbability [

	blackHoleProbability := aProbability
]

{ #category : 'initialization' }
TileDistribution >> forBonusCard: aBonusCardProbability [

	bonusCardProbability := aBonusCardProbability
]

{ #category : 'initialization' }
TileDistribution >> forHyperGravity: aProbability [

	hyperGravityProbability := aProbability
]

{ #category : 'initialization' }
TileDistribution >> forHyperJump: aProbability [

	hyperJumpProbability := aProbability
]

{ #category : 'initialization' }
TileDistribution >> forMoonWalk: aProbability [

	moonWalkProbabilty := aProbability
]

{ #category : 'initialization' }
TileDistribution >> forNoEffect: aProbability [

	noEffectProbability := aProbability
]

{ #category : 'initialization' }
TileDistribution >> initializeWithABoardSize: aNumberOfTiles [

	
	noEffectProbability := 0.
	blackHoleProbability := 0.
	hyperGravityProbability := 0.
	moonWalkProbabilty := 0.
	hyperJumpProbability := 0.
	atomicBombProability := 0.
	bonusCardProbability := 0
]

{ #category : 'verification' }
TileDistribution >> theSumIsOne [

	| sumOfProbabilites |
	sumOfProbabilites := (noEffectProbability + blackHoleProbability
	                      + hyperGravityProbability + moonWalkProbabilty
	                      + hyperJumpProbability + atomicBombProability
	                      + bonusCardProbability) ceiling.

	sumOfProbabilites = 1 ifFalse: [
		Error signal: 'The Sum Of All Probabilities should be 1' ]
]

{ #category : 'creation' }
TileDistribution >> tileFor: randomProbability [

	| accumulated |
	accumulated := atomicBombProability.
	randomProbability < accumulated ifTrue: [ ^ AtomicBomb new ].
	accumulated := accumulated + hyperJumpProbability.
	randomProbability < accumulated ifTrue: [ ^ HyperJump new ].
	accumulated := accumulated + moonWalkProbabilty.
	randomProbability < accumulated ifTrue: [ ^ MoonWalk new ].
	accumulated := accumulated + hyperGravityProbability.
	randomProbability < accumulated ifTrue: [ ^ HyperGravity new ].
	accumulated := accumulated + blackHoleProbability.
	randomProbability < accumulated ifTrue: [ ^ BlackHole new ].
	accumulated := accumulated + bonusCardProbability.
	randomProbability < accumulated ifTrue: [ ^ BonusCard new ].
	^ NoEffect new
]
