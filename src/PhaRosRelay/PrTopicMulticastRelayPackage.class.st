Class {
	#name : #PrTopicMulticastRelayPackage,
	#superclass : #PhaROSPackage,
	#category : #PhaRosRelay
}

{ #category : #forwarding }
PrTopicMulticastRelayPackage class >> forwardFromTopic: topicName type: topicTypeString toGroupIp: ipString port: portInt [
	self new forwardFromTopic: topicName type: topicTypeString toGroupIp: ipString port: portInt
]

{ #category : #forwarding }
PrTopicMulticastRelayPackage class >> forwardToTopic: topicName type: topicTypeString fromGroupIp: ipString port: portInt [
	self new forwardToTopic: topicName type: topicTypeString fromGroupIp: ipString port: portInt
]

{ #category : #forwarding }
PrTopicMulticastRelayPackage >> forwardFromTopic: topicName type: topicTypeString toGroupIp: ipString port: portInt [
	| multicastSocket |
	multicastSocket := MulticastSocket group: ipString port: portInt.
	(self node buildConnectionFor: topicName) 
			typedAs: topicTypeString; 
			for: [ : arrayWrapper |  
				arrayWrapper data size > 65500 ifTrue: [
					self error: 'Data with more than 64KB not yet supported! TODO ;-)'  ].
				multicastSocket send: arrayWrapper data ];
			connect
]

{ #category : #forwarding }
PrTopicMulticastRelayPackage >> forwardToTopic: topicName type: topicTypeString fromGroupIp: ipString port: portInt [
	| publisher multicastBridge |
	publisher := self node 
						topicPublisher: topicName
						typedAs: topicTypeString.
	multicastBridge := MulticastBridge 
								group: ipString 
								port: portInt
								onReceptionDo: [: data|
 									publisher send:[ : dataWrapper | 
										dataWrapper data: data.
									].
								].
	multicastBridge start.
]

{ #category : #accessing }
PrTopicMulticastRelayPackage >> node [
	^self controller node
]

{ #category : #scripts }
PrTopicMulticastRelayPackage >> scriptForwardingFromTopicToMulticastGroupExample [
	"self new scriptForwardingFromTopicToMulticastGroupExample"
	self forwardFromTopic: '/demo' type: 'std_msgs/String' toGroupIp: '226.0.0.30' port: 12345
]

{ #category : #scripts }
PrTopicMulticastRelayPackage >> scriptForwardingToTopicFromMulticastGroupExample [
	"self new scriptForwardingToTopicFromMulticastGroupExample"
	self forwardToTopic: '/demo' type: 'std_msgs/String' fromGroupIp: '226.0.0.30' port: 12345
]
