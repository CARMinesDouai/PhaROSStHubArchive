"
This class represents the basic message  structure for messages for TCPROS protocol. All the handshake messages and the service messages are based on this

"
Class {
	#name : #PhaROSHSMessageHeader,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'header'
	],
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> configure: aMessage with: aMessageConfigurationBlock [
	aMessageConfigurationBlock value: aMessage.
	^ aMessage.
	
]

{ #category : #verification }
PhaROSHSMessageHeader class >> genericHeader [
	^ self new .
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newPublisher [
	^ PhaROSHSPublisherHeader new.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessageHeader class >> newPublisherMessageFrom: byteArray [
	^PhaROSHSMessageDecoder decodePublisherMessage: byteArray.
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newPublisherWith: aMessageConfigurationBlock [
	^ self configure: self newPublisher with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newService [
	^ PhaROSHSServiceHeader new.
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newServiceClient [
	^ PhaROSHSServiceClientHeader new.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessageHeader class >> newServiceClientMessageFrom: aStream [
	^PhaROSHSMessageDecoder decodeServiceClientMessage: aStream.
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newServiceClientWith: aMessageConfigurationBlock [
	^ self configure: self newServiceClient with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessageHeader class >> newServiceMessageFrom: aStream [
	^PhaROSHSMessageDecoder decodeServiceMessage: aStream.
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newServiceWith: aMessageConfigurationBlock [
	^ self configure: self newService with:  aMessageConfigurationBlock.
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newSubscriber [
	^  PhaROSHSSubscriberHeader new.
]

{ #category : #'instance creation decoding' }
PhaROSHSMessageHeader class >> newSubscriberMessageFrom: aStream [
	^PhaROSHSMessageDecoder decodeSubscriberMessage: aStream.
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> newSubscriberWith: aMessageConfigurationBlock [
	^ self configure: self newSubscriber with:  aMessageConfigurationBlock.
]

{ #category : #verification }
PhaROSHSMessageHeader class >> verificationDictionary [
	^ { 
		#callerId -> ByteString .   
	} asDictionary .
]

{ #category : #'instance creation' }
PhaROSHSMessageHeader class >> withHeader: aDictionary [ 	
	^ self new withHeader: aDictionary; yourself
]

{ #category : #comparing }
PhaROSHSMessageHeader >> = anObject [ 
	self species = anObject species ifFalse: [^false].
	^self valuesToCompareForEquality = anObject valuesToCompareForEquality
]

{ #category : #'base-accessing' }
PhaROSHSMessageHeader >> at: aKey [
	 ^ self header at: aKey.
]

{ #category : #'base-accessing' }
PhaROSHSMessageHeader >> at: aKey put: aValue [

	^self header at: aKey put: aValue.
]

{ #category : #accessing }
PhaROSHSMessageHeader >> attributesDo: aBlockClosure [ 
	^ header associationsDo: aBlockClosure.
]

{ #category : #accessing }
PhaROSHSMessageHeader >> becomeKnown [
	header at: #topic ifPresent:[
		^ PhaROSHSSubscriberHeader withHeader: header.	
	].
	header at:#service ifPresent:[
		^ PhaROSHSServiceClientHeader withHeader: header.	
	].
	self error: 'The header has not any expected shape for incoming headers'.
]

{ #category : #accessing }
PhaROSHSMessageHeader >> callerId [
	^ self at: 'callerid'.
]

{ #category : #accessing }
PhaROSHSMessageHeader >> callerId: aString [ " String "
	^ self at: 'callerid' put: aString.
]

{ #category : #accessing }
PhaROSHSMessageHeader >> communicationError [
	^self at:'error'.
	

]

{ #category : #accessing }
PhaROSHSMessageHeader >> communicationError: anError [
	^self at:'error' put: anError.
	

]

{ #category : #'base-accessing' }
PhaROSHSMessageHeader >> header [ 
	^header.
]

{ #category : #comparing }
PhaROSHSMessageHeader >> initialize [
	super initialize.
	header := OrderPreservingDictionary new.

]

{ #category : #accessing }
PhaROSHSMessageHeader >> md5Sum [
	^ self at: 'md5sum'.
	
	
	

]

{ #category : #accessing }
PhaROSHSMessageHeader >> md5Sum: aStringHashed [
	^ self at: 'md5sum' put: aStringHashed.
	
	

]

{ #category : #accessing }
PhaROSHSMessageHeader >> messageDefinition [
	^self at: 'message_definition'.
]

{ #category : #accessing }
PhaROSHSMessageHeader >> messageDefinition: aString [
	^self at: 'message_definition' put: aString.
]

{ #category : #'base-accessing' }
PhaROSHSMessageHeader >> optativeAt: aKey [
	 ^ self header at: aKey ifAbsent: [ nil ].
]

{ #category : #printing }
PhaROSHSMessageHeader >> printOn: aStream [
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

{ #category : #communication }
PhaROSHSMessageHeader >> sendTo: aSocket [
	aSocket sendData: (PhaROSHSMessageEncoder encode: self).
		

]

{ #category : #comparing }
PhaROSHSMessageHeader >> valuesToCompareForEquality [
	^{ header }
]

{ #category : #accessing }
PhaROSHSMessageHeader >> withHeader: aDictionary [
	header := aDictionary 
]
