"
I am the facade to a robot body. I rely on some middleware to talk to the sensors and the actuators of the robot body.

I also rely on annoucements to allow observing robot activity. Examples of observers are BcBodyLogger and BcLaserDrivenSensePlanActRunner

    Instance Variables
	announcer:		<Announcer>
	dimensions:		<BcBodyDimensions>

I am abstract. Subclasses should implement:
-newDimensions
Answers an object that provides dimensions of the robot.

"
Class {
	#name : #BcBody,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'dimensions'
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

{ #category : #accessing }
BcBody >> dimensions [
	^dimensions
]

{ #category : #initialization }
BcBody >> initialize [
	super initialize.
	dimensions := self newDimensions
]

{ #category : #initialization }
BcBody >> newDimensions [
	self subclassResponsibility
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
