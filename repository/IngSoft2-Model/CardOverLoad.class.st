"
OverLoad Card

"
Class {
	#name : 'CardOverLoad',
	#superclass : 'Card',
	#instVars : [
		'spaceShipToOverLoad'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardOverLoad >> applyIEffectIn:aGame to:spaceshipMoving [

]

{ #category : 'action' }
CardOverLoad >> playedBy:aSpaceShip targeting: targetSpaceship in: aGame [

spaceShipToOverLoad:=targetSpaceship.
aGame validateCanBePlayedBy:aSpaceShip.
aGame playsPermanentCard: self
]

{ #category : 'action' }
CardOverLoad >> rollAdjustmentFor: aSpaceship [
^ aSpaceship = spaceShipToOverLoad
        ifTrue: [ -2 ]
        ifFalse: [ 0 ]
]
