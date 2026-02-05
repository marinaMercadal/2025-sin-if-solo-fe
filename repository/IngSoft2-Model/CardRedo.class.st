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

{ #category : 'adding' }
CardRedo >> playedBy:aSpaceShip targeting: aTarget in: aGame [


anInicialization := aTarget.
aGame playsRedoCard:aSpaceShip targeting:aTarget.

]
