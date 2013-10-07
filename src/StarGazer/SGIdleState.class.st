Class {
	#name : #SGIdleState,
	#superclass : #SGState,
	#category : #'StarGazer-States'
}

{ #category : #'private state flow' }
SGIdleState >> command: aCommand  with: aParameter [
	self sendAndWaitForAck: [
		gate stream nextPutWrite: aParameter  for: aCommand.
	] acking: aCommand.

]

{ #category : #delegates }
SGIdleState >> stopCalculating [
]

{ #category : #'private state flow' }
SGIdleState >> switchIdle [
	^ self.
]
