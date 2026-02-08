"
Class: DeckDistribution

"
Class {
	#name : 'DeckDistribution',
	#superclass : 'ProbabilityDistribution',
	#instVars : [
		'overloadProbability',
		'allyProbability',
		'accelerationProbability',
		'cancellationProbability',
		'repeatProbability',
		'redoProbability',
		'nitroProbability'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
DeckDistribution >> cardFor: aRandomProbability [
	| accumulated |

	accumulated := overloadProbability.
	aRandomProbability < accumulated ifTrue: [ ^ CardOverLoad new ].

	accumulated := accumulated + allyProbability.
	aRandomProbability < accumulated ifTrue: [ ^ CardAlly new ].

	accumulated := accumulated + accelerationProbability.
	aRandomProbability < accumulated ifTrue: [ ^ CardAcceleration new ].

	accumulated := accumulated + cancellationProbability.
	aRandomProbability < accumulated ifTrue: [ ^ CancellationCard new ].

	accumulated := accumulated + repeatProbability.
	aRandomProbability < accumulated ifTrue: [ ^ CardRepeat new ].

	accumulated := accumulated + redoProbability.
	aRandomProbability < accumulated ifTrue: [ ^ CardRedo new ].

	self error: 'Deck probabilities do not sum to 1'

]

{ #category : 'accessing' }
DeckDistribution >> elementFor: aRandomProbability [
	^ self cardFor: aRandomProbability


]

{ #category : 'initialization' }
DeckDistribution >> forAcceleration: aProbability [ 
	accelerationProbability:=aProbability
]

{ #category : 'initialization' }
DeckDistribution >> forAlly: aProbability [ 
	allyProbability:=aProbability
]

{ #category : 'initialization' }
DeckDistribution >> forCancellation: aProbability [ 
	cancellationProbability:=aProbability
]

{ #category : 'initialization' }
DeckDistribution >> forOverload: aProbability [ 
	overloadProbability:=aProbability
]

{ #category : 'initialization' }
DeckDistribution >> forRedo: aProbability [ 
	redoProbability:=aProbability
]

{ #category : 'initialization' }
DeckDistribution >> forRepeat: aProbability [ 
	repeatProbability:=aProbability
]
