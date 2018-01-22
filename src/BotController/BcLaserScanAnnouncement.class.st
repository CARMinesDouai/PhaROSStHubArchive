Class {
	#name : #BcLaserScanAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'echoes'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcLaserScanAnnouncement class >> echoes: newEchoes [
	^self new
		echoes: newEchoes;
		yourself
]

{ #category : #accessing }
BcLaserScanAnnouncement >> echoes [
	^ echoes
]

{ #category : #accessing }
BcLaserScanAnnouncement >> echoes: anObject [
	echoes := anObject
]
