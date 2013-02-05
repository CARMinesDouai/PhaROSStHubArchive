Class {
	#name : #TKTReference,
	#superclass : #Object,
	#instVars : [
		'reference'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTReference class >> for: anObject [
	^ self new set: anObject; yourself.
]

{ #category : #'as yet unclassified' }
TKTReference >> get [
	^ reference
]

{ #category : #'as yet unclassified' }
TKTReference >> initialize [ 
	super initialize.
	self toFinalizeSend: #value: to: [ :p | reference finalize ] with: { true}.
]

{ #category : #'as yet unclassified' }
TKTReference >> set: aValue [ 
	reference := aValue.
]
