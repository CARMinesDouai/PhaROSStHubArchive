Class {
	#name : #RrAverageFilter,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'averages'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #acting }
RrAverageFilter >> newOutputFrom: values [
	averages ifNil: [^averages := values].
	^averages := averages with: values collect: [ :oldAverage  :newValue|
		(oldAverage * 9 + newValue)/10
	]
]
