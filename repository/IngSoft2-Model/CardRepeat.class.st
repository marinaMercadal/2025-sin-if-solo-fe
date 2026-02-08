"
Repeta Card

"
Class {
	#name : 'CardRepeat',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardRepeat >> applyIEffectIn:aGame to:spaceshipMoving [

	aGame applyRepeatEffectWith: spaceshipMoving.


	
]

{ #category : 'testing' }
CardRepeat >> canBePlayedIn:aGame [
^true
]

{ #category : 'action' }
CardRepeat >> playedBy:aSpaceShip targeting: aTargetSpaceShip in: aGame [

aGame playsInstantaneousCard: self 
]
