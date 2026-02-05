"
Reward Distribution 
"
Class {
	#name : 'RewardDistribution',
	#superclass : 'ProbabilityDistribution',
	#instVars : [
		'maximumFuelProbability',
		'decreaseFuelProbability'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RewardDistribution >> for: aSpaceShip with: dices [

	| reward nextRolledNumer maxRolledNumber |
	nextRolledNumer := (dices collect: [ :dice | dice numberJustRolled ])
		                   sum.
	maxRolledNumber := (dices collect: [ :dice | dice maximumFace ]) sum.

	nextRolledNumer = maxRolledNumber ifFalse: [ ^ self ].
	reward := self rewardFor: Random new next.
	reward applyTo: aSpaceShip
]

{ #category : 'building' }
RewardDistribution >> forDecreaseFuel: aProbability [

	decreaseFuelProbability := aProbability
]

{ #category : 'building' }
RewardDistribution >> forRestartFuel: aProbability [

	maximumFuelProbability := aProbability
]

{ #category : 'action' }
RewardDistribution >> rewardFor: aRandomProbability [

	aRandomProbability < maximumFuelProbability ifTrue: [
		^ RechargeFuelReward new ].
	aRandomProbability
	< (maximumFuelProbability + decreaseFuelProbability) ifTrue: [
		^ DecreaseFuelReward new ].

	^ NoReward new
]
