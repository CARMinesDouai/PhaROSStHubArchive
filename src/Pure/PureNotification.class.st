Class {
	#name : #PureNotification,
	#superclass : #PureMessage,
	#classInstVars : [
		'notificationTimeStamp'
	],
	#category : #'Pure-Messages'
}

{ #category : #'initialize-release' }
PureNotification class >> initializeFromArray:  aByteArray [
	| response decoder |
	response := self new.
	
	decoder := PureDecoder forArray: aByteArray.
	response target: decoder nextEncodedUInt16.
	"response notificationTimeStamp: (PDRConverter asFloat32FromDataArray: (response responseArray) fromIndex: 3)".
	response data: decoder upToEnd.
	^response
]

{ #category : #accessing }
PureNotification class >> notificationTimeStamp [
	^ notificationTimeStamp
]

{ #category : #accessing }
PureNotification class >> notificationTimeStamp: anObject [
	notificationTimeStamp := anObject
]

{ #category : #'as yet unclassified' }
PureNotification >> isNotification [
	^true
]

{ #category : #'initialize-release' }
PureNotification >> received [ 
	self announcer announce: self asAnnouncement.
]

{ #category : #'initialize-release' }
PureNotification >> success [
	^true
]
