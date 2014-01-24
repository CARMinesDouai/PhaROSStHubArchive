Class {
	#name : #TKTExclusiveAccessVariable,
	#superclass : #Object,
	#instVars : [
		'value',
		'mutex'
	],
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable class >> initialValue: aValue [
	^ self new set: aValue; yourself.
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> apply: aBlock [
	| rslt |
	mutex critical: [
		rslt := aBlock value: value.
	].
	^ rslt.
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> at: anObject [
	^ self get at: anObject .
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> at: anObject put: anOtherObject [
	^ self get at: anObject put: anOtherObject.
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> do: aBlock [
	| rslt |
	mutex critical: [
		rslt := aBlock value: value.
	].
	^ rslt.
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> doesNotUnderstand: aMessage [ 
	| rslt |
	mutex critical: [
		rslt := value perform: aMessage selector withArguments: aMessage arguments
	].
	^ rslt 
	
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> finalize [ 
	value finalize.
	super finalize.
	
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> get [
	| val |
	mutex critical: [
		val := value.	
	].
	^ val.
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> initialize [ 
	mutex := Mutex new.
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> set: aValue [
	mutex critical: [
		value := aValue.	
	]
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> value [
	^ self get value.
]
