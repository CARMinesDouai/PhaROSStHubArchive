Class {
	#name : #SGState,
	#superclass : #Object,
	#instVars : [
		'gate'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGState class >> for: aGate [
	^ self new gate: aGate ;	yourself.
]

{ #category : #'private delegate' }
SGState >> command: aCommand [ 
	^ self tryToGetResponseFor: [
		gate stream nextPutCommand: aCommand.
	].
	
]

{ #category : #accessing }
SGState >> gate: aGate [ 
	gate := aGate.
	gate state: self.
]

{ #category : #delegates }
SGState >> get: aParameterName [
	^ self switchReading get: aParameterName.
	
]

{ #category : #delegates }
SGState >> set: aParameterName with: aValue [
	^ self switchWriting set: aParameterName with: aValue.

]

{ #category : #delegates }
SGState >> startCalculating [
	^ self switchCalculating startCalculating.
]

{ #category : #delegates }
SGState >> stopCalculating [
	^ self switchIdle stopCalculating.
]

{ #category : #'private state flow' }
SGState >> switchCalculating [ 
	^  SGCalculating for: gate.
]

{ #category : #'private state flow' }
SGState >> switchIdle [
	^ SGStopped for: gate.
]

{ #category : #'private state flow' }
SGState >> switchReading [
	^  SGReadingParameters for: gate.
]

{ #category : #'private state flow' }
SGState >> switchWriting [
	^ SGSettingParameters for: gate.
]

{ #category : #'private delegate' }
SGState >> tryToGetResponseFor: aBlock [
	| message |	
	10 timesRepeat: [
		aBlock value.
		message := gate stream nextMessageOrNoMessage.
		message = SGMessage NoMessage ifFalse: [
			gate stream cleanup.
			 ^ message 
		].
		(Delay forMilliseconds: 100) wait.
	] .
	

	SGError signal: 'Timeout'.
	
]
