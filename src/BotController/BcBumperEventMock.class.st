Class {
	#name : #BcBumperEventMock,
	#superclass : #Object,
	#instVars : [
		'state',
		'bumper'
	],
	#category : #'BotController-Tests'
}

{ #category : #'instance creation' }
BcBumperEventMock class >> bumper: bumberIndex state: stateValue [
	^self new
		bumper: bumberIndex;
		state: stateValue;
		yourself
]

{ #category : #accessing }
BcBumperEventMock >> bumper [
	^ bumper
]

{ #category : #accessing }
BcBumperEventMock >> bumper: anObject [
	bumper := anObject
]

{ #category : #accessing }
BcBumperEventMock >> state [
	^ state
]

{ #category : #accessing }
BcBumperEventMock >> state: anObject [
	state := anObject
]
