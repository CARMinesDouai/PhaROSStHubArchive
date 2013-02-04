Class {
	#name : #TKTVariable,
	#superclass : #Object,
	#instVars : [
		'value',
		'mutex'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTVariable class >> for: aValue [
	^ self new set: aValue; yourself.
]

{ #category : #'as yet unclassified' }
TKTVariable >> apply: aBlock [
	^ aBlock value: self get.
]

{ #category : #'as yet unclassified' }
TKTVariable >> doesNotUnderstand: aMessage [ 
	^ self get perform: aMessage selector withArguments: aMessage arguments.
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
