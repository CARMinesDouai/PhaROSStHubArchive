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
	| buffer tout bytesRead msg loop loopSubscribers | 
	
	self keepRunning: true.
	
	msg := topic newMessage.	
	buffer := ByteArray new:( topic packetSize  ).
	tout := self timeout.
	
	process := [
		[  self keepRunning ]  whileTrue: [
			bytesRead := socket receiveDataTimeout: tout into: buffer. 
			bytesRead > 0 ifTrue: [
				msg load: buffer.
				aChannel send: msg.
			] ifFalse: [
				socket isConnected ifFalse:[
					self keepRunning: false.
				]
			]
		].
		aChannel unsubscribe: self.
	] forkNamed: 'ExternalNode'.

]
