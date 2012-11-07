Class {
	#name : #PureConnector,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'lastRequest',
		'socket'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureConnector class >> ip: anIp port: aPort [
	^ self new ip: anIp ; port: aPort ; yourself.
]

{ #category : #'as yet unclassified' }
PureConnector >> initialize [ 
	socket := Socket newUDP.
]

{ #category : #'as yet unclassified' }
PureConnector >> ip: anIp [
	ip := anIp.
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
		response := RobulabMessage initializeFromArray: (buffer copyFrom: 1 to: 	responseSize).
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
		port: self port
]

{ #category : #'as yet unclassified' }
PureConnector >> send: aStringMessage andReceiveAnswerFor: aRobulab [

	self send: aStringMessage.
	^ self receiveAnswer. 
	

	
]
