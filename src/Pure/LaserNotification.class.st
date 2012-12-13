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
LaserNotification >> angles [
	^ self echoes collect: [ :echo | echo angle asFloat ].
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
	| decoder max |
	

	decoder := notificationSource decoder.
	
	self loadTime: decoder.
	
	[ decoder hasData ] whileTrue: [
		echoes add: ( LaserEcho createEchoWithAngle: (decoder nextEncodedFloat32)  andFloatDistance: (decoder nextEncodedFloat32) )
	].
	

	max := echoes max.
	[	
		max distance > service maxAcceptableRange.
	] whileTrue: [
		| id valPrev valPost |
		id := echoes indexOf: max.
		
		valPrev := echoes at:(id -1).
		valPost := echoes at:(id +1).
		
		max distance: ((valPrev distance + valPost distance) / 2).
		max := echoes max.
	] 

]

{ #category : #'as yet unclassified' }
LaserNotification >> maxAngle [
	^ self angles max.
]

{ #category : #'as yet unclassified' }
LaserNotification >> maxRange [
	^ self distances max.
]

{ #category : #'as yet unclassified' }
LaserNotification >> minAngle [
	^ self angles min.
]

{ #category : #'as yet unclassified' }
LaserNotification >> minRange [
	^ self distances min.
]
