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
CardAlly >> applyInstantaneousEffectIn:aGame [

	aGame formsAlianceWith:spaceShipToTeamUp.

]

{ #category : 'action' }
CardAlly >> playedBy:aSpaceShip targeting: targetSpaceship in: aGame [

spaceShipToTeamUp := targetSpaceship.
    aGame playsPermanentCard: self 
 
]

{ #category : 'action' }
CardAlly >> rollAdjustmentFor: aSpaceship [
    ^ 0

]
