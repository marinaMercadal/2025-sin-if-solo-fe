"
A
"
Class {
	#name : 'CardAcceleration',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
CardAcceleration class >> isPositive: aNumber [

	aNumber < 0 ifTrue: [
		Error signal: 'A CardAcceleration has to have a positive increment' ]
]

{ #category : 'action' }
CardAcceleration >> appliedTo: targetSpaceship in: aGame [


     aGame playsPermanentCard: self

]

{ #category : 'action' }
CardAcceleration >> applyInstantaneousEffectIn:aGame [

	

]

{ #category : 'action' }
CardAcceleration >> changeTo: anImplementation [

	^ self

]

{ #category : 'action' }
CardAcceleration >> rollAdjustmentFor: aSpaceship [
    ^ 1


]
