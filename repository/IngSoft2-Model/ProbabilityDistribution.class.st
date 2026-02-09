"
Probability Distribution Class
"
Class {
	#name : 'ProbabilityDistribution',
	#superclass : 'Object',
	#instVars : [
		'generatedElements'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
ProbabilityDistribution >> build: aSampleSize [

	generatedElements := (1 to: aSampleSize) collect: [ :i |
		                     self elementFor: Random new next ].
	^ generatedElements asOrderedCollection
]

{ #category : 'accessing' }
ProbabilityDistribution >> elementFor: aRandomProbability [

	self subclassResponsibility
]

{ #category : 'accessing' }
ProbabilityDistribution >> percentageOf: aClass [

	^ (generatedElements count: [ :each | each isKindOf: aClass ])
	  / generatedElements size asFloat
]
