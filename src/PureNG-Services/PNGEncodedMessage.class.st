Class {
	#name : #PNGEncodedMessage,
	#superclass : #Object,
	#instVars : [
		'target',
		'robot',
		'decoder'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGEncodedMessage class >> createResponseOrNotificationForData: rawDataStream andRobot: aRobulab [

	| dataDecoder responseType responseClass |
	
	dataDecoder := PNGDecoder newOn: rawDataStream.
	
	responseType := dataDecoder nextEncodedByte.
	
	responseClass := PNGResponse.
	((responseType = 0) or: [ responseType = 16rFF]) ifTrue: [ responseClass := PNGNotification ].
	
	^responseClass newWithDecoder: dataDecoder forRobot: aRobulab

]

{ #category : #'instance creation' }
PNGEncodedMessage class >> newWithDecoder: rawData forRobot: aRobulab [

	
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
PNGEncodedMessage >> robot [
	^robot
	
]

{ #category : #accessing }
PNGEncodedMessage >> robot: aRobulab [
	robot := aRobulab 
	
]

{ #category : #accessing }
PNGEncodedMessage >> target [
	^target
]

{ #category : #accessing }
PNGEncodedMessage >> target: anObject [
	target := anObject
]

{ #category : #decoder }
PNGEncodedMessage >> upToEnd [ 

	^ stream upToEnd.
]
