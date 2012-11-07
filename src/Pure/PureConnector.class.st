Class {
	#name : #PureConnector,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'socket',
		'currentRequestId'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureConnector class >> ip: anIp port: aPort [
	^ self new ip: anIp ; port: aPort ; yourself.
]

{ #category : #'as yet unclassified' }
PureConnector >> consumeRequestId [
	| current ret | 
	
	current := currentRequestId.
	self incrementRequestId.
	
	((currentRequestId printStringBase: 16) size = 1) ifTrue: [ 
			current := ('0',(currentRequestId printStringBase: 16))asString 
	] ifFalse: [
			current := (currentRequestId printStringBase: 16)
	].
	
	
	^ current.
	

]

{ #category : #'as yet unclassified' }
PureConnector >> incrementRequestId [
	currentRequestId := currentRequestId +1 .
	(currentRequestId >= 255) ifTrue:[
		currentRequestId := 1.
	].

]

{ #category : #'as yet unclassified' }
PureConnector >> initialize [ 
	socket := Socket newUDP.
	currentRequestId := 1.
]

{ #category : #'as yet unclassified' }
PureConnector >> ip: anIp [
	ip := anIp.
]

{ #category : #'as yet unclassified' }
PureConnector >> notificationCode [
	^ 'FF'.
]

{ #category : #'as yet unclassified' }
PureConnector >> port: aPort [
	port := aPort. 
]

{ #category : #'as yet unclassified' }
PureConnector >> receiveAnswer [
  | buffer responseSize response |
	
	[
		buffer := String new: 3000.
		self socket waitForData.
		responseSize := self socket receiveUDPDataInto:  buffer.
		response := PureMessage initializeFromArray: (buffer copyFrom: 1 to: 	responseSize).
	] doWhileTrue: [
		response received.
		response isNotification.
	].

	^ response. 
]

{ #category : #'as yet unclassified' }
PureConnector >> send: aStringMessage [
	self socket 
		sendData: (ByteArray readHexFrom: aStringMessage)
		toHost: self ip
		port: self port.
		
]

{ #category : #'as yet unclassified' }
PureConnector >> sendMessage: aMessage [ 
	| id |
	id := self consumeRequestId.
	
	self send: id, aMessage asHex.
	^ self receiveAnswer. 
	

	
]

{ #category : #'as yet unclassified' }
PureConnector >> sendNotification: aMessage [ 
	self send: self notificationCode, aMessage asHex.
	

	
]

{ #category : #'as yet unclassified' }
PureConnector >> socket [ 
	^ socket.
]
