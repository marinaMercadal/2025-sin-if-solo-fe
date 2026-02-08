"
Class: Deck
"
Class {
	#name : 'Deck',
	#superclass : 'Object',
	#instVars : [
		'cardsInDeck',
		'discardDeck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initiali' }
Deck class >> withCards: cards [ 
	^self new initialzeDeckWith:cards
]

{ #category : 'comparing' }
Deck >> = anotherDeck [

cardsInDeck size = anotherDeck cards size ifFalse: [ ^ false ].

1 to: cardsInDeck size do: [ :i |
		((cardsInDeck at: i) class = (anotherDeck cards at: i) class)
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : 'testing' }
Deck >> canRefillFromDiscard [
	^ cardsInDeck isEmpty and: [ discardDeck isNotEmpty ]
	
]

{ #category : 'intention revealing' }
Deck >> cards [
	^cardsInDeck 
]

{ #category : 'accessing' }
Deck >> discarded [
^discardDeck 
]

{ #category : 'drawing' }
Deck >> draw [
self prepareForDraw.
cardsInDeck isEmpty ifTrue: [ self error: 'There are no aveilable cards to draw'].

^ cardsInDeck removeFirst
]

{ #category : 'initial' }
Deck >> initialzeDeckWith: cards [ 
	cardsInDeck:=cards.
	discardDeck:= {}asOrderedCollection 
]

{ #category : 'drawing' }
Deck >> prepareForDraw [

self canRefillFromDiscard ifTrue: [
		self refillFromDiscard ]


]

{ #category : 'action' }
Deck >> refillFromDiscard [
	cardsInDeck addAll: discardDeck.
    cardsInDeck shuffle.
    discardDeck removeAll.

	
]

{ #category : 'action' }
Deck >> shuffle [
cardsInDeck:=cardsInDeck shuffle 
]

{ #category : 'accessing' }
Deck >> size [
^cardsInDeck size
]

{ #category : 'adding' }
Deck >> usesCard:aCard [


discardDeck add:aCard.
]
