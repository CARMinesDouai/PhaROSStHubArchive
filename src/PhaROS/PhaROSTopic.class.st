"
[ ros topic | http://www.ros.org/wiki/Topics ]

Topics are named buses over which nodes exchange messages. 
Topics decouples the production of data from its consumption i.e.:
- 1 or more publisher nodes can send data into one specific topic
- 1 or more subscriber nodes can receive data from this same topic
- publishers and subscribers does not know each other and they are not aware of who they are communicating with.

PhaROSTopic is the Pharo representation of this Topic concept.
A PhaROSTopic has an input and an output channels (cf. PhaROSChannel) that relate a publisher node with some subscribers. 

{ PhaROSChannel documentation }

When a node registers in a topic as publisher, the topic add a new PhaROSOutPutChannel,  when a node register as subscriber, the topic register the node in all existing channels as subscriber, register in the master as subscriber. Thanks to this architecture, if we have a local publisher and a local subscriber of the same topic, the connection in between them will be just an object, avoiding not just connection, but also serialization process. 
"
Class {
	#name : #PhaROSTopic,
	#superclass : #Object,
	#instVars : [
		'name',
		'type',
		'typeFactory',
		'channels'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSTopic >> busInfoFor: aNode [

	 ^ { 
		{ '0' . '/turtlesim' . 'o' . 'TCPROS' . '/turtle1/command_velocity' }  
	}.
]

{ #category : #accessing }
PhaROSTopic >> channels [
	^ channels 
]

{ #category : #'as yet unclassified' }
PhaROSTopic >> finalize [ 
	channels do: #finalize.
	channels removeAll.
]

{ #category : #accessing }
PhaROSTopic >> initialize [ 
	channels := Set new.
]

{ #category : #accessing }
PhaROSTopic >> inputchannels [
	^ self channels select: #isInput
]

{ #category : #accessing }
PhaROSTopic >> isAPublisher: aNode [
	^ self outputchannels anySatisfy: [ : c | c owner = aNode ] 
]

{ #category : #accessing }
PhaROSTopic >> isLatched [ 
	^ true
]

{ #category : #accessing }
PhaROSTopic >> isLocalPublisher:  anURL [
	^ self outputchannels anySatisfy:  [ : c | c  xmlurl = anURL ].
]

{ #category : #accessing }
PhaROSTopic >> isSubscribedTo: aNode [

	self inputChannels 
]

{ #category : #accessing }
PhaROSTopic >> md5Sum [
	^ self typeFactory md5Sum.
	
	
	

]

{ #category : #accessing }
PhaROSTopic >> name [ 
	^ name.
]

{ #category : #accessing }
PhaROSTopic >> name: aTopicName [
	name := aTopicName.
	
]

{ #category : #new }
PhaROSTopic >> newMessage [
	^ self typeFactory newPacket.
	
	 
]

{ #category : #accessing }
PhaROSTopic >> outputchannel: anURL [
	^ self outputchannels detect: [ : c | c  xmlurl = anURL ].
]

{ #category : #accessing }
PhaROSTopic >> outputchannels [ 
	^ self channels select: #isOutput. 
]

{ #category : #construction }
PhaROSTopic >> printOn: aStream [
	aStream nextPutAll: 'Topic>>', self name. 
]

{ #category : #accessing }
PhaROSTopic >> publishingChannelFor: aNode [ 
	^ self channels detect: [ : ch | ch isOutput and: [ ch owner = aNode ] ].
]

{ #category : #accessing }
PhaROSTopic >> publishingChannelFor: aNode throught: aTransport [
	^ self channels detect: [ : ch | ch owner = aNode and:[ ch isOutput ] ] ifNone: [ 
		 aTransport createOutputChannelForTopic: self 
	].
]

{ #category : #accessing }
PhaROSTopic >> registerChannel: aChannel [
	(self channels anySatisfy: [ : ch | ch owner = aChannel owner and: [ ch isInput = aChannel isInput ]] ) ifTrue: [
		self error: ' There is already a channel for this owner '.	
	].
	channels add: aChannel. 
	^ aChannel.
]

{ #category : #accessing }
PhaROSTopic >> subscribingChannelFor: aNode [ 
	^ self channels detect: [ : ch | ch isInput and: [ ch owner = aNode ]] .

]

{ #category : #accessing }
PhaROSTopic >> subscribingChannelFor: aNode throught: aTransport [
	^ self channels detect: [ : ch | ch isInput and: [ ch owner = aNode ]] ifNone: [ 
		aTransport createInputChannelForTopic: self .
	].

]

{ #category : #accessing }
PhaROSTopic >> type [
	^type.

	
	 
]

{ #category : #accessing }
PhaROSTopic >> type: aTopicType [
	type := aTopicType.
	
	 
]

{ #category : #construction }
PhaROSTopic >> typeFactory [
	^ typeFactory
]

{ #category : #construction }
PhaROSTopic >> typeFactory: aTypeFactory [
	typeFactory := aTypeFactory 
]
