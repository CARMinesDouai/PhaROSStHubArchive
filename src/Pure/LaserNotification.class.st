Class {
	#name : #LaserNotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'echoes'
	],
	#category : #'Pure-Notifications'
}

{ #category : #'as yet unclassified' }
LaserNotification >> addEcho: aLinear and: anAngle [
	echoes add: ( LaserEcho createEchoWithAngle: anAngle andFloatDistance: aLinear ).
]

{ #category : #'as yet unclassified' }
LaserNotification >> angleDifferential [ 
	self flag:#enhanceThisThing.
	
	^((echoes at:2) angle - (echoes at:1) angle) abs.
]

{ #category : #'as yet unclassified' }
LaserNotification >> distances [
	^ self echoes collect: [ :echo | echo distance asFloat ].
]

{ #category : #'as yet unclassified' }
LaserNotification >> echoes [
	^ echoes
]

{ #category : #'as yet unclassified' }
LaserNotification >> initialize [ 
	echoes := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
LaserNotification >> load: notificationSource [
	| decoder |
	

	decoder := notificationSource decoder.
	
	"Ireally hate this stupid thing "
	decoder nextEncodedBytes: 8. 
	
	
	[ decoder hasData ] whileTrue: [
		echoes add: ( LaserEcho createEchoWithAngle: (decoder nextEncodedFloat32)  andFloatDistance: (decoder nextEncodedFloat32) )
	].

]

{ #category : #'as yet unclassified' }
LaserNotification >> maxAngle [
	^ echoes last angle
]

{ #category : #'as yet unclassified' }
LaserNotification >> maxRange [
	^ self distances max.
]

{ #category : #'as yet unclassified' }
LaserNotification >> minAngle [
	^ (echoes at: 1) angle
]

{ #category : #'as yet unclassified' }
LaserNotification >> minRange [
	^ self distances min.
]
