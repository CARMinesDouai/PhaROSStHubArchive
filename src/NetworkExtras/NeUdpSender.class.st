Class {
	#name : #NeUdpSender,
	#superclass : #NeUdpSocketWrapper,
	#instVars : [
		'ip',
		'splitter'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'initialize-release' }
NeUdpSender >> defaultMaxChunkSize [
	^1500
]

{ #category : #accessing }
NeUdpSender >> id: anId [
	splitter id: anId
]

{ #category : #'initialize-release' }
NeUdpSender >> initialize [
	super initialize.
	splitter := NeSplitter new.
	self maxChunkSize: self defaultMaxChunkSize.
]

{ #category : #accessing }
NeUdpSender >> ip [
	^ ip
]

{ #category : #accessing }
NeUdpSender >> ip: anObject [
	ip := anObject
]

{ #category : #accessing }
NeUdpSender >> maxChunkSize: anInteger [
	splitter maxChunkSize: anInteger
]

{ #category : #sending }
NeUdpSender >> send: data [
	splitter dataBytes: data.
	splitter chunks do: [ :aChunk | 
		socket sendData: aChunk asByteArray toHost: self ip port: self port ].
	
	
]
