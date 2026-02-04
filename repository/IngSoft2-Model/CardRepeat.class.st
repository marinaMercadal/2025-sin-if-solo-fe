"
Repeta Card

"
Class {
	#name : 'CardRepeat',
	#superclass : 'Card',
	#instVars : [
		'spaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardRepeat class >> for: aSpaceShip [

	^ self new initializationFor: aSpaceShip
]

{ #category : 'action' }
CardRepeat >> appliedTo: targetSpaceship in: aGame [

aGame playsInstantaneousCard: self 
]

{ #category : 'action' }
CardRepeat >> applyInstantaneousEffectIn:aGame [

	aGame applyRepeatEffectWith: spaceship


	
]

{ #category : 'testing' }
CardRepeat >> canBePlayedIn:aGame [
^true
]

{ #category : 'initialization' }
CardRepeat >> initializationFor: aSpaceship [

	spaceship := aSpaceship
]
