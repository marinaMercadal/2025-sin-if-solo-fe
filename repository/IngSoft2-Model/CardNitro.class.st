"
Class:CardNitro
"
Class {
	#name : 'CardNitro',
	#superclass : 'Card',
	#instVars : [
		'aSpaceShipToEnhance',
		'spaceShipMoving',
		'remainingTurns'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardNitro >> applyInstantaneousEffectIn:aGame [

(spaceShipMoving = aSpaceShipToEnhance) ifTrue: [
        remainingTurns := remainingTurns - 1
    ].
(remainingTurns =0)ifTrue: [ aGame remove:self ]
]

{ #category : 'testing' }
CardNitro >> canBePlayedIn:aGame [
^true

]

{ #category : 'action' }
CardNitro >> playedBy:aSpaceShip targeting: targetSpaceShip in: aGame [


aSpaceShipToEnhance:=targetSpaceShip .
remainingTurns:=3.
aGame playsPermanentCard: self.

]

{ #category : 'action' }
CardNitro >> rollAdjustmentFor: aSpaceShip [
	spaceShipMoving :=aSpaceShip.
	(aSpaceShip = aSpaceShipToEnhance and: remainingTurns >= 0) ifTrue: [ ^ 3].
^ 0

]
