Class {
	#name : #RrEmergencyStop,
	#superclass : #ChaComponent,
	#instVars : [
		'emergencyDistance',
		'stopPort'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'instance creation' }
RrEmergencyStop class >> at: distance [
	^self new
		emergencyDistance: distance;
		yourself
]

{ #category : #acting }
RrEmergencyStop >> distanceToObstacles: distances [
	distances 
		detect: [ :aDistance| 
			aDistance < self emergencyDistance]
		ifFound: [^stopPort set: true].
	stopPort set: false
]

{ #category : #accessing }
RrEmergencyStop >> emergencyDistance [
	^ emergencyDistance
]

{ #category : #accessing }
RrEmergencyStop >> emergencyDistance: anObject [
	emergencyDistance := anObject
]
