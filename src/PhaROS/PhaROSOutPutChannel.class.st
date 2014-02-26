Class {
	#name : #PhaROSOutPutChannel,
	#superclass : #PhaROSChannel,
	#instVars : [
		'subscribers',
		'mutex',
		'xmlurl'
	],
	#category : #'PhaROS-Kernel-Channels'
}

{ #category : #'as yet unclassified' }
PhaROSOutPutChannel class >> for: aNode into: aTopic [

	^ self new owner: aNode; topic: aTopic; startUp; yourself.
]

{ #category : #service }
PhaROSOutPutChannel >> finalize [
	"self owner unregisterPublisherFrom: topic name.
	"
	subscribers select:[ : s | s isKindOf: PhaROSInternalNodeLink ] thenDo: [
		: link | link close.	
	].
	
	self initialize.
	
]

{ #category : #service }
PhaROSOutPutChannel >> initialize [ 
	super initialize .
	subscribers := Set new.
	mutex := Mutex new.
]

{ #category : #testing }
PhaROSOutPutChannel >> isInput [ 
	^ false.
]

{ #category : #'message handling' }
PhaROSOutPutChannel >> newMessage [ 
	^ topic newMessage.
]

{ #category : #tcp }
PhaROSOutPutChannel >> printOn: aStream [
	aStream nextPutAll: 'OutputChannel>> ',topic name. 
]

{ #category : #tcp }
PhaROSOutPutChannel >> publisher [
	^ PhaROSPublisher for: self.
]

{ #category : #service }
PhaROSOutPutChannel >> send: aMessage [
	self subscribers do: [ : aNode |  self send: aMessage to: aNode. ].
]

{ #category : #'message handling' }
PhaROSOutPutChannel >> sendAMessage: aMessageConfigurationBlock [
	| message |
	message := self newMessage.
	
	aMessageConfigurationBlock value: message value.
	^ self send: message.

]

{ #category : #'message handling' }
PhaROSOutPutChannel >> sendAMessage: aMessageConfigurationBlock to: aNode [
	| message |
	message := self newMessage.
	
	aMessageConfigurationBlock value: message value.
	^ self send: message to: aNode.

]

{ #category : #service }
PhaROSOutPutChannel >> subscribe: aSubscriber [ 
	mutex critical: [
		subscribers add: aSubscriber.
	]
]

{ #category : #service }
PhaROSOutPutChannel >> subscribers [ 
	| copy | 
	mutex critical: [
		copy := subscribers copy.
	].
	^copy
]

{ #category : #tcp }
PhaROSOutPutChannel >> topic: aTopic [
	super topic: aTopic.
]

{ #category : #service }
PhaROSOutPutChannel >> unsubscribe: aNode [ 
	mutex critical: [
		subscribers remove: aNode ifAbsent: [].
	].
	

]

{ #category : #tcp }
PhaROSOutPutChannel >> xmlurl [ 
	^ xmlurl.
]

{ #category : #tcp }
PhaROSOutPutChannel >> xmlurl: anURL [
	xmlurl := anURL 
]
