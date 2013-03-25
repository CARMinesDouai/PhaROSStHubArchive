Class {
	#name : #SGStopped,
	#superclass : #SGState,
	#category : #'StarGazer-Kernel'
}

{ #category : #delegates }
SGStopped >> stopCalculating [
]

{ #category : #'private state flow' }
SGStopped >> switchIdle [
	^ self.
]
