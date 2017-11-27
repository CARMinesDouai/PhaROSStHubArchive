Class {
	#name : #NeUdpLargeDataSender,
	#superclass : #NeUdpSocketWrapper,
	#instVars : [
		'splitter'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'instance creation' }
NeUdpLargeDataSender class >> onUnicastIp: ipStringOrByteArray port: portNumber [
	^ self onSocket: (NeUnicastUdpSocket targetIp: ipStringOrByteArray port: portNumber)
]

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> defaultMaxChunkSize [
	^1500
]

{ #category : #accessing }
NeUdpLargeDataSender >> id: anId [
	splitter id: anId
]

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> initialize [
	super initialize.
	splitter := NeDataSplitter new.
	self maxChunkSize: self defaultMaxChunkSize.
]

{ #category : #accessing }
NeUdpLargeDataSender >> maxChunkSize: anInteger [
	splitter maxChunkSize: anInteger
]

{ #category : #sending }
NeUdpLargeDataSender >> send: data [
	splitter dataBytes: data.
	splitter chunks
		do: [ :aChunk | socket send: aChunk asByteArray ]
]
