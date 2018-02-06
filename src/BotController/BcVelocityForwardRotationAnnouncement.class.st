"
I am an announcement issued when the forward speed and the rotation speed of the robot are set

    Instance Variables
	forward:		<Number>
	rotation:		<Number>

"
Class {
	#name : #BcVelocityForwardRotationAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'forward',
		'rotation'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcVelocityForwardRotationAnnouncement class >> forward: forwardSpeed rotation: rotationSpeed [
	^self new
		forward: forwardSpeed;
		rotation: rotationSpeed;
		yourself
]

{ #category : #accessing }
BcVelocityForwardRotationAnnouncement >> forward [
	^ forward
]

{ #category : #accessing }
BcVelocityForwardRotationAnnouncement >> forward: anObject [
	forward := anObject
]

{ #category : #accessing }
BcVelocityForwardRotationAnnouncement >> rotation [
	^ rotation
]

{ #category : #accessing }
BcVelocityForwardRotationAnnouncement >> rotation: anObject [
	rotation := anObject
]
