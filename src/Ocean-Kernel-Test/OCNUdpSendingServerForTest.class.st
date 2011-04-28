"
|server|
server := OCNUdpSendingServerForTest onPortNumber: 9091.
server dataToSend: 'Hello Word'.
server start.  



server kill.
Socket allInstancesDo: [ :s | s closeAndDestroy ]   .
Socket allInstances.  
"
Class {
	#name : #OCNUdpSendingServerForTest,
	#superclass : #OCNUdpServerForTest,
	#instVars : [
		'dataToSend'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #accessing }
OCNUdpSendingServerForTest >> dataToSend [
	^dataToSend 
]

{ #category : #accessing }
OCNUdpSendingServerForTest >> dataToSend: aString [
	dataToSend  :=  aString
]

{ #category : #running }
OCNUdpSendingServerForTest >> interactThrough [
	|sentBytes|

	self dataToSend isEmptyOrNil ifFalse: [
		"self listenSocket sendUDPData: self dataToSend toHost: #[127 0 0 1] port: self portNumber"
		sentBytes := self listenSocket primSocket: self listenSocket socketHandle
			sendUDPData: self dataToSend asByteArray
			toHost: #[127 0 0 1]
			port:  self portNumber
			startIndex: 1
			count: self dataToSend size.
			dataToSend := dataToSend allButFirst: sentBytes
	]
		
]

{ #category : #accessing }
OCNUdpSendingServerForTest >> sendData: aString [
	self dataToSend: aString
]
