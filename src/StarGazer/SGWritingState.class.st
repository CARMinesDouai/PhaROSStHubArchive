Class {
	#name : #SGWritingState,
	#superclass : #SGState,
	#category : #'StarGazer-States'
}

{ #category : #delegates }
SGWritingState >> set: aParameterName with: aValue [
	^ self sendAndWaitForAck: [
		gate stream nextPutWrite: aValue for: aParameterName.
	] acking: aParameterName.

	
]

{ #category : #delegates }
SGWritingState >> setEnd [
	^ self command: SGProtocol commandSetEnd.
]

{ #category : #'private state flow' }
SGWritingState >> switchCalculating [ 
	self setEnd.
	^ super switchCalculating.
]

{ #category : #'private state flow' }
SGWritingState >> switchIdle [ 
	self setEnd.
	^ SGIdleState for: gate.
]

{ #category : #'private state flow' }
SGWritingState >> switchReading [
	self setEnd.
	^ super switchReading.
]

{ #category : #'private state flow' }
SGWritingState >> switchWriting [
	^ self.
]
