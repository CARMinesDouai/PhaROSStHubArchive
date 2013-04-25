"
This node represent a basic node in the ROS environment. 
	
	It is related with a XMLRPC Server and a TCP server. 
	
	Is thinked to be used as conection handle, what means that you use the node just as a bridge with ROS, without subclassit.
	
	In terms to achive it, it has a different flavor of #interestedIn: message, which adds a callback for each topic. 
	
	
	#interestedIn: aTopicID onReceive: [ :msg :chn | ].
	#interestedIn: aTopicID typedAs: aTypeID onReceive: [ :msg :chn | ]. 
	


"
Class {
	#name : #PhaROSNodeHandle,
	#superclass : #PhaROSNode,
	#instVars : [
		'topicHandle'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> dispatch: aMessage for: aChannel [
	topicHandle at: aChannel topic name ifPresent: [ : callback | 
		callback cull: aMessage cull: aChannel 
	] ifAbsent: [
		Transcript show: ' Receiving packets from ', aChannel topic name, ' with out packet handle'; cr.
	]
]

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> initialize [ 
	super initialize.
	topicHandle := Dictionary new.
	receiverDelegate := [: msg :chn | self dispatch: msg for: chn ].
]

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> interestedIn: aTopicName [
	self error: 'This method is not available in this node. Call instead interestedIn: onReceive: '.
]

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> interestedIn: aTopicName onReceive: aCallback [
	self register: aCallback for: aTopicName.
	^ super interestedIn: aTopicName.
	
]

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> interestedIn: aTopicName typedAs: aTypeId [
	self error: 'This method is not available in this node. Call instead interestedIn: typedAs: onReceive: '.
]

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> interestedIn: aTopicName typedAs: aTypeId onReceive: aCallback [
	self register: aCallback for: aTopicName. 
	super interestedIn: aTopicName typedAs: aTypeId.

		
]

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> receiverDelegate: aDelegate [
	self error: 'this node is a handle node. It receives delegates per topic'.
]

{ #category : #'as yet unclassified' }
PhaROSNodeHandle >> register: aCallback for: aTopicName [
	topicHandle at: aTopicName put: aCallback.
]
