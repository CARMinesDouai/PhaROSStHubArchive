Class {
	#name : #PNGEncodedMessage,
	#superclass : #Object,
	#instVars : [
		'target',
		'decoder'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGEncodedMessage class >> createResponseOrNotificationForData: rawDataStream [

	| dataDecoder responseType responseClass |
	
	dataDecoder := PNGDecoder newOn: rawDataStream.
	
	responseType := dataDecoder nextEncodedByte.
	
	responseClass := PNGResponse.
	((responseType = 0) or: [ responseType = 16rFF]) ifTrue: [ responseClass := PNGNotification ].
	
	^responseClass newWithDecoder: dataDecoder

]

{ #category : #'instance creation' }
PNGEncodedMessage class >> newWithDecoder: rawData [ 

	
	^self subclassResponsibility 

]

{ #category : #accessing }
PNGEncodedMessage >> decoder [
	^ decoder
]

{ #category : #accessing }
PNGEncodedMessage >> decoder: aDecoder [
	decoder := aDecoder
]

{ #category : #testing }
PNGEncodedMessage >> hasData [
	^ decoder hasData 
]

{ #category : #testing }
PNGEncodedMessage >> isNotification [
	^false
]

{ #category : #accessing }
PNGEncodedMessage >> target [
	^target
]

{ #category : #accessing }
PNGEncodedMessage >> target: anObject [
	target := anObject
]
