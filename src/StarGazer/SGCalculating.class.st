Class {
	#name : #SGCalculating,
	#superclass : #SGState,
	#instVars : [
		'polling'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #producing }
SGCalculating >> poll [
	[  self singlePoll. ] repeat.
]

{ #category : #producing }
SGCalculating >> singlePoll [
	
	gate deployMessage: gate stream nextMessage.
	
]

{ #category : #commands }
SGCalculating >> startCalculating [
	self startPolling.
]

{ #category : #service }
SGCalculating >> startPolling [
	polling ifNil: [
		polling := self paralellize poll.
	].
	
]

{ #category : #service }
SGCalculating >> stopPolling [
	polling ifNotNil: [
		polling cancel.
		polling := nil.
	].
]

{ #category : #'private state flow' }
SGCalculating >> switchCalculating [ 
	^  self
]

{ #category : #'private state flow' }
SGCalculating >> switchIdle [
	self stopPolling.
	^ SGStopped for: gate.
]

{ #category : #'private state flow' }
SGCalculating >> switchReading [ 
	SGError signal: 'You cannot start reading from calculating status'.
]

{ #category : #'private state flow' }
SGCalculating >> switchWriting [
	SGError signal: 'You cannot start write from calculating status'.
]
