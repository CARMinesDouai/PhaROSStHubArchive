Class {
	#name : #SGCalculatingState,
	#superclass : #SGState,
	#instVars : [
		'polling',
		'messages',
		'shouldWait',
		'shf'
	],
	#category : #'StarGazer-States'
}

{ #category : #producing }
SGCalculatingState >> deployMessage: aMessage [
	aMessage isALandMark ifTrue: [
		messages nextPut: aMessage. 
		gate announceLandMarkReading.	
	].
	
	
]

{ #category : #commands }
SGCalculatingState >> finalize [ 
	polling finalize
]

{ #category : #consuming }
SGCalculatingState >> hasMessages [
	^ messages size > 0
]

{ #category : #'initialize-release' }
SGCalculatingState >> initialize [ 
	messages := SharedQueue new.
]

{ #category : #consuming }
SGCalculatingState >> nextMessage [
		^ messages next ifNil:[ SGMessage NoMessage ].
	
]

{ #category : #producing }
SGCalculatingState >> poll [
	[  self singlePoll. ] repeat.
]

{ #category : #producing }
SGCalculatingState >> singlePoll [

	[
		self deployMessage: gate stream nextMessage.
		(Delay forMilliseconds: 100) wait.
	] on: Error do: [
		:e | Transcript show: 'Warning: ', e messageText; cr.
	].

]

{ #category : #commands }
SGCalculatingState >> startCalculating [
	self startPolling.
]

{ #category : #commands }
SGCalculatingState >> startMapBuilding [ 
	self startPolling.
]

{ #category : #service }
SGCalculatingState >> startPolling [
	polling ifNil: [
		polling := self paralellize poll.
	].
	
]

{ #category : #service }
SGCalculatingState >> stopPolling [
	polling ifNotNil: [
		polling cancel.
		polling := nil.
	].
]

{ #category : #'private state flow' }
SGCalculatingState >> switchCalculating [ 
	^  self
]

{ #category : #'private state flow' }
SGCalculatingState >> switchIdle [
	self stopPolling.
	self cleanUpBuffer.
	^ super switchIdle.
]

{ #category : #'private state flow' }
SGCalculatingState >> switchReading [ 
	SGError signal: 'You cannot start reading from calculating status'.
]

{ #category : #'private state flow' }
SGCalculatingState >> switchWriting [
	SGError signal: 'You cannot start write from calculating status'.
]
