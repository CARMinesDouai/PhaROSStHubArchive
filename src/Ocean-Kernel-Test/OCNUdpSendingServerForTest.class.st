Class {
	#name : #OCNUdpSendingServerForTest,
	#superclass : #OCNUdpServerForTest,
	#instVars : [
		'dataToSend'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'as yet unclassified' }
OCNUdpSendingServerForTest >> dataToSend [
	^dataToSend 
]

{ #category : #'as yet unclassified' }
OCNUdpSendingServerForTest >> dataToSend: aString [
	dataToSend  :=  aString
]

{ #category : #'as yet unclassified' }
OCNUdpSendingServerForTest >> interactThrough [
	
	self listenSocket sendUDPData: self dataToSend toHost: self listenSocket port: self portNumber
	
]

{ #category : #'as yet unclassified' }
OCNUdpSendingServerForTest >> sendData: aString [
	self dataToSend: aString
]
