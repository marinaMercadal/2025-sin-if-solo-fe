"
RestartFuelReward class
"
Class {
	#name : 'RechargeFuelReward',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
RechargeFuelReward >> applyTo: aSpaceShip [
	
	aSpaceShip increaseFuelCapacityBy:1.
	"aSpaceShip rechargeFule"
]
