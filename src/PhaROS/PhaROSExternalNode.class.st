"
PhaROSExternalNode is the representation of a node that lives in ROS world, but not in this image. Even when is not subclass of PhaROSNode, is polymorphic with it objects for the topic management, allowing to use as receptor of a ROS message any kind of both nodes.

For the case of reading message from it (what means to send messages into the system), we have PhaROSSelfProcessedExternalNode, which has a process attached to the related socket and let the messages go into our image side of ROS world.
Is important to take in care that in this architecture, for each incoming conection, we have one process polling the messages.


"
Class {
	#name : #PhaROSExternalNode,
	#superclass : #PhaROSNode,
	#instVars : [
		'topic',
		'socket'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #accessing }
PhaROSExternalNode >> checkConnection [
	socket isConnected ifFalse:[
		PhaROSError signal: 'Socket closed'.	
	].

]

{ #category : #accessing }
PhaROSExternalNode >> finalize [
	[
		socket closeAndDestroy:20 .
	]  on: Error do:[ ].
]

{ #category : #accessing }
PhaROSExternalNode >> socket [ 
	^ socket.
]

{ #category : #accessing }
PhaROSExternalNode >> socket: aSocket [
	socket := aSocket. 
]

{ #category : #accessing }
PhaROSExternalNode >> topic [
	^ topic
]

{ #category : #accessing }
PhaROSExternalNode >> topic: aTopic [ 
	topic := aTopic.
	
]
