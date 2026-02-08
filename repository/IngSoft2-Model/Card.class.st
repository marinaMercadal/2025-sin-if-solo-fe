"
class card
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Card >> = anotherCard [
 ^ self class = anotherCard class
]

{ #category : 'action' }
Card >> handleRunOutOfFuleOf:spaceShip in:aGame [

]
