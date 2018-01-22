Class {
	#name : #BcBody,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'BotController-Bodies'
}

{ #category : #announcing }
BcBody >> announce: announcement [
	self announcer announce: announcement
]

{ #category : #announcing }
BcBody >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #announcing }
BcBody >> announcer: anObject [
	announcer := anObject
]

{ #category : #announcing }
BcBody >> removeSubscription: announcementSubscription [
	self announcer removeSubscription: announcementSubscription
]

{ #category : #acting }
BcBody >> shutDown [
	self stop.
	self announce: BcShutdownAnnouncement new
]

{ #category : #acting }
BcBody >> startUp [
	self announce: BcStartUpAnnouncement new
]

{ #category : #acting }
BcBody >> stop [
	self velocityForward: 0 rotation: 0
]

{ #category : #announcing }
BcBody >> subscribe: announcementClass do: aBlock [
	^self announcer subscribe: announcementClass do: aBlock
]

{ #category : #announcing }
BcBody >> unsubscribe: anObject [
	^self announcer unsubscribe: anObject
]

{ #category : #acting }
BcBody >> velocityForward: forwardSpeed [
	self velocityForward: forwardSpeed rotation: 0

]

{ #category : #acting }
BcBody >> velocityForward: forwardSpeed rotation: rotationSpeed [
	| annoucement |
	annoucement := BcVelocityForwardRotationAnnouncement forward: forwardSpeed rotation: rotationSpeed.
	self announce: annoucement
]

{ #category : #acting }
BcBody >> velocityRotation: rotationSpeed [
	self velocityForward: 0 rotation: rotationSpeed

]
