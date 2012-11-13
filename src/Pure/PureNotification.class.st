Class {
	#name : #PureNotification,
	#superclass : #PureMessage,
	#classInstVars : [
		'notificationTimeStamp'
	],
	#category : #'Pure-Messages'
}

{ #category : #'as yet unclassified' }
PureNotification class >> initializeFromArray:  aByteArray forRobot: robot [
	| response decoder |
	response := self new.
	
	decoder := PureDecoder forArray: aByteArray.
	response target: (robot instanceRelatedTo: decoder nextEncodedUInt16).
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

{ #category : #accessing }
PureNotification >> announcer [
	^ target announcer
]

{ #category : #'initialize-release' }
PureNotification >> asAnnouncement [
	^ ServiceNotification for: self target with: self.

]

{ #category : #'initialize-release' }
PureNotification >> decoder [
	^ PureDecoder for: (ReadStream on: self data).
	
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
