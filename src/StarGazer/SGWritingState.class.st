Class {
	#name : #SGWritingState,
	#superclass : #SGState,
	#category : #'StarGazer-States'
}

{ #category : #delegates }
SGWritingState >> set: aParameterName with: aValue [
	 self sendAndWaitForAck: [
		gate stream nextPutWrite: aValue for: aParameterName.
	] acking: aParameterName.
	self setEnd.

	 
]

{ #category : #delegates }
SGWritingState >> setEnd [

	
	self sendAndWaitForResponse: [
		gate stream nextPutCommand: SGProtocol commandSetEnd.
		 (Delay forSeconds: 2) wait.
	] acking: SGProtocol commandSetEnd.
]

{ #category : #'private state flow' }
SGWritingState >> switchIdle [ 
	^ SGIdleState for: gate.
]

{ #category : #'private state flow' }
SGWritingState >> switchReading [
	"self setEnd."
	^ super switchReading.
]

{ #category : #'private state flow' }
SGWritingState >> switchWriting [
	^ self.
]
