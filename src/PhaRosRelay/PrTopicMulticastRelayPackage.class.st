Class {
	#name : #PrTopicMulticastRelayPackage,
	#superclass : #PhaROSPackage,
	#category : #PhaRosRelay
}

{ #category : #forwarding }
PrTopicMulticastRelayPackage class >> sourceTopic: topicName type: topicTypeString targetGroupIp: ipString port: portInt [
	self new sourceTopic: topicName type: topicTypeString targetGroupIp: ipString port: portInt
]

{ #category : #forwarding }
PrTopicMulticastRelayPackage class >> targetTopic: topicName type: topicTypeString sourceGroupIp: ipString port: portInt [
	self new targetTopic: topicName type: topicTypeString sourceGroupIp: ipString port: portInt
]

{ #category : #accessing }
PrTopicMulticastRelayPackage >> node [
	^self controller node
]

{ #category : #scripts }
PrTopicMulticastRelayPackage >> scriptTopicAsSourceExample [
	"self new scriptForwardingFromTopicToMulticastGroupExample"
	self sourceTopic: '/demo' type: 'std_msgs/String' targetGroupIp: '226.0.0.30' port: 12345
]

{ #category : #scripts }
PrTopicMulticastRelayPackage >> scriptTopicAsTargetExample [
	"self new scriptForwardingToTopicFromMulticastGroupExample"
	self targetTopic: '/demo' type: 'std_msgs/String' sourceGroupIp: '226.0.0.30' port: 12345
]

{ #category : #forwarding }
PrTopicMulticastRelayPackage >> sourceTopic: topicName type: topicTypeString targetGroupIp: ipString port: portInt [
	| multicastSocket |
	self log: 'Creating multicast socket  Ip: ', ipString, ' port: ', portInt asString, ' ...'.
	multicastSocket := MulticastSocket group: ipString port: portInt.
	self logCr: 'DONE'.
	self log: 'Building topic subscriber on ', topicName,'(', topicTypeString, ') ...'.
	(self node buildConnectionFor: topicName) 
			typedAs: topicTypeString; 
			for: [ : arrayWrapper | 
				self logCr: 'Received from topic ', topicName,'(', topicTypeString, ') bytes: ',  arrayWrapper data size asString.
				arrayWrapper data size > 65500 
				ifTrue: [
					self logCr: 'Data with more than 64KB not yet supported! TODO ;-)'  ]
				ifFalse: [ 
					self log: 'Multicasting data ...'.
					multicastSocket send: arrayWrapper data.
					self logCr: 'DONE'.] ];
			connect.
	self logCr: 'DONE'.

]

{ #category : #forwarding }
PrTopicMulticastRelayPackage >> targetTopic: topicName type: topicTypeString sourceGroupIp: ipString port: portInt [
	| publisher multicastBridge |
	self log: 'Creating topic publisher on ', topicName,'(', topicTypeString, ') ...'.
	publisher := self node 
						topicPublisher: topicName
						typedAs: topicTypeString.
	self logCr: 'DONE'.
	self log: 'Creating multicast listener ...'.
	multicastBridge := MulticastBridge 
								group: ipString 
								port: portInt
								onReceptionDo: [: data|
									self logCr: 'Received from multicast bytes: ', data size asString.
									self log: 'Publishing data to topic', topicName,'(', topicTypeString, ') ...'.
 									publisher send:[ : dataWrapper | 
										dataWrapper data: data.
									].
								].
	self logCr: 'DONE'.
	self log: 'Starting multicast listener Ip: ', ipString, ' port: ', portInt asString, ' ...'.
	multicastBridge start.
	self logCr: 'DONE'.

]
