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

{ #category : #clean }
SGCalculatingState >> cleanUpBuffer [
	gate cleanUpBuffer.
]

{ #category : #producing }
SGCalculatingState >> deployMessage: aMessage [
	aMessage isALandMark ifTrue: [
		messages nextPut: aMessage. 
		Transcript show: (aMessage content at: 2) asString; cr.
		gate announceLandMarkReading.	
	].
	
	
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
	shf:= 2.
	[[
		self deployMessage: gate stream nextMessage.
		shouldWait := shouldWait + 1.
		shouldWait \\ 1 = 0 ifTrue: [ (Delay forMilliseconds: 100) wait. shf := shf = 1 ifTrue: 1 ifFalse:2 ].
	] on: SGError do: [
		:e | Transcript show: 'Warning: ', e messageText; cr.
	]] on: Error do: [
		:e | 
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