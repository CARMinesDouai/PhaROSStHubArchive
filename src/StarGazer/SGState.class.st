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
	self sendAndWaitForAck: [
		gate stream nextPutCommand: aCommand.
	] acking: aCommand.

]

{ #category : #'private delegate' }
SGState >> command: aCommand with: aParameter [
	^ self switchIdle command: aCommand with: aParameter.
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
SGState >> hasMessages [
	^ false.
]

{ #category : #delegates }
SGState >> nextMessage [
	SGError signal: 'The current state of the device does not make calculations nor get messages'.
]

{ #category : #'private protocol' }
SGState >> sendAndWaitForAck: aBlock acking: aWord [
	| message |	
	10 timesRepeat: [
		aBlock value.
		message := gate stream nextMessage: 10.
		message = SGMessage NoMessage ifFalse: [
			(message content indexOfSubCollection: aWord) = 0 ifFalse: [
			Transcript show: message content,' (expected content)'; cr. 
			^ message 
			] ifTrue:[
				Transcript show: message content,' (unexpected content)'; cr.
			]
		].
		(Delay forMilliseconds: 100) wait.
	] .
	

	SGError signal: 'Timeout'.
	
]

{ #category : #'as yet unclassified' }
SGState >> sendAndWaitForResponse: aBlock acking: aWord [
	^ self waitForResponseIfAck: (self sendAndWaitForAck: aBlock acking: aWord) .
	 
]

{ #category : #delegates }
SGState >> set: aParameterName with: aValue [
	^ self switchWriting set: aParameterName with: aValue.

]

{ #category : #delegates }
SGState >> startCalculating [
	^ self switchCalculating startCalculating.
]

{ #category : #build }
SGState >> startMapBuilding [
	^ self switchBuilding startMapBuilding.
	
]

{ #category : #delegates }
SGState >> stopCalculating [
	^ self switchIdle stopCalculating.
]

{ #category : #build }
SGState >> switchBuilding [ 

	self command: SGProtocol markMode with: 'Map'.
	self command: SGProtocol mapMode with: 'Start'.
	^  SGCalculatingState for: gate.
]

{ #category : #'private state flow' }
SGState >> switchCalculating [ 
	self command: SGProtocol commandCalcStart.
	^  SGCalculatingState for: gate.
]

{ #category : #'private state flow' }
SGState >> switchIdle [
	 self command: SGProtocol commandCalcStop.
	^ SGIdleState for: gate.
]

{ #category : #'private state flow' }
SGState >> switchReading [
	^  SGReadingState for: gate.
]

{ #category : #'private state flow' }
SGState >> switchWriting [
	^ SGWritingState for: gate.
]

{ #category : #'private protocol' }
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
