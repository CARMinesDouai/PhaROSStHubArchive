Class {
	#name : #NeUdpSender,
	#superclass : #NeUdpSocketWrapper,
	#instVars : [
		'ip',
		'splitter'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #accessing }
NeUdpSender >> id: anId [
	splitter id: anId
]

{ #category : #'initialize-release' }
NeUdpSender >> initialize [
	splitter := NeSplitter new.
	super initialize.

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
