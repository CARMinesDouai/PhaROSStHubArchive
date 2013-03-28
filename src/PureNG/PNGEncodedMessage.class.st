Class {
	#name : #PNGEncodedMessage,
	#superclass : #Object,
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGEncodedMessage class >> deliverData: rawDataStream to: aRobot [

	| dataDecoder responseType responseClass |
	
	dataDecoder := PNGDecoder newOn: rawDataStream.
	
	responseType := dataDecoder nextEncodedByte.
	
	responseClass := PNGResponse.
	((responseType = 0) or: [ responseType = 16rFF]) ifTrue: [ responseClass := PNGNotification ].
	
	^responseClass deliverWithDecoder: dataDecoder to: aRobot

]

{ #category : #'instance creation' }
PNGEncodedMessage class >> deliverWithDecoder: dataDecoder to: aRobot [

	
	^self subclassResponsibility 

]

{ #category : #'instance creation' }
PNGEncodedMessage class >> isNotification: rawData [
	^ (rawData at:1) = 16rFF.
]
