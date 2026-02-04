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

{ #category : 'instance creation' }
CancellationCard class >> for: aCard [

^self new initializationFor:aCard.
]

{ #category : 'action' }
CancellationCard >> appliedTo: targetSpaceship in: aGame [

aGame playsInstantaneousCard: self
]

{ #category : 'action' }
CancellationCard >> applyInstantaneousEffectIn:aGame [

	aGame remove: cardToCancel
]

{ #category : 'testing' }
CancellationCard >> canBePlayedIn:aGame [
^(aGame hasActiveCard: cardToCancel)
]

{ #category : 'action' }
CancellationCard >> changeTo: anImplementation [

	^ self class for: anImplementation  
]

{ #category : 'initialization' }
CancellationCard >> initializationFor: aCard [

	cardToCancel := aCard
]
