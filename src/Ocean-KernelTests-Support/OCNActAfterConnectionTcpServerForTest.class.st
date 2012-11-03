Class {
	#name : #OCNActAfterConnectionTcpServerForTest,
	#superclass : #OCNTcpServerForTest,
	#instVars : [
		'afterConnectionBlock'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #'initialize-release' }
OCNActAfterConnectionTcpServerForTest >> afterConnectionDo: aBlock [
	afterConnectionBlock := aBlock 
]

{ #category : #running }
OCNActAfterConnectionTcpServerForTest >> interactThenClose: aSocketStream [
	afterConnectionBlock value: aSocketStream socket
]
