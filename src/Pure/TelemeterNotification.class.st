Class {
	#name : #TelemeterNotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'distances'
	],
	#category : #'Pure-Notifications'
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

	decoder := notificationSource decoder.
	self loadTime: decoder.
	
	[ decoder hasData ] whileTrue: [
		distances add: decoder nextEncodedFloat32
	].
]
