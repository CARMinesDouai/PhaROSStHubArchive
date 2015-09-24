Class {
	#name : #RrMotionSwitch,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'stopDistance'
	],
	#category : #'ReactiveRobot-01-EmergencyStop'
}

{ #category : #'instance creation' }
RrMotionSwitch class >> at: distance [
	^self new
		stopDistance: distance;
		yourself
]

{ #category : #'initialization-release' }
RrMotionSwitch >> defaultStopDistance [
	^0
]

{ #category : #'initialization-release' }
RrMotionSwitch >> initialize [
	super initialize.
	self stopDistance: self defaultStopDistance
]

{ #category : #acting }
RrMotionSwitch >> newOutputFrom: distances [
	^distances allSatisfy: [ :aDistance| aDistance > self stopDistance]
]

{ #category : #accessing }
RrMotionSwitch >> stopDistance [
	^stopDistance
]

{ #category : #accessing }
RrMotionSwitch >> stopDistance: meters [
	stopDistance := meters
]
