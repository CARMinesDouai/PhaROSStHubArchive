Class {
	#name : #NeUdpLargeDataSender,
	#superclass : #NeUdpSocketWrapper,
	#instVars : [
		'ip',
		'splitter'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #accessing }
NeUdpLargeDataSender >> id: anId [
	splitter id: anId
]

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> initialize [
	splitter := NeSplitter new.
	super initialize.

]

{ #category : #accessing }
NeUdpLargeDataSender >> maxChunkSize: anInteger [
	splitter maxChunkSize: anInteger
]

{ #category : #sending }
NeUdpLargeDataSender >> send: data [
	splitter dataBytes: data.
	splitter chunks do: [ :aChunk | 
		socket sendData: aChunk asByteArray toHost: self ip port: self port ].
	
	
]
