Class {
	#name : #TKTVariable,
	#superclass : #Object,
	#instVars : [
		'value',
		'mutex'
	],
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTVariable class >> for: aValue [
	^ self new set: aValue; yourself.
]

{ #category : #'as yet unclassified' }
TKTVariable >> apply: aBlock [
	| rslt |
	mutex critical: [
		rslt := aBlock value: value.
	].
	^ rslt.
]

{ #category : #'as yet unclassified' }
TKTVariable >> at: anObject [
	^ self get at: anObject .
]

{ #category : #'as yet unclassified' }
TKTVariable >> at: anObject put: anOtherObject [
	^ self get at: anObject put: anOtherObject.
]

{ #category : #'as yet unclassified' }
TKTVariable >> doesNotUnderstand: aMessage [ 
	| rslt |
	mutex critical: [
		rslt := value perform: aMessage selector withArguments: aMessage arguments
	].
	^ rslt 
	
]

{ #category : #'as yet unclassified' }
TKTVariable >> finalize [ 
	value finalize.
	super finalize.
	
]

{ #category : #'as yet unclassified' }
TKTVariable >> get [
	| val |
	mutex critical: [
		val := value.	
	].
	^ val.
]

{ #category : #'as yet unclassified' }
TKTVariable >> initialize [ 
	mutex := Mutex new.
]

{ #category : #'as yet unclassified' }
TKTVariable >> set: aValue [
	mutex critical: [
		value := aValue.	
	]
]

{ #category : #'as yet unclassified' }
TKTVariable >> value [
	^ self get value.
]
