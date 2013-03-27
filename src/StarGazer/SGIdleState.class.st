Class {
	#name : #SGIdleState,
	#superclass : #SGState,
	#category : #'StarGazer-States'
}

{ #category : #delegates }
SGIdleState >> stopCalculating [
]

{ #category : #'private state flow' }
SGIdleState >> switchIdle [
	^ self.
]
