"
Class: Deck
"
Class {
	#name : 'Deck',
	#superclass : 'Object',
	#instVars : [
		'cardsInDeck'
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

{ #category : 'adding' }
Deck >> add:aCard [
cardsInDeck add:aCard 

]

{ #category : 'intention revealing' }
Deck >> cards [
	^cardsInDeck 
]

{ #category : 'drawing' }
Deck >> draw [
^ cardsInDeck removeFirst
]

{ #category : 'initial' }
Deck >> initialzeDeckWith: cards [ 
	cardsInDeck:=cards
]

{ #category : 'action' }
Deck >> shuffle [
cardsInDeck:=cardsInDeck shuffle 
]
