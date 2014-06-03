Class {
	#name : #OCNSimpleSocketStream,
	#superclass : #ZdcSimpleSocketStream,
	#category : #'Ocean-ZincZodiacIntegration'
}

{ #category : #'as yet unclassified' }
OCNSimpleSocketStream class >> openConnectionToHost: hostIP port: portNumber [
	|  platformSocket |
	platformSocket := OCNConversationTcpSocket newConnectedToIp: hostIP port: portNumber.	
	^ self on: platformSocket

]

{ #category : #'as yet unclassified' }
OCNSimpleSocketStream class >> openConnectionToHost: hostIP port: portNumber timeout: timeout [
	|  platformSocket |
	platformSocket := OCNConversationTcpSocket newConnectedToIp: hostIP port: portNumber timeout: timeout.
	^ self on: platformSocket

]

{ #category : #'as yet unclassified' }
OCNSimpleSocketStream class >> openConnectionToHostNamed: hostName port: portNumber [
	| platformSocket socketStream hostIP |
	platformSocket := OCNConversationTcpSocket new.
	socketStream := self on: platformSocket.
	hostIP := NetNameResolver addressForName: hostName timeout: socketStream timeout.
	^ socketStream 
		connectTo: hostIP port: portNumber;
		yourself
]
