Class {
	#name : #BcRepeater,
	#superclass : #BcTimer,
	#instVars : [
		'period',
		'repeatedBlock'
	],
	#category : #'BotController-Body'
}

{ #category : #'instance creation' }
BcRepeater class >> duration: totalDuration period: stepDuration [
	^(self duration: totalDuration)
		period: stepDuration;
		yourself
]

{ #category : #actions }
BcRepeater >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self repeatedBlock: [ super leftSpeed: newLeftSpeed rightSpeed: newRightSpeed ].
	self start
]

{ #category : #accessing }
BcRepeater >> period [
	^ period
]

{ #category : #accessing }
BcRepeater >> period: anObject [
	period := anObject
]

{ #category : #actions }
BcRepeater >> repeat: aBlock [
	self isTimeOver
		whileFalse: [ aBlock value.
			self period wait ] 
]

{ #category : #accessing }
BcRepeater >> repeatedBlock [
	^ repeatedBlock
]

{ #category : #accessing }
BcRepeater >> repeatedBlock: anObject [
	repeatedBlock := anObject
]

{ #category : #actions }
BcRepeater >> start [
	| isRepetitionStopped |
	isRepetitionStopped := self isTimeOver.
	super start.
	isRepetitionStopped
		ifFalse: [ ^ self ].
	[self isTimeOver]
		whileFalse: [ self repeatedBlock value.
			self period wait ]
]
