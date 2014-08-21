Class {
	#name : #Fruit,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'stage'
	],
	#category : #'Equals-Example'
}

{ #category : #staging }
Fruit >> beRipe [
	stage := #ripe
]

{ #category : #staging }
Fruit >> beRotten [
	stage := #rotten
]

{ #category : #staging }
Fruit >> beUnripe [
	stage := #unripe
]

{ #category : #accessing }
Fruit >> color [
	^self subclassResponsibility
]

{ #category : #'initialize - release' }
Fruit >> initialize [
	super initialize.
	self beUnripe
]
