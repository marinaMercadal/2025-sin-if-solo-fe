"
RedoCard
"
Class {
	#name : 'CardRedo',
	#superclass : 'Card',
	#instVars : [
		'anInicialization'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardRedo class >> for: aSpaceShip [

	^ self new initializationFor: aSpaceShip
]

{ #category : 'adding' }
CardRedo >> addEffectRepetedTo: aBoard by: spaceShip the: lastCardPlay [

	| aCard |
	aCard := lastCardPlay changeTo: anInicialization.

	spaceShip equipWith: aCard.
	aBoard with: spaceShip throws: aCard
]

{ #category : 'adding' }
CardRedo >> appliedTo: targetSpaceship in: aGame [

aGame redoLastCardWith:anInicialization targeting:targetSpaceship.

]

{ #category : 'initialization' }
CardRedo >> initializationFor: aSpaceShip [

	anInicialization := aSpaceShip
]
