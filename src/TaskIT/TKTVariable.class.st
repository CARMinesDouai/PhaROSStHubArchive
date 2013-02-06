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
	| rslt |
	mutex critical: [
		rslt := aBlock value: value.
	].
	^ rslt.
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
