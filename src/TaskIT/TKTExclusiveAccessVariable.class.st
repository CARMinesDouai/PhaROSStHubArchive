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

	^ mutex critical: [ aBlock value: value ].

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

	^ mutex critical: [ aBlock value: value ].
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> doesNotUnderstand: aMessage [ 

	^ mutex critical: [ value perform: aMessage selector withArguments: aMessage arguments ].
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> finalize [ 
	value finalize.
	super finalize.
	
]

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable >> get [
	mutex critical: [ ^ value ]
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
