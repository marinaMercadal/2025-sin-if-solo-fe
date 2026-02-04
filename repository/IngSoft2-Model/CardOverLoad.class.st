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

{ #category : 'instance creation' }
CardOverLoad class >> for: aSpaceShip [

	^ self new initializeOverLoadFor: aSpaceShip
]

{ #category : 'action' }
CardOverLoad >> appliedTo: targetSpaceship in: aGame [


     aGame playsPermanentCard: self

]

{ #category : 'action' }
CardOverLoad >> applyInstantaneousEffectIn:aGame [

]

{ #category : 'action' }
CardOverLoad >> changeTo: anImplementation [

	^ self class for: anImplementation
]

{ #category : 'initialization' }
CardOverLoad >> initializeOverLoadFor: aSpaceShip [

	spaceShipToOverLoad := aSpaceShip
]

{ #category : 'action' }
CardOverLoad >> rollAdjustmentFor: aSpaceship [
^ aSpaceship = spaceShipToOverLoad
        ifTrue: [ -2 ]
        ifFalse: [ 0 ]
]
