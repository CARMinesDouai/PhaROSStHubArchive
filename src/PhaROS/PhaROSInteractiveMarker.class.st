Class {
	#name : #PhaROSInteractiveMarker,
	#superclass : #Object,
	#instVars : [
		'marker',
		'isDirty'
	],
	#category : #'PhaROS-Nodelets-InteractiveMarker'
}

{ #category : #'as yet unclassified' }
PhaROSInteractiveMarker >> initialize [ 
	self setAsDirty
]

{ #category : #'as yet unclassified' }
PhaROSInteractiveMarker >> isDirty [ 
	^ isDirty
]

{ #category : #'as yet unclassified' }
PhaROSInteractiveMarker >> marker [ 
	^ marker 
]

{ #category : #'as yet unclassified' }
PhaROSInteractiveMarker >> marker: anInteractiveMarker [
	marker := anInteractiveMarker 
]

{ #category : #'as yet unclassified' }
PhaROSInteractiveMarker >> setAsDirty [
	isDirty := true.
]
