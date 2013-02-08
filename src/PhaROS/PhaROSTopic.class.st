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

{ #category : #service }
PhaROSTopic >> lookupInputChannelFor: aRoStNode with: anXMLRPCUrl [ 
	^ outputChannels at: anXMLRPCUrl  ifAbsent:[ 
		     inputChannels  at: anXMLRPCUrl  ifAbsentPut:[  
				PhaROSChannel inputChannelfor: aRoStNode into: self  to: anXMLRPCUrl.
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
	self flag:#loadFromvariable.
	^self name = '/turtle1/pose' ifTrue: [
		'863b248d5016ca62ea2e895ae5265cf9'
	] ifFalse: [
		'9d5c2dcd348ac8f76ce2a4307bd63a13'
	].
	
	
	
	

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

{ #category : #construction }
PhaROSTopic >> packetSize [ 
	^ self typeSize + 4
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

{ #category : #construction }
PhaROSTopic >> typeSize [
	^ self typeFactory dataTypeSize.	
]
