Class {
	#name : #StarGazer,
	#superclass : #Object,
	#instVars : [
		'lastKnownPosition',
		'polling',
		'settings',
		'gate'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
StarGazer class >> atGate: aPort [
	^ self new gate: aPort; yourself.
]

{ #category : #'as yet unclassified' }
StarGazer class >> atPortId: aPortId [
	^ self atGate:  (SGGate atPortId: aPortId).
]

{ #category : #'as yet unclassified' }
StarGazer class >> default [
	^ self atPortId: SGGate defaultPortID.
]

{ #category : #accessing }
StarGazer >> finallize [
	polling ifNotNil: [ polling cancel ].
]

{ #category : #accessing }
StarGazer >> gate:  aSGGate [

	gate ifNil: [
		polling cancel.
	].

	gate := aSGGate asThreadsafeReference.
	polling := self parallelize poll. 

]

{ #category : #accessing }
StarGazer >> initialize [ 
	super initialize.
	settings := Dictionary new. 
]

{ #category : #accessing }
StarGazer >> lastKnownPosition [

	^ lastKnownPosition.
]

{ #category : #accessing }
StarGazer >> poll [
	| message |
	[ 
		message := gate nextMessage. 
		message apply: self. 
	] repeat.
]
