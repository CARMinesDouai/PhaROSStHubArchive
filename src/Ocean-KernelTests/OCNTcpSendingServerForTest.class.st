Class {
	#name : #OCNTcpSendingServerForTest,
	#superclass : #OCNTcpServerForTest,
	#instVars : [
		'dataToSend'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #'as yet unclassified' }
OCNTcpSendingServerForTest >> dataToSend [
	^dataToSend 
]

{ #category : #'as yet unclassified' }
OCNTcpSendingServerForTest >> dataToSend: aString [
	dataToSend  :=  aString
]

{ #category : #'as yet unclassified' }
OCNTcpSendingServerForTest >> interactThrough: aSocketStream [
	aSocketStream nextPutAll: self dataToSend 
]

{ #category : #'as yet unclassified' }
OCNTcpSendingServerForTest >> sendData: aString [
	self dataToSend: aString
]
