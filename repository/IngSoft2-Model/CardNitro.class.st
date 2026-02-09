"
Class:CardNitro
"
Class {
	#name : 'CardNitro',
	#superclass : 'Card',
	#instVars : [
		'aSpaceShipToEnhance',
		'remainingTurns'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardNitro >> applyIEffectIn: aGame to: spaceshipMoving [

	spaceshipMoving = aSpaceShipToEnhance ifTrue: [
		remainingTurns := remainingTurns - 1 ].
	remainingTurns = 0 ifTrue: [ aGame remove: self ]
]

{ #category : 'action' }
CardNitro >> playedBy: aSpaceShip targeting: targetSpaceShip in: aGame [

	aSpaceShipToEnhance := targetSpaceShip.
	remainingTurns := 3.
	aGame playsPermanentCard: self
]

{ #category : 'action' }
CardNitro >> rollAdjustmentFor: aSpaceShip [

	(aSpaceShip = aSpaceShipToEnhance and: remainingTurns >= 0) ifTrue: [
		^ 3 ].
	^ 0
]
