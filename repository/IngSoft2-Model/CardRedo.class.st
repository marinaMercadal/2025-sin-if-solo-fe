"
RedoCard
"
Class {
	#name : 'CardRedo',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardRedo >> playedBy: aSpaceShip targeting: aTarget in: aGame [

	aGame playsRedoCard: aSpaceShip targeting: aTarget
]
