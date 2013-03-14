Class {
	#name : #PhaROSInPutChannel,
	#superclass : #PhaROSChannel,
	#instVars : [
		'to'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSInPutChannel class >> for: aNode into: aTopic to: anXMLRPCUrl [

	^ self new owner: aNode; topic: aTopic; to: anXMLRPCUrl; startUp; yourself.
]

{ #category : #service }
PhaROSInPutChannel >> close [
	subscribers do: [:node | node unregisterSubscriber: owner].	
	owner ifNotNil: [ owner stop].
	owner := nil.


]

{ #category : #service }
PhaROSInPutChannel >> createNodeFromHandshake: aSocket [
	| connectionMessage | 
	connectionMessage := PhaROSHSMessage newSubscriberMessageFrom: aSocket receiveDataWithTimeout.
	^(PhaROSSelfProcessedExternalNode named: connectionMessage callerId subscriberOf: topic  with: aSocket).
	
	
	

]

{ #category : #service }
PhaROSInPutChannel >> manageBroadcasterNode [
	| socket ipPort |
	
	socket := self requestTopic: to.
	
	self sendHandshake: socket.
	self owner: (self createNodeFromHandshake: socket).
	
	
	
	
	
]

{ #category : #accessing }
PhaROSInPutChannel >> printOn: aStream [
	aStream nextPutAll: 'InputChannel>> ',topic name. 
]

{ #category : #service }
PhaROSInPutChannel >> requestTopic: anUrlString [
	| proxy tcpConnectionData socket |
	
	proxy := PhaROSProxy url: anUrlString.
	tcpConnectionData := proxy invokeMethod: 'requestTopic' withArgs: { owner name . topic name . {{ 'TCPROS' }}}.
	
	socket := Socket newTCP.
	socket connectTo: ( NetNameResolver addressFromString:  (tcpConnectionData at: 2) )  port: (tcpConnectionData at: 3).
	
	^ socket.
]

{ #category : #service }
PhaROSInPutChannel >> sendHandshake: aSocket [
	| message |
	message := PhaROSHSMessage newSubscriberWith:[
		:msg |
		msg callerId: owner name	;
				topic: topic name;
				md5Sum: topic md5Sum;
				type: topic type.
				
	].
	message sendTo: aSocket .

]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> startUp [ 
	self manageBroadcasterNode.
	self owner workWith: self.





]

{ #category : #accessing }
PhaROSInPutChannel >> to: anXMLRPCUrl [ 
	to := anXMLRPCUrl .
]
