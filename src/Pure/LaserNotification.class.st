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
LaserNotification >> closeTo: anOtherNotification [
| compare |
	
	compare := (anOtherNotification isKindOf: self class) .
	compare ifFalse: [ ^ compare ].
	echoes with: anOtherNotification echoes do: [
			:e1 :e2 | compare := compare and: [ e1 closeTo: e2 ]
	].

	^ compare.
	
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
	super initialize. 
	echoes := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
LaserNotification >> load: notificationSource [
	| decoder max lap |
	
	decoder := notificationSource decoder.
	self loadTime: decoder.
	
	[ decoder hasData ] whileTrue: [
		echoes add: ( LaserEcho createEchoWithAngle: (decoder nextEncodedFloat32)  andFloatDistance: (decoder nextEncodedFloat32) )
	].
	 

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
