Class {
	#name : #RrMotionSwitch,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'stopDistance'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'instance creation' }
RrMotionSwitch class >> at: distance [
	^self new
		stopDistance: distance;
		yourself
]

{ #category : #acting }
RrMotionSwitch >> newOutputFrom: distances [
	^distances noneSatisfy: [ :aDistance| aDistance <= self stopDistance]
]

{ #category : #accessing }
RrMotionSwitch >> stopDistance [
	^stopDistance
]

{ #category : #accessing }
RrMotionSwitch >> stopDistance: meters [
	stopDistance := meters
]
