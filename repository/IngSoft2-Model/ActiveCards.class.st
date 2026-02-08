"
Class: ActiveCards
"
Class {
	#name : 'ActiveCards',
	#superclass : 'Object',
	#instVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ActiveCards >> add:aCard [
cards add:aCard 
]

{ #category : 'action' }
ActiveCards >> applyIEffectIn: aGame to: aSpaceShip [ 
	
	cards do: [ :card |
		card applyIEffectIn:aGame to:aSpaceShip  ].
]

{ #category : 'action' }
ActiveCards >> handleRunOutOfFuleOf: aSpaceShip in: aGame [ 
	cards do:[:card|card handleRunOutOfFuleOf:aSpaceShip in:aGame ].
]

{ #category : 'testing' }
ActiveCards >> includes: aCard [
^cards includes: aCard
]

{ #category : 'initialization' }
ActiveCards >> initialize [ 
cards:={}asOrderedCollection 
]

{ #category : 'removing' }
ActiveCards >> remove: aCard [ 
	cards remove:aCard 
]

{ #category : 'action' }
ActiveCards >> rollAdjustmentFor: aSpaceShip [ 
	^cards sum: [ :card |
        card rollAdjustmentFor: aSpaceShip
    ]
]
