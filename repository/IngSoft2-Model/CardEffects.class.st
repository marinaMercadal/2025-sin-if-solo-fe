"
Class: ActiveCards
"
Class {
	#name : 'CardEffects',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'lastCardPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardEffects >> add:aCard [
cards add:aCard .
self registerPlayedCard: aCard .
]

{ #category : 'action' }
CardEffects >> applyIEffectIn: aGame to: aSpaceShip [ 
	
	cards do: [ :card |
		card applyIEffectIn:aGame to:aSpaceShip  ].
]

{ #category : 'testing' }
CardEffects >> borrarincludes: aCard [
"^cards includes: aCard"
]

{ #category : 'action' }
CardEffects >> handleRunOutOfFuleOf: aSpaceShip in: aGame [ 
	cards do:[:card|card handleRunOutOfFuleOf:aSpaceShip in:aGame ].
]

{ #category : 'testing' }
CardEffects >> hasActiveCard: aCard [

(cards includes:aCard )ifFalse: [ 
        Error signal: 'That card is not being played'].
]

{ #category : 'initialization' }
CardEffects >> initialize [ 
super initialize.
cards:={}asOrderedCollection .

]

{ #category : 'action' }
CardEffects >> redoLastCardPlayedBy: anInicialization targeting: targetSpaceship in: aGame [ 
	| newCardToRedo |
	newCardToRedo := lastCardPlayed copy.

	newCardToRedo
		playedBy: anInicialization
		targeting: targetSpaceship
		in: aGame
]

{ #category : 'action' }
CardEffects >> registerPlayedCard:aCard [
lastCardPlayed :=aCard .
]

{ #category : 'removing' }
CardEffects >> remove: aCard [ 
	cards remove:aCard 
]

{ #category : 'action' }
CardEffects >> rollAdjustmentFor: aSpaceShip [ 
	^cards sum: [ :card |
        card rollAdjustmentFor: aSpaceShip
    ]
]
