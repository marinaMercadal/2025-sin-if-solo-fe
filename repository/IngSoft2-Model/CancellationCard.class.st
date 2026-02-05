"
ccccancellationnn
"
Class {
	#name : 'CancellationCard',
	#superclass : 'Card',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CancellationCard >> applyInstantaneousEffectIn:aGame [

	aGame remove: cardToCancel
]

{ #category : 'testing' }
CancellationCard >> canBePlayedIn:aGame [
^(aGame hasActiveCard: cardToCancel)
]

{ #category : 'action' }
CancellationCard >> playedBy:aSpaceShip targeting: aCard in: aGame [
cardToCancel:=aCard .
aGame playsInstantaneousCard: self
]
