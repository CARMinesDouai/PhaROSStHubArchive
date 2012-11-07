Class {
	#name : #PureNotification,
	#superclass : #PureMessage,
	#classInstVars : [
		'notificationTimeStamp'
	],
	#category : #'Pure-Messages'
}

{ #category : #'initialize-release' }
PureNotification class >> initializeFromArray:  tableau [
	| response |
	response := PureNotification new.
	response responseArray: (self correctResponse: tableau ).
	response idRequete: (response responseArray at: 1).
	response target: (((response responseArray at: 2), (response responseArray at: 3)asString) ).
	"response notificationTimeStamp: (PDRConverter asFloat32FromDataArray: (response responseArray) fromIndex: 3)".
	
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
