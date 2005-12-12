Extension { #name : #Socket }

{ #category : #'*rST' }
Socket >> getObject [
	"gets a serialized object from this socket"
	| encoded object |
	encoded := String new writeStream.
	[encoded isEmpty]
		whileTrue: [encoded nextPutAll: (self receiveDataTimeout: 15)].
	[self isConnected
		and: [self dataAvailable]]
		whileTrue: [encoded nextPutAll: (self receiveDataTimeout: 15)].
	object := ReferenceStream unStream: encoded contents.
	^ object
]

{ #category : #'*rST' }
Socket >> sendObject: anObject [ 
	"sends a serialized object to this socket"
	| encoded |
	encoded := ReferenceStream streamedRepresentationOf: anObject.
	self sendData: encoded
]
