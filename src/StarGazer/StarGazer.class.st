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
StarGazer >> finalize [
	polling ifNotNil: [ polling cancel ].
]

{ #category : #accessing }
StarGazer >> gate:  aSGGate [

	gate ifNotNil: [
		polling cancel.
	].

	gate := aSGGate asThreadsafeReference.
	polling := self paralellize poll. 

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
