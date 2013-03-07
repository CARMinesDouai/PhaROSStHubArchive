Class {
	#name : #PNGTrajectoryNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'state'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #accessing }
PNGTrajectoryNotification >> distanceCovered [
	^state distanceCovered
]

{ #category : #'initialize-release' }
PNGTrajectoryNotification >> initWithDecoder: aDecoder [
	state := PNGTrajectoryState new.
	state timestamp: self timestamp.
	service decodeStateFrom: aDecoder into: state
]

{ #category : #accessing }
PNGTrajectoryNotification >> lateralError [
	^state lateralError 
]

{ #category : #accessing }
PNGTrajectoryNotification >> orientationError [
	^state orientationError 
]

{ #category : #accessing }
PNGTrajectoryNotification >> status [
	^state status
]

{ #category : #accessing }
PNGTrajectoryNotification >> statusLabel [
	^state statusLabel 
]
