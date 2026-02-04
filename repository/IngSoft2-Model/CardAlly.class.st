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

{ #category : 'initialization' }
CardAlly class >> teamsUpWith: aSpaceShip [

	^ self new initializeAllyCardTeamsUpWith: aSpaceShip
]

{ #category : 'action' }
CardAlly >> appliedTo: targetSpaceship in: aGame [

    aGame playsPermanentCard: self 
 
]

{ #category : 'action' }
CardAlly >> applyInstantaneousEffectIn:aGame [

	aGame formsAlianceWith:spaceShipToTeamUp.

]

{ #category : 'action' }
CardAlly >> changeTo: anImplementation [

	^ self class teamsUpWith: anImplementation
]

{ #category : 'initialization' }
CardAlly >> initializeAllyCardTeamsUpWith: aSpaceShip [

	spaceShipToTeamUp := aSpaceShip
]

{ #category : 'action' }
CardAlly >> rollAdjustmentFor: aSpaceship [
    ^ 0

]
