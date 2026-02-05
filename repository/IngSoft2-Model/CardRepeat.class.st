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

{ #category : 'action' }
CardRepeat >> applyInstantaneousEffectIn:aGame [

	aGame applyRepeatEffectWith: spaceship


	
]

{ #category : 'testing' }
CardRepeat >> canBePlayedIn:aGame [
^true
]

{ #category : 'action' }
CardRepeat >> playedBy:aSpaceShip targeting: aTargetSpaceShip in: aGame [
spaceship := aSpaceShip.

aGame playsInstantaneousCard: self 
]
