Class {
	#name : #RSTSocketStreamPool,
	#superclass : #Object,
	#instVars : [
		'address',
		'port',
		'freeStreams',
		'busyStreams',
		'streamAccessLock'
	],
	#category : #'rST-Core'
}

{ #category : #'instance creation' }
RSTSocketStreamPool class >> addressAndPortFromBrokerID: brokerIDString [ 
	^self new
		addressAndPortFromBrokerID: brokerIDString;
		yourself
]

{ #category : #accessing }
RSTSocketStreamPool >> address [
	^ address
]

{ #category : #accessing }
RSTSocketStreamPool >> address: anObject [
	address := anObject
]

{ #category : #'initialize-release' }
RSTSocketStreamPool >> addressAndPortFromBrokerID: brokerIDString [ 
	| colonPos serverAddress serverPort |
	colonPos := brokerIDString findString: ':'.
	colonPos isZero 
		ifTrue: 
			[serverAddress := brokerIDString.
			serverPort := '9999']
		ifFalse: 
			[serverAddress := brokerIDString first: colonPos - 1.
			serverPort := brokerIDString allButFirst: colonPos].
	self address: (NetNameResolver addressForName: serverAddress).
	self port: serverPort asInteger
]

{ #category : #accessing }
RSTSocketStreamPool >> addressString [
	^NetNameResolver stringFromAddress: self address
]

{ #category : #'initialize-release' }
RSTSocketStreamPool >> closeAndDestroy [
	| closeBlock |
	closeBlock := [:stream| stream close].
	streamAccessLock critical: [
		freeStreams do: closeBlock.
		busyStreams do: closeBlock.
		self reset]
]

{ #category : #'connections-private' }
RSTSocketStreamPool >> freeStream [
	| stream |
	freeStreams ifEmpty: [^self newSocketStream].
	stream := freeStreams anyOne.
	freeStreams remove: stream.
	stream isConnected ifFalse: [
		[stream close] fork.
		^self freeStream].
	^ stream
]

{ #category : #'initialize-release' }
RSTSocketStreamPool >> initialize [
	super initialize.
	streamAccessLock := Semaphore forMutualExclusion.
	self reset
]

{ #category : #'connections-private' }
RSTSocketStreamPool >> newSocketStream [
	| socket |
	socket := nil.
	3 timesRepeat: 
			[socket ifNotNil: [socket closeAndDestroy].
			socket := Socket newTCP.
			
			[socket 
				connectTo: self address
				port: self port
				waitForConnectionFor: self secondsToWaitForSocketConnection] 
					on: ConnectionTimedOut
					do: 
						[:timeOutEx | 
						RSTBroker instance logException: timeOutEx.
						Processor yield].
			socket isConnected ifTrue: [^ SocketStream on: socket]].
	RSTRemoteObjectUnreachable 
		signal: 'Cannot connect to: ' , self addressString , ':' 
				, self port asString
]

{ #category : #accessing }
RSTSocketStreamPool >> port [
	^ port
]

{ #category : #accessing }
RSTSocketStreamPool >> port: anObject [
	port := anObject
]

{ #category : #connections }
RSTSocketStreamPool >> releaseStream: stream [
	streamAccessLock critical: 
			[
			stream isConnected ifTrue: [freeStreams add: stream].
			busyStreams remove: stream]
]

{ #category : #'initialize-release' }
RSTSocketStreamPool >> reset [
	busyStreams := IdentitySet new.
	freeStreams := IdentitySet new
]

{ #category : #'connections-private' }
RSTSocketStreamPool >> secondsToWaitForSocketConnection [
	^ 3
]

{ #category : #connections }
RSTSocketStreamPool >> socketStream [
	| stream |
	streamAccessLock critical: 
			[stream := self freeStream.
			busyStreams add: stream].
	^ stream
]
