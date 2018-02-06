"
I am an announcement issued when the left and right speeds of the robot are set

    Instance Variables
	left:		<Number>
	right:		<Number>

"
Class {
	#name : #BcSpeedLeftRightAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'left',
		'right'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcSpeedLeftRightAnnouncement class >> left: leftSpeed right: rightSpeed [
	^self new
		left: leftSpeed;
		right: rightSpeed
		yourself
]

{ #category : #accessing }
BcSpeedLeftRightAnnouncement >> left [
	^ left
]

{ #category : #accessing }
BcSpeedLeftRightAnnouncement >> left: anObject [
	left := anObject
]

{ #category : #accessing }
BcSpeedLeftRightAnnouncement >> right [
	^ right
]

{ #category : #accessing }
BcSpeedLeftRightAnnouncement >> right: anObject [
	right := anObject
]
