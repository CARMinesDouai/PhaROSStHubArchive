Class {
	#name : #TelemeterNotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'distances'
	],
	#category : #'PureNoLog-Notifications'
}

{ #category : #'as yet unclassified' }
TelemeterNotification >> distances [ 
	^distances 
]

{ #category : #'as yet unclassified' }
TelemeterNotification >> initialize [
	super initialize. 
	distances := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
TelemeterNotification >> load: notificationSource [
	| decoder |
	super load: notificationSource.
	decoder := notificationSource decoder.
	[ decoder hasData ] whileTrue: [
		distances add: decoder nextEncodedFloat32
	].
]
