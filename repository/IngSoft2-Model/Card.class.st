"
class card
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Card >> appliedTo: targetSpaceship in: aGame [ 
	^ self subclassResponsibility
]
