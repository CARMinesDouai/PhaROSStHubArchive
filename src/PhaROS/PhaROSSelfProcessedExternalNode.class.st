Class {
	#name : #PhaROSSelfProcessedExternalNode,
	#superclass : #PhaROSExternalNode,
	#instVars : [
		'keepRunning',
		'process',
		'mutex'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> initialize [ 
	keepRunning := false.
	mutex := Mutex new.
]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> keepRunning [ 
	| val |
	mutex critical: [
		val := keepRunning.
	].
	^val. 
]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> keepRunning: aBoolean [
	mutex critical: [
		keepRunning := aBoolean.
		
	].
]

{ #category : #'as yet unclassified' }
PhaROSSelfProcessedExternalNode >> timeout [
	^ 60.
]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> workWith: aChannel [
	| stream peeked msg   | 
	
	self keepRunning: true.
	
	msg := topic newMessage.	
	
	stream := SocketStream on: socket. 
	stream binary.
	stream timeout: self timeout.
	
	process := [
		[  self keepRunning ]  whileTrue: [
			stream peek ifNotNil: [
				msg loadStream: stream.
				aChannel send: msg.
			] ifNil: [
				socket isConnected ifFalse:[
					self keepRunning: false.
				]
			].
		].
		aChannel unsubscribe: self.
	] forkNamed: 'ExternalNode'.

]
