Class {
	#name : #RrVectorDisplayLayer,
	#superclass : #RrVectorDisplayConfig,
	#instVars : [
		'vectors'
	],
	#category : #'ReactiveRobot-Demo'
}

{ #category : #displaying }
RrVectorDisplayLayer >> drawOn: display [
	self setUp: display.
	self vectors do: [ : vector |
		display draw: vector
	]
]

{ #category : #'initialize-release' }
RrVectorDisplayLayer >> initialize [
	super initialize.
	self vectors: #().

]

{ #category : #accessing }
RrVectorDisplayLayer >> vectors [
	^ vectors
]

{ #category : #accessing }
RrVectorDisplayLayer >> vectors: anObject [
	vectors := anObject
]
