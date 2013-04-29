Class {
	#name : #PhaROSFilter,
	#superclass : #Object,
	#instVars : [
		'property'
	],
	#category : #'PhaROS-MessageAdapter'
}

{ #category : #'as yet unclassified' }
PhaROSFilter class >> for: aProperty [
	^ self new property: aProperty; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> adapt: aPhaROSValue [ 
	^ aPhaROSValue getAt: property.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> adaptToAdapter [ 
	 ^ self
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> printOn: aStream [
	property printOn: aStream.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> property: aProperty [ 
	property := aProperty
]
