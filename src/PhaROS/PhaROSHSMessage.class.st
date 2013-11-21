"
This class represents the basic message  structure for messages for TCPROS protocol. All the handshake messages and the service messages are based on this

"
Class {
	#name : #PhaROSHSMessage,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'header'
	],
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #'instance creation' }
PhaROSHSMessage class >> configure: aMessage with: aMessageConfigurationBlock [
	aMessageConfigurationBlock value: aMessage.
	^ aMessage.
	
]

{ #category : #'instance creation decoding' }
PhaROSHSMessage class >> newFrom: byteArray [
	^RoStHandShakeMessageDecoder decode: byteArray.
	

]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newPublisher [
	^ PhaROSHSPublisher new.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessage class >> newPublisherMessageFrom: byteArray [
	^PhaROSHSMessageDecoder decodePublisherMessage: byteArray.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newPublisherWith: aMessageConfigurationBlock [
	^ self configure: self newPublisher with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newService [
	^ PhaROSHSService new.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newServiceClient [
	^ PhaROSHSServiceClient new.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessage class >> newServiceClientMessageFrom: aStream [
	^PhaROSHSMessageDecoder decodeServiceClientMessage: aStream.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newServiceClientWith: aMessageConfigurationBlock [
	^ self configure: self newServiceClient with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessage class >> newServiceMessageFrom: aStream [
	^PhaROSHSMessageDecoder decodeServiceMessage: aStream.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newServiceWith: aMessageConfigurationBlock [
	^ self configure: self newService with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newSubscriber [
	^  PhaROSHSSubscriber new.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessage class >> newSubscriberMessageFrom: aStream [
	^PhaROSHSMessageDecoder decodeSubscriberMessage: aStream.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newSubscriberWith: aMessageConfigurationBlock [
	^ self configure: self newSubscriber with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newUnknownFormat [
	^ PhaROSHSMessage new

	
	
]

{ #category : #'instance creation' }
PhaROSHSMessage class >> newWith: aMessageConfigurationBlock. [
	^ self configure: self newUnknownFormat  with:  aMessageConfigurationBlock.

	
	
]

{ #category : #verification }
PhaROSHSMessage class >> verificationDictionary [
	^ { 
		#callerId -> ByteString .   
	} asDictionary .
]

{ #category : #comparing }
PhaROSHSMessage >> = anObject [ 
	self species = anObject species ifFalse: [^false].
	^self valuesToCompareForEquality = anObject valuesToCompareForEquality
]

{ #category : #'base-accessing' }
PhaROSHSMessage >> at: aKey [
	 ^ self header at: aKey.
]

{ #category : #'base-accessing' }
PhaROSHSMessage >> at: aKey put: aValue [

	^self header at: aKey put: aValue.
]

{ #category : #accessing }
PhaROSHSMessage >> attributesDo: aBlockClosure [ 
	^ header associationsDo: aBlockClosure.
]

{ #category : #accessing }
PhaROSHSMessage >> callerId [
	^ self at: 'callerid'.
]

{ #category : #accessing }
PhaROSHSMessage >> callerId: aString [ " String "
	^ self at: 'callerid' put: aString.
]

{ #category : #accessing }
PhaROSHSMessage >> communicationError [
	^self at:'error'.
	

]

{ #category : #accessing }
PhaROSHSMessage >> communicationError: anError [
	^self at:'error' put: anError.
	

]

{ #category : #'base-accessing' }
PhaROSHSMessage >> header [ 
	^header.
]

{ #category : #comparing }
PhaROSHSMessage >> initialize [
	super initialize.
	header := OrderPreservingDictionary new.

]

{ #category : #accessing }
PhaROSHSMessage >> md5Sum [
	^ self at: 'md5sum'.
	
	

]

{ #category : #accessing }
PhaROSHSMessage >> md5Sum: aStringHashed [
	^ self at: 'md5sum' put: aStringHashed.
	
	

]

{ #category : #accessing }
PhaROSHSMessage >> messageDefinition [
	^self at: 'message_definition'.
]

{ #category : #accessing }
PhaROSHSMessage >> messageDefinition: aString [
	^self at: 'message_definition' put: aString.
]

{ #category : #'base-accessing' }
PhaROSHSMessage >> optativeAt: aKey [
	 ^ self header at: aKey ifAbsent: [ nil ].
]

{ #category : #printing }
PhaROSHSMessage >> printOn: aStream [
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
PhaROSHSMessage >> requestType [
	^self at:'request_type'.
	

]

{ #category : #accessing }
PhaROSHSMessage >> requestType: anString [
	^self at:'request_type' put: anString.
	

]

{ #category : #accessing }
PhaROSHSMessage >> responseType [
	^self at: 'response_type' 
]

{ #category : #accessing }
PhaROSHSMessage >> responseType: aString [
	^self at: 'response_type'  put: aString.
]

{ #category : #communication }
PhaROSHSMessage >> sendTo: aSocket [
	aSocket sendData: (PhaROSHSMessageEncoder encode: self).
		

]

{ #category : #comparing }
PhaROSHSMessage >> valuesToCompareForEquality [
	^{ header }
]

{ #category : #accessing }
PhaROSHSMessage >> withHeader: aBlockClosure [ 
	^ aBlockClosure value: self.
]
