Class {
	#name : #OCNAbstractSocketStream,
	#superclass : #ZdcAbstractSocketStream,
	#category : #'Ocean-ZincZodiacIntegration'
}

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketClose [
	socket destroy 
]

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketConnectTo: hostAddress port: portNumber [
	| anIpAddress |
	anIpAddress := OCNIpv4Address ip: hostAddress port: portNumber.
	socket connectToServer: anIpAddress.

]

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketIsConnected [
	^ socket isConnected and: [ socket isOtherEndClosed not ]
]

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketIsDataAvailable [
	^ socket isDataAvailable 
]

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketReceiveDataInto: bytes startingAt: offset count: count [
	^ socket receiveDataInto: bytes startingAt: offset count: count.
		

]

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketSendData: bytes startingAt: offset count: count [
	^ socket 
		sendSomeData: bytes 
		startIndex: offset 
		count: count 
]

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketWaitForData [
	socket receiveTimeOutSeconds: self timeout.
	^ socket waitForDataIfTimeout: [ OCNSocketOperationFailureError signal: 'receive timeout' ]
		
]

{ #category : #'private socket' }
OCNAbstractSocketStream >> socketWaitForSendDone [
	^ socket waitForSendDoneFor: socket sendTimeoutSeconds 
	
]
