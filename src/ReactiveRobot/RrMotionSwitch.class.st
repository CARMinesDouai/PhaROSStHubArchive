Class {
	#name : #RrMotionSwitch,
	#superclass : #ChaDefaultInOutComponent,
	#traits : 'TChaDefaultInputComponent',
	#classTraits : 'TChaDefaultInputComponent classTrait',
	#instVars : [
		'emergencyDistance'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'instance creation' }
RrMotionSwitch class >> at: distance [
	^self new
		turnOffDistance: distance;
		yourself
]

{ #category : #acting }
RrMotionSwitch >> input: distances [
	distances 
		detect: [ :aDistance| 
			aDistance < self turnOffDistance]
		ifFound: [ : dist |
			^outputPort set: false].
	outputPort set: true
]

{ #category : #accessing }
RrMotionSwitch >> turnOffDistance [
	^emergencyDistance
]

{ #category : #accessing }
RrMotionSwitch >> turnOffDistance: meters [
	emergencyDistance := meters
]
