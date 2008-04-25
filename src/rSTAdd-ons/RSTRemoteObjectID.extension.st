Extension { #name : #RSTRemoteObjectID }

{ #category : #'*rSTAdd-ons' }
RSTRemoteObjectID >> = anObject [ 
	"Answers true if the receiver is equal to anObject"
	self class == anObject class ifFalse: [^ false].
	
	^ brokerID = anObject brokerID
		and: [objectID = anObject objectID]
]

{ #category : #'*rSTAdd-ons' }
RSTRemoteObjectID >> asLocalObject [
	"Answers a local object related to the receiver.
	It could be a proxy or a real local object."
	^ RSTBroker isStarted
		ifTrue: [RSTBroker instance localObjectFor: self]
		ifFalse:[self error: 'rST: service not started']
		

]

{ #category : #'*rSTAdd-ons' }
RSTRemoteObjectID >> asProxy [
	"Answers a proxy related to the receiver."
	^ RSTBroker instance proxyFor: self
]

{ #category : #'*rSTAdd-ons' }
RSTRemoteObjectID >> convertLocalhostAddressIn: brokerIDString [ 
	| portString ipStream ipString brokerIDStream |
	brokerIDStream := ReadStream on: brokerIDString.
	ipStream := brokerIDStream upTo: $:.

	self flag: #plattformSpecificDeprecation.
	"The next piece of commented code has no sense for other platforms different from win32
	(ipStream contents = 'localhost' or: [ipStream contents = '127.0.0.1']) 
		ifTrue: [ipString := NetNameResolver localAddressString]
		ifFalse: [ipString := ipStream contents]."

	ipString := ipStream contents.
	portString := brokerIDStream upToEnd contents.
	^ ipString , ':' , portString
]
