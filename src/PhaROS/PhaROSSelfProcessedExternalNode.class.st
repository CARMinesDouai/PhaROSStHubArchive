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
	| stream peeked msg tries  | 
	
	self keepRunning: true.
	
	msg := topic newMessage.	
	
	stream := SocketStream on: socket. 
	stream binary.
	stream timeout: self timeout.
	tries := 0.
	process := [
		
		[  self keepRunning ]  whileTrue: [
			[
				stream peek ifNotNil: [
					msg loadStream: stream.
					aChannel send: msg.
				] ifNil: [
					socket isConnected ifFalse:[
						self keepRunning: false.
					]
				].
				tries := 0.
			] on: Error do: [ :e |
			
				(e class = ConnectionTimedOut or: [ e class = PNGConnectionTimeOut ] )ifTrue: [ 
					tries := tries + 1.
					Transcript show: 'Retrying! ', tries asString; cr.

					tries > 10 ifTrue: [
						self halt .					
						tries := 0.
					].
					(Delay forMilliseconds: 500)wait.
					
				] ifFalse: [" self halt ."].
			]
		].
		aChannel unsubscribe: self.
	] forkAt: Processor highIOPriority named: 'ExternalNode'.

]
