"
PhaROSTopic is the representation of a [ ros topic | http://www.ros.org/wiki/Topics ].

This representation put together a set of input and output channels, that represents the communcation between one publisher node and n subscribers nodes. 
"
Class {
	#name : #PhaROSTopic,
	#superclass : #Object,
	#instVars : [
		'name',
		'master',
		'type',
		'inputChannels',
		'outputChannels'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSTopic class >> build: aTopicName asking: aMaster [
	^self new name: aTopicName; 
			  master: aMaster; 
			  type: (aMaster getTopicType: aTopicName);
			  yourself.
]

{ #category : #service }
PhaROSTopic >> allInputChannelsFor: aSubscriber  but: aSetOfChannelsToAvoid [
	| externalNodesXMLRPCUrls newChannels |
	
	externalNodesXMLRPCUrls :=  (aSubscriber master registerSubscriber: aSubscriber  name to: self name  with: self type andCallerUri: aSubscriber  xmlRpcUrl) asSet .
	
	newChannels := externalNodesXMLRPCUrls reject:[ :url | aSetOfChannelsToAvoid anySatisfy: [ :ch | ch isRelatedWith: url ] ].
	newChannels := newChannels collect: [: anXMLRPCUrl | self lookupInputChannelFor: aSubscriber with: anXMLRPCUrl  ].
	
	
	^newChannels.
]

{ #category : #'as yet unclassified' }
PhaROSTopic >> busInfoFor: aNode [

	 ^ { 
		{ '0' . '/turtlesim' . 'o' . 'TCPROS' . '/turtle1/command_velocity' }  
	}.
]

{ #category : #accessing }
PhaROSTopic >> initialize [ 
	inputChannels := Dictionary new.
	outputChannels := Dictionary  new.
]

{ #category : #accessing }
PhaROSTopic >> inputChannels [ 
	^ inputChannels 
]

{ #category : #service }
PhaROSTopic >> lookupInputChannelFor: aPhaROSNode with: anXMLRPCUrl [ 
	^ outputChannels at: anXMLRPCUrl  ifAbsent:[ 
		     inputChannels  at: anXMLRPCUrl  ifAbsentPut:[  
				PhaROSChannel inputChannelfor: aPhaROSNode into: self  to: anXMLRPCUrl.
		].
	]
]

{ #category : #accessing }
PhaROSTopic >> master [
	^ master
]

{ #category : #new }
PhaROSTopic >> master: aMaster [
	master := aMaster.
	 
]

{ #category : #accessing }
PhaROSTopic >> md5Sum [
	^ self typeFactory md5Sum.
	
	
	

]

{ #category : #new }
PhaROSTopic >> name [ 
	^ name.
]

{ #category : #new }
PhaROSTopic >> name: aTopicName [
	name := aTopicName.
	
]

{ #category : #new }
PhaROSTopic >> newMessage [
	^ self typeFactory newPacket.
	
	 
]

{ #category : #'as yet unclassified' }
PhaROSTopic >> outputChannelFor: aPublisher [
	^ PhaROSChannel outPutChannelfor: aPublisher  into: self.
]

{ #category : #accessing }
PhaROSTopic >> outputChannels [ 
	^ outputChannels 
]

{ #category : #construction }
PhaROSTopic >> printOn: aStream [
	aStream nextPutAll: 'Topic>>', self name. 
]

{ #category : #accessing }
PhaROSTopic >> registerOutputChannel: aChannel at: aXmlRpcUrl [
	outputChannels at: aXmlRpcUrl put: aChannel.
]

{ #category : #new }
PhaROSTopic >> stop [
	
	inputChannels do: #close.
	outputChannels do: #close.
	
	inputChannels removeAll.
	outputChannels removeAll.
	"master := nil. "
]

{ #category : #new }
PhaROSTopic >> type [
	^type.

	
	 
]

{ #category : #new }
PhaROSTopic >> type: aTopicType [
	type := aTopicType.
	
	 
]

{ #category : #construction }
PhaROSTopic >> typeFactory [
	^self master typeFactory: self type
]
