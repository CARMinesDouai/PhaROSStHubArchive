Class {
	#name : #TKTExclusiveAccessVariable,
	#superclass : #Object,
	#instVars : [
		'value',
		'mutex',
		'aquiredBy'
	],
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTExclusiveAccessVariable class >> initialValue: aValue [
	^ self new set: aValue; yourself.
]

{ #category : #'mutual exclusion - explicit' }
TKTExclusiveAccessVariable >> apply: aBlock [

	^ self do: aBlock.

]

{ #category : #'mutual exclusion - proxy' }
TKTExclusiveAccessVariable >> at: anObject [
	^ self get at: anObject .
]

{ #category : #'mutual exclusion - proxy' }
TKTExclusiveAccessVariable >> at: anObject put: anOtherObject [
	^ self get at: anObject put: anOtherObject.
]

{ #category : #'mutual exclusion - explicit' }
TKTExclusiveAccessVariable >> do: aBlock [

	^ mutex critical: [ aBlock value: value ].
]

{ #category : #'mutual exclusion - proxy' }
TKTExclusiveAccessVariable >> doesNotUnderstand: aMessage [ 

	^ mutex critical: [ value perform: aMessage selector withArguments: aMessage arguments ].
]

{ #category : #finalization }
TKTExclusiveAccessVariable >> finalize [ 
	value finalize.
	super finalize.
	
]

{ #category : #'mutual exclusion - explicit' }
TKTExclusiveAccessVariable >> get [
	mutex critical: [ ^ value ]
]

{ #category : #'initialize-release' }
TKTExclusiveAccessVariable >> initialize [ 
	mutex := Mutex new.
]

{ #category : #'mutual exclusion - explicit' }
TKTExclusiveAccessVariable >> set: aValue [
	mutex critical: [
		value := aValue.	
	]
]

{ #category : #'mutual exclusion - proxy' }
TKTExclusiveAccessVariable >> value [
	^ self get value.
]
