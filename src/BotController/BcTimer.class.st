Class {
	#name : #BcTimer,
	#superclass : #BcBodyDecorator,
	#instVars : [
		'duration',
		'startTimestamp'
	],
	#category : #'BotController-Body'
}

{ #category : #'instance creation' }
BcTimer class >> duration: aDuration [ 
	^self new
		duration: aDuration ;
		yourself 
]

{ #category : #accessing }
BcTimer >> currentTimestamp [
	^DateAndTime now
]

{ #category : #accessing }
BcTimer >> duration [
	^ duration
]

{ #category : #accessing }
BcTimer >> duration: anObject [
	duration := anObject
]

{ #category : #accessing }
BcTimer >> elpasedTime [
	^self currentTimestamp - self startTimestamp
]

{ #category : #accessing }
BcTimer >> isTimeOver [
	self startTimestamp ifNil: [ ^ true ].
	^ self duration < self elpasedTime
]

{ #category : #actions }
BcTimer >> start [
	self startTimestamp: self currentTimestamp
]

{ #category : #accessing }
BcTimer >> startTimestamp [
	^ startTimestamp
]

{ #category : #accessing }
BcTimer >> startTimestamp: anObject [
	startTimestamp := anObject
]
