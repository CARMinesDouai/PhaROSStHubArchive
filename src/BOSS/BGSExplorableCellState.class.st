"
I am the state of an BGSExplorableCell.

Concrete subclasses should implement:
-acceptVisitor: visitor
	Double dispatch for the visitor design pattern
-isExplored
	Answers true if I am an explored state. Answers false otherwise.
-markExplored
	Switch to explored state.
-markUnexplored
	Switch to unexplored state
 
Instance Variables:
	cell	<BGSExplorableCell> cell for which I am the state
"
Class {
	#name : #BGSExplorableCellState,
	#superclass : #Object,
	#instVars : [
		'cell'
	],
	#category : #'BOSS-Exploration'
}

{ #category : #'as yet unclassified' }
BGSExplorableCellState >> acceptVisitor: visitor [
	self subclassResponsibility 
]

{ #category : #accessing }
BGSExplorableCellState >> cell [
	^ cell
]

{ #category : #accessing }
BGSExplorableCellState >> cell: anObject [
	cell := anObject
]

{ #category : #'as yet unclassified' }
BGSExplorableCellState >> isExplored [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
BGSExplorableCellState >> markExplored [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
BGSExplorableCellState >> markUnexplored [
	self subclassResponsibility 
]
