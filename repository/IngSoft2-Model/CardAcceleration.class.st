"
A
"
Class {
	#name : 'CardAcceleration',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardAcceleration >> applyIEffectIn:aGame to:spaceshipMoving [

	

]

{ #category : 'action' }
CardAcceleration >> changeTo: anImplementation [

	^ self

]

{ #category : 'action' }
CardAcceleration >> playedBy:aSpaceShip targeting: aCard in: aGame [

	aGame validateCanBePlayed.
   aGame playsPermanentCard: self

]

{ #category : 'action' }
CardAcceleration >> rollAdjustmentFor: aSpaceship [
    ^ 1


]
