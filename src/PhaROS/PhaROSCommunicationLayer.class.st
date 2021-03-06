Class {
	#name : #PhaROSCommunicationLayer,
	#superclass : #Object,
	#instVars : [
		'xml',
		'tcp',
		'ip',
		'transport',
		'server'
	],
	#category : #'PhaROS-Kernel-InternalNodes'
}

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer class >> xmlAt: aPort tcpAt: otherPort of: anIP delegatingOn: aTransport [

	^ self new xml: aPort; tcp: otherPort ; ip: anIP; transport: aTransport; configure;  yourself. 
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> configure [
	"
		http://wiki.ros.org/ROS/Slave_API
		so far, only 5 callbacks of the API are implemented out of 10
	"

	XMLRPCService atPort: xml 
					serve: {
						#getBusInfo -> {self -> #getBusInfo: } .
						#getPid -> { self -> #getPid: } .
						#requestTopic -> { self -> #requestTopic:for:availableFor: } .
						#getPublications -> { self -> #getPublications: } .
						#paramUpdate -> { self -> #from:update:with: }
					} asXMLRPCHttpModule 
					at:'/' .
					
	server := PhaROSTcpServer startOn: tcp named: ' related TCP Service- Port:', tcp asString for: self.
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> finalize [ 
	self stop.
	transport := nil.
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> from: aCallerId update: aParameterName with: aValue [ 
	(transport parameter: aParameterName normalizeParameterName ) setNotBinded: aValue.
	^ { 1 . 'Success' . 0 }
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> getBusInfo: aCallerId [
	 | info node |
		
	info := transport connections inject: Set new into: [ :set :connection | 
		set addAll: connection busInfo. set. 
		"topic busInfoFor: owner"
	].

	 ^{ 1 . 'bus info' . info asArray }.
	
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> getPid: aCallerId [
	 ^{ 1 . 'PID: 777' . 777 } .
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> getPublications: aCallerId [
	^ { 1 . 'Success' . {} }.
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> ip: anIP [
	ip := anIP 
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> manageIncomingConnection: aMessageHeader with: aSocketStream [
	aSocketStream socket setOption: 'TCP_NODELAY' value: (aMessageHeader  tcpNodelay).
	aMessageHeader subscribeTo: transport with: aSocketStream.
	

]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> requestTopic: aCallerId for:aTopic availableFor: anArrayOfProtocols [

	^ (transport isPublisherOf: aTopic) ifTrue: [
		
		{ 1 .  'Protocols' . {  'TCPROS'  .  ip .  tcp }  }	
	] ifFalse: [
		
		{} 
	].
	
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> resolveSocketTo: aTopic of: anURL for: aNode [
	| proxy tcpConnectionData socket |
	
	proxy := PhaROSProxy url: anURL.
	tcpConnectionData := proxy invokeMethod: 'requestTopic' withArgs: { aNode name . aTopic name . {{ 'TCPROS' }}}.
	
	socket := Socket newTCP.
	socket connectTo: ( NetNameResolver addressForName:  (tcpConnectionData at: 2) )  port: (tcpConnectionData at: 3).
	^ socket.
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> rosrpc [
	^  'rosrpc://', ip, ':', tcp asString , '/'.
	
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> stop [
	XMLRPCService stop: xml.
	server finalize.
	server := nil. 
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> tcp: aPort [
	tcp := aPort
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> transport: aTransport [ 
	transport := aTransport 
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> url [
	^  'http://', ip, ':', xml asString , '/'.
]

{ #category : #'as yet unclassified' }
PhaROSCommunicationLayer >> xml: aPort [
	xml := aPort
]
