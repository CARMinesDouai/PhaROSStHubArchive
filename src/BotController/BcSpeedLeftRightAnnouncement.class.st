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
