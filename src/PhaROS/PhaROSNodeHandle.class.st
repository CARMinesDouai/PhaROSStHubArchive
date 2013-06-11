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
		'topicHandle',
		'subscribingHandle'
	],
	#category : #'PhaROS-Kernel-Nodes'
}

{ #category : #events }
PhaROSNodeHandle >> atSubscribing: aTopicID do: aBlock [
	subscribingHandle at: aTopicID put: aBlock.
]

{ #category : #building }
PhaROSNodeHandle >> buildConnectionFor: aTopicID [
	^ PhaROSTopicConectionBuilder node: self topicName: aTopicID.
]

{ #category : #dispatching }
PhaROSNodeHandle >> dispatch: aMessage for: aChannel [
	topicHandle at: aChannel topic  ifPresent: [ : callbackSet | 
		callbackSet do: [ : callback | callback receive: aMessage value from: aChannel]. 
	] ifAbsent: [
		Transcript show: ' Receiving packets from ', aChannel topic name, ' with out packet handle'; cr.
	]
]

{ #category : #'initialize-release' }
PhaROSNodeHandle >> initialize [ 
	super initialize.
	subscribingHandle := Dictionary new.
	topicHandle := Dictionary new.
	receiverDelegate := [: msg :chn | self dispatch: msg for: chn ].
]

{ #category : #banished }
PhaROSNodeHandle >> interestedIn: aTopicName [
	self error: 'This method is not available in this node. Call instead interestedIn: for: '.
]

{ #category : #'topic-consume' }
PhaROSNodeHandle >> interestedIn: aTopicName for: aCallback [
	self register: aCallback for:  (self lookupTopic: aTopicName).

	
]

{ #category : #banished }
PhaROSNodeHandle >> interestedIn: aTopicName typedAs: aTypeId [
	self error: 'This method is not available in this node. Call instead interestedIn: typedAs: onReceive: '.
]

{ #category : #'topic-consume' }
PhaROSNodeHandle >> interestedIn: aTopicName typedAs: aTypeId for: aCallback [
	self register: aCallback for:  (self lookupTopic: aTopicName typedAs: aTypeId). 

		
]

{ #category : #events }
PhaROSNodeHandle >> onSubscribe: aNode to: aChannel [
	subscribingHandle at: aChannel topic name ifPresent: [: handle | handle cull: aNode cull: aChannel ].
]

{ #category : #banished }
PhaROSNodeHandle >> receiverDelegate: aDelegate [
	self error: 'this node is a handle node. It receives delegates per topic'.
]

{ #category : #building }
PhaROSNodeHandle >> register: aCallback for: aTopic [
	topicHandle at: aTopic  ifPresent: [
		: aCollectionOfCallbacks | aCollectionOfCallbacks add: aCallback.
	]  ifAbsent:[
		topicHandle at:aTopic put: (Set newFrom: { aCallback }).
		self subscriber interestedIn: aTopic. 
	] .  
	
	
	
]

{ #category : #building }
PhaROSNodeHandle >> topicPublisher: aTopicName typedAs: aTypeId [
	^ PhaROSTopicPublisher node: self topic: (self lookupTopic: aTopicName typedAs: aTypeId).
]
