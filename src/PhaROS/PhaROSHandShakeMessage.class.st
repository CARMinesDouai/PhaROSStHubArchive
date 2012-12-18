Class {
	#name : #PhaROSHandShakeMessage,
	#superclass : #Object,
	#traits : 'TEquality + TLogger',
	#classTraits : 'TEquality classTrait + TLogger classTrait',
	#instVars : [
		'header'
	],
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> configure: aMessage with: aMessageConfigurationBlock [
	aMessageConfigurationBlock value: aMessage.
	^ aMessage.
	
]

{ #category : #'instance creation decoding' }
PhaROSHandShakeMessage class >> newFrom: byteArray [
	^RoStHandShakeMessageDecoder decode: byteArray.
	

]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newPublisher [
	^ PhaROSHandShakeMessagePublisher new.
]

{ #category : #'instance creation decoding' }
PhaROSHandShakeMessage class >> newPublisherMessageFrom: byteArray [
	^PhaROSHandShakeMessageDecoder decodePublisherMessage: byteArray.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newPublisherWith: aMessageConfigurationBlock [
	^ self configure: self newPublisher with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newService [
	^ PhaROSHandShakeMessageService new.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newServiceClient [
	^ PhaROSHandShakeMessageServiceClient new.
]

{ #category : #'instance creation decoding' }
PhaROSHandShakeMessage class >> newServiceClientMessageFrom: byteArray [
	^RoStHandShakeMessageDecoder decodeServiceClientMessage: byteArray.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newServiceClientWith: aMessageConfigurationBlock [
	^ self configure: self newServiceClient with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation decoding' }
PhaROSHandShakeMessage class >> newServiceMessageFrom: byteArray [
	^PhaROSHandShakeMessageDecoder decodeServiceMessage: byteArray.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newServiceWith: aMessageConfigurationBlock [
	^ self configure: self newService with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newSubscriber [
	^  PhaROSHandShakeMessageSubscriber new.
]

{ #category : #'instance creation decoding' }
PhaROSHandShakeMessage class >> newSubscriberMessageFrom: byteArray [
	^PhaROSHandShakeMessageDecoder decodeSubscriberMessage: byteArray.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newSubscriberWith: aMessageConfigurationBlock [
	^ self configure: self newSubscriber with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newUnknownFormat [
	^ PhaROSHandShakeMessage new

	
	
]

{ #category : #'instance creation' }
PhaROSHandShakeMessage class >> newWith: aMessageConfigurationBlock. [
	^ self configure: self newUnknownFormat  with:  aMessageConfigurationBlock.

	
	
]

{ #category : #comparing }
PhaROSHandShakeMessage >> = anObject [ 
	self species = anObject species ifFalse: [^false].
	^self valuesToCompareForEquality = anObject valuesToCompareForEquality
]

{ #category : #'base-accessing' }
PhaROSHandShakeMessage >> at: aKey [
	 ^ self header at: aKey.
]

{ #category : #'base-accessing' }
PhaROSHandShakeMessage >> at: aKey put: aValue [

	^self header at: aKey put: aValue.
]

{ #category : #accessing }
PhaROSHandShakeMessage >> attributesDo: aBlockClosure [ 
	^ header associationsDo: aBlockClosure.
]

{ #category : #accessing }
PhaROSHandShakeMessage >> callerId [
	^ self at: 'callerid'.
]

{ #category : #accessing }
PhaROSHandShakeMessage >> callerId: aString [ " String "
	^ self at: 'callerid' put: aString.
]

{ #category : #accessing }
PhaROSHandShakeMessage >> communicationError [
	^self at:'error'.
	

]

{ #category : #accessing }
PhaROSHandShakeMessage >> communicationError: anError [
	^self at:'error' put: anError.
	

]

{ #category : #'base-accessing' }
PhaROSHandShakeMessage >> header [ 
	^header.
]

{ #category : #comparing }
PhaROSHandShakeMessage >> initialize [
	super initialize.
	header := OrderPreservingDictionary new.
"	self messageDefinition: ('string data', Character lf asString,  Character lf asString)."
]

{ #category : #accessing }
PhaROSHandShakeMessage >> md5Sum [
	^ self at: 'md5sum'.
	
	

]

{ #category : #accessing }
PhaROSHandShakeMessage >> md5Sum: aStringHashed [
	^ self at: 'md5sum' put: aStringHashed.
	
	

]

{ #category : #accessing }
PhaROSHandShakeMessage >> messageDefinition [
	^self at: 'message_definition'.
]

{ #category : #accessing }
PhaROSHandShakeMessage >> messageDefinition: aString [
	^self at: 'message_definition' put: aString.
]

{ #category : #'base-accessing' }
PhaROSHandShakeMessage >> optativeAt: aKey [
	 ^ self header at: aKey ifAbsent: [ nil ].
]

{ #category : #printing }
PhaROSHandShakeMessage >> printOn: aStream [
	super printOn: aStream.
	aStream 
		crlf; 
		nextPutAll: '"**** Header ****"';
		crlf.

	 header keysAndValuesDo: [ : fieldName : fieldValue |
			aStream crlf; tab.
			fieldName printOn: aStream.
			aStream nextPutAll: ' -> '.
			fieldValue printOn: aStream
	].



]

{ #category : #accessing }
PhaROSHandShakeMessage >> requestType [
	^self at:'request_type'.
	

]

{ #category : #accessing }
PhaROSHandShakeMessage >> requestType: anString [
	^self at:'request_type' put: anString.
	

]

{ #category : #accessing }
PhaROSHandShakeMessage >> responseType [
	^self at: 'response_type' 
]

{ #category : #accessing }
PhaROSHandShakeMessage >> responseType: aString [
	^self at: 'response_type'  put: aString.
]

{ #category : #communication }
PhaROSHandShakeMessage >> sendTo: aSocket [
	aSocket sendData: (PhaROSHandShakeMessageEncoder encode: self).
		

]

{ #category : #comparing }
PhaROSHandShakeMessage >> valuesToCompareForEquality [
	^{ header }
]

{ #category : #verification }
PhaROSHandShakeMessage >> verificationDictionary [
	^ { 
		#callerId -> ByteString .   
	} asDictionary .
]

{ #category : #verification }
PhaROSHandShakeMessage >> verify [

	self debug: [ 'Verifying header consistence with ', self verificationDictionary asString ].
	self debug: [ self header ].
	
	
	self flag:#cleanUpThisMess.
	
	self header size = 0 ifTrue: [ ^ self ].
	^
	self verificationDictionary keysAndValuesDo: [ :key :val | 
		self assert: [ (self perform: key asSymbol ) class = val ]
	].
	
]

{ #category : #accessing }
PhaROSHandShakeMessage >> withHeader: aBlockClosure [ 
	^ aBlockClosure value: self.
]
