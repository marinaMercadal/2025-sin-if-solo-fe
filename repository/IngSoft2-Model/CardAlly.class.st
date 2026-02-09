"
AllyCard

"
Class {
	#name : 'CardAlly',
	#superclass : 'Card',
	#instVars : [
		'spaceShipToTeamUp'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardAlly >> applyIEffectIn: aGame to: spaceshipMoving [

	spaceshipMoving formAllyWith: spaceShipToTeamUp
]

{ #category : 'action' }
CardAlly >> playedBy: aSpaceShip targeting: targetSpaceship in: aGame [

	spaceShipToTeamUp := targetSpaceship.
	aGame validateCanBePlayedBy: aSpaceShip.
	aGame playsPermanentCard: self
]

{ #category : 'action' }
CardAlly >> rollAdjustmentFor: aSpaceship [

	^ 0
]
