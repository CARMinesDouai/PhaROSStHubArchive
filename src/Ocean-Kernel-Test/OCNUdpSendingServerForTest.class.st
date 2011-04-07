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
	
	self listenSocket sendUDPData: self dataToSend toHost: self listenSocket port: self portNumber
	
]

{ #category : #accessing }
OCNUdpSendingServerForTest >> sendData: aString [
	self dataToSend: aString
]
