Class {
	#name : #RobulabNotification,
	#superclass : #RobulabMessage,
	#classInstVars : [
		'notificationTimeStamp'
	],
	#category : #'Pure-Robulab'
}

{ #category : #'initialize-release' }
RobulabNotification class >> initializeFromArray:  tableau [
	| response |
	response := RobulabNotification new.
	response responseArray: (response correctResponse: tableau ).
	response idRequete: (response responseArray at: 1).
	response target: (((response responseArray at: 2), (response responseArray at: 3)asString) ).
	"response notificationTimeStamp: (PDRConverter asFloat32FromDataArray: (response responseArray) fromIndex: 3)".
	
	^response
]

{ #category : #accessing }
RobulabNotification class >> notificationTimeStamp [
	^ notificationTimeStamp
]

{ #category : #accessing }
RobulabNotification class >> notificationTimeStamp: anObject [
	notificationTimeStamp := anObject
]

{ #category : #'as yet unclassified' }
RobulabNotification >> isNotification [
	^true
]

{ #category : #'initialize-release' }
RobulabNotification >> success [
	^true
]
