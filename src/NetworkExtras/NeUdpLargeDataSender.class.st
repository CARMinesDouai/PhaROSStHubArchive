"
I split data in chunks that I send over a UDP socket. 

Each chunk is a serialized version of  an instance of NeChunk. It includes then also data to materialize it.

Public API and Key Messages
- send: aByteArray
-id: aUUID 
Sets the unique ID that identifies me. It is sent along with the data
-maxChunkSize: anInteger 
Sets the size of each chunk. It should be greater  than the size required to serialize a chunk, which is coupled to the size of the ID. Usually its less than 400 bytes.

    Instance Variables
	socket:		<NeUdpSocket>
	splitter:		<NeDataSplitter>


"
Class {
	#name : #NeUdpLargeDataSender,
	#superclass : #Object,
	#traits : 'NeTUdpSocketWrapper',
	#classTraits : 'NeTUdpSocketWrapper classTrait',
	#instVars : [
		'splitter',
		'socket'
	],
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> defaultMaxChunkSize [
	^1500
]

{ #category : #'initialize-release' }
NeUdpLargeDataSender >> destroy [
	self destroySocket
]

{ #category : #accessing }
NeUdpLargeDataSender >> id [
	^splitter id
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

{ #category : #accessing }
NeUdpLargeDataSender >> socket [
	^ socket
]

{ #category : #accessing }
NeUdpLargeDataSender >> socket: anObject [
	socket := anObject
]
