"
I'm an identifier to a remote object
"
Class {
	#name : #RSTRemoteObjectID,
	#superclass : #Object,
	#instVars : [
		'brokerID',
		'objectID'
	],
	#category : #'rST-Core'
}

{ #category : #'instance creation' }
RSTRemoteObjectID class >> brokerID: brokerIDString objectID: objectIDString [ 
	"creates an instance with brokerIDString and objectIDString"
	^ self new initializeBrokerID: brokerIDString objectID: objectIDString
]

{ #category : #'instance creation' }
RSTRemoteObjectID class >> fromString: aString [ 
	"creates an instance from aString with the format objectID@brokerID"
	| atPos |
	atPos _ aString indexOf: $@.
	atPos isZero
		ifTrue: [self error: 'invalid format'].
	^ self
		brokerID: (aString allButFirst: atPos)
		objectID: (aString first: atPos - 1)
]

{ #category : #comparing }
RSTRemoteObjectID >> = anObject [ 
	self class == anObject class
		ifFalse: [^ false].
	^ brokerID = anObject brokerID
		and: [objectID = anObject objectID]
]

{ #category : #'resolving objects' }
RSTRemoteObjectID >> asLocalObject [
	"convert to an apropiate local object, could be a proxy or the real object"
	^ RSTBroker instance localObjectFor: self
]

{ #category : #'resolving objects' }
RSTRemoteObjectID >> asProxy [
	"convert me to a proxy"
	^ RSTBroker instance proxyFor: self
]

{ #category : #accessing }
RSTRemoteObjectID >> brokerID [
	^ brokerID
]

{ #category : #converting }
RSTRemoteObjectID >> convertLocalhostAddressIn: brokerIDString [ 
	| portString ipStream ipString brokerIDStream |
	brokerIDStream := ReadStream on: brokerIDString.
	ipStream := brokerIDStream upTo: $:.
	(ipStream contents = 'localhost' or: [ipStream contents = '127.0.0.1']) 
		ifTrue: [ipString := NetNameResolver localAddressString]
		ifFalse: [ipString := ipStream contents].
	portString := brokerIDStream upToEnd contents.
	^ ipString , ':' , portString
]

{ #category : #comparing }
RSTRemoteObjectID >> hash [
	^ brokerID hash bitXor: objectID hash
]

{ #category : #initialization }
RSTRemoteObjectID >> initializeBrokerID: brokerIDString objectID: objectIDString [ 
	brokerID := self convertLocalhostAddressIn: brokerIDString.
	objectID := objectIDString
]

{ #category : #accessing }
RSTRemoteObjectID >> objectID [
	^ objectID
]

{ #category : #printing }
RSTRemoteObjectID >> printOn: aStream [ 
	aStream nextPutAll: objectID asString;
		 nextPut: $@;
		 nextPutAll: brokerID asString
]
