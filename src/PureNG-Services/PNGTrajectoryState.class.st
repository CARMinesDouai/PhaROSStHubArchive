Class {
	#name : #PNGTrajectoryState,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'status',
		'distanceCovered',
		'lateralError',
		'orientationError'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #status }
PNGTrajectoryState class >> errorStatusValue [
	^3
]

{ #category : #status }
PNGTrajectoryState class >> followingStatusValue [
	^0
]

{ #category : #status }
PNGTrajectoryState class >> pausedStatusValue [
	^1
]

{ #category : #status }
PNGTrajectoryState class >> waitingStatusValue [
	^2
]

{ #category : #accessing }
PNGTrajectoryState >> distanceCovered [
	^ distanceCovered
]

{ #category : #accessing }
PNGTrajectoryState >> distanceCovered: anObject [
	distanceCovered := anObject
]

{ #category : #accessing }
PNGTrajectoryState >> lateralError [
	^ lateralError
]

{ #category : #accessing }
PNGTrajectoryState >> lateralError: anObject [
	lateralError := anObject
]

{ #category : #accessing }
PNGTrajectoryState >> orientationError [
	^ orientationError
]

{ #category : #accessing }
PNGTrajectoryState >> orientationError: anObject [
	orientationError := anObject
]

{ #category : #accessing }
PNGTrajectoryState >> status [
	^ status
]

{ #category : #accessing }
PNGTrajectoryState >> status: anObject [
	status := anObject
]

{ #category : #accessing }
PNGTrajectoryState >> statusLabel [
	^self statusLabelDict at: self status ifAbsent: ['Unknown status']
]

{ #category : #accessing }
PNGTrajectoryState >> statusLabelDict [
	^{0 -> 'Following : the robot is following a trajectory'.
	1 -> 'Paused : the robot is following, but with a zero target speed'.
	2 -> 'Waiting : there is no more trajectory'.
	3 -> 'Error : An error was detected during the following'.
	} asDictionary
]

{ #category : #accessing }
PNGTrajectoryState >> timestamp [
	^ timestamp
]

{ #category : #accessing }
PNGTrajectoryState >> timestamp: anObject [
	timestamp := anObject
]
