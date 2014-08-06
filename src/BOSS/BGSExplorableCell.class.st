"
I am a cell in an explorable grid. I can be in two states: explored or unexplored (see IV state). Initially, I am unexplored, but when my content is set, I become explored. However, my state can be directly set using messages: markExplored and markUnexplored

Instance Variables:
	state	<BGSExplorableCellState> support for the State design pattern
"
Class {
	#name : #BGSExplorableCell,
	#superclass : #BGSCell,
	#instVars : [
		'state'
	],
	#category : #'BOSS-Exploration'
}

{ #category : #visiting }
BGSExplorableCell >> acceptVisitor: aVisitor [
	self state acceptVisitor: aVisitor
]

{ #category : #accessing }
BGSExplorableCell >> content: anObject [
	super content: anObject.
	self markExplored
]

{ #category : #'initialize-release' }
BGSExplorableCell >> defaultColor [
	^ Color green
]

{ #category : #'initialize-release' }
BGSExplorableCell >> initialize [ 
	super initialize.
	self state: BGSUnexploredCellState new 
]

{ #category : #testing }
BGSExplorableCell >> isExplored [
	^self state isExplored
]

{ #category : #testing }
BGSExplorableCell >> isFrontier [
	self isExplored ifFalse: [^false].
	self isEmpty ifFalse: [^false].
	^self neighbors anySatisfy: [:aCell| aCell isExplored not]
]

{ #category : #annotating }
BGSExplorableCell >> markExplored [ 
	self state markExplored
]

{ #category : #annotating }
BGSExplorableCell >> markUnexplored [
	self state markUnexplored
]

{ #category : #accessing }
BGSExplorableCell >> neighbors [ 
	^self grid cellsAround: self
]

{ #category : #printing }
BGSExplorableCell >> printOn: aStream [
	self isExplored ifFalse: [^aStream nextPutAll: #unexplored].
	super printOn: aStream
]

{ #category : #accessing }
BGSExplorableCell >> state [
	^ state
]

{ #category : #accessing }
BGSExplorableCell >> state: mapcellState [
	state := mapcellState.
	mapcellState cell: self
]
