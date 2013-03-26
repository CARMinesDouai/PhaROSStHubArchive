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
	^ self sendAndWaitForAck: [
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

{ #category : #'private delegate' }
SGState >> sendAndWaitForAck: aBlock [
	| message |	
	10 timesRepeat: [
		aBlock value.
		message := gate stream nextMessage: 10.
		message = SGMessage NoMessage ifFalse: [
			 ^ message 
		].
		(Delay forMilliseconds: 100) wait.
	] .
	

	SGError signal: 'Timeout'.
	
]

{ #category : #'private delegate' }
SGState >> sendAndWaitForResponse: aBlock [
	^ self waitForResponseIfAck: (self sendAndWaitForAck: aBlock).
	 
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
	 self command: SGProtocol commandCalcStop.
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

{ #category : #'private state flow' }
SGState >> waitForResponseIfAck: aSGMessage [
	
	aSGMessage hasAValue ifTrue: [
		^ aSGMessage.	
	].

	^ aSGMessage isAck ifTrue: [
		gate stream nextMessage: 20.
	] ifFalse: [
		SGError signal: 'Error in the protocol. Unexpected message'.
	].


]
