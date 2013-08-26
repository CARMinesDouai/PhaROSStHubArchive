"
PhaROSExternalNode is the representation of a node that lives in ROS world, but not in this image. Even when is not subclass of PhaROSNode, is polymorphic with it objects for the topic management, allowing to use as receptor of a ROS message any kind of both nodes.

For the case of reading message from it (what means to send messages into the system), we have PhaROSSelfProcessedExternalNode, which has a process attached to the related socket and let the messages go into our image side of ROS world.
Is important to take in care that in this architecture, for each incoming conection, we have one process polling the messages.


"
Class {
	#name : #PhaROSExternalSubscriberNode,
	#superclass : #PhaROSExternalNode,
	#instVars : [
		'nodeDataSender'
	],
	#category : #'PhaROS-Kernel-ExternalNodes'
}

{ #category : #'as yet unclassified' }
PhaROSExternalSubscriberNode class >> named: aCallerId subscriberOf: aTopic with: aSocket [
	^self new 	name: aCallerId; 
				topic: aTopic; 
				socket: aSocket; 
				yourself.
]

{ #category : #'message handling' }
PhaROSExternalSubscriberNode >> addToMessagesQueue: aBinaryMessage [
	nodeDataSender addToMessagesQueue: aBinaryMessage.
	
	
]

{ #category : #service }
PhaROSExternalSubscriberNode >> destroy [
	self stop.
]

{ #category : #'message handling' }
PhaROSExternalSubscriberNode >> initialize [ 
	nodeDataSender := PhaROSDataSender for: self.
	
]

{ #category : #bla }
PhaROSExternalSubscriberNode >> printOn: aStream [
	aStream nextPutAll: 'ExternalSubscriberNode-', self name. 
]

{ #category : #'message handling' }
PhaROSExternalSubscriberNode >> receive: aMessage from: aChannel [ 
"	name = '/rviz' ifTrue: [ Transcript show: aMessage value asString. ]."
	self addToMessagesQueue: aMessage dump.
	


]
