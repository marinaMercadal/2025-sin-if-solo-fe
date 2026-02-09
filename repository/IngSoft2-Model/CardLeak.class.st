"
Class: CardLeak
"
Class {
	#name : 'CardLeak',
	#superclass : 'Card',
	#instVars : [
		'spaceShipToAffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardLeak >> applyIEffectIn: aGame to: spaceshipMoving [

	spaceshipMoving = spaceShipToAffect ifFalse: [ ^ self ].
	spaceShipToAffect consumesFule.
	spaceShipToAffect consumesFule
]

{ #category : 'action' }
CardLeak >> handleRunOutOfFuleOf: spaceShip in: aGame [

	spaceShip = spaceShipToAffect ifTrue: [ aGame remove: self ]
]

{ #category : 'action' }
CardLeak >> playedBy: aSpaceShip targeting: aTarget in: aGame [

	spaceShipToAffect := aTarget.
	aGame playsPermanentCard: self
]

{ #category : 'action' }
CardLeak >> rollAdjustmentFor: aSpaceShip [

	^ 0
]
