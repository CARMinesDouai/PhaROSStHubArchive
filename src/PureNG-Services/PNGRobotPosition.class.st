Class {
	#name : #PNGRobotPosition,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'orientation',
		'status'
	],
	#category : #'PureNG-DataTypes'
}

{ #category : #accessing }
PNGRobotPosition >> orientation [
	^ orientation
]

{ #category : #accessing }
PNGRobotPosition >> orientation: anObject [
	orientation := anObject
]

{ #category : #accessing }
PNGRobotPosition >> status [
	^ status
]

{ #category : #accessing }
PNGRobotPosition >> status: anObject [
	status := anObject
]

{ #category : #accessing }
PNGRobotPosition >> statusLabel [
	^{0 -> 'The solution has a metric accuracy'.
	1 -> 'The solution has a decimetric accuracy'.
	2 -> 'The solution has a centimetric accuracy'.
	3 -> 'The solution is computed using proprioceptive input'.
	4 -> 'The solution is computed using exteroceptive input'.
	5 -> 'An error was detected in the computatin' } asDictionary at: self status
]

{ #category : #accessing }
PNGRobotPosition >> x [
	^ x
]

{ #category : #accessing }
PNGRobotPosition >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PNGRobotPosition >> y [
	^ y
]

{ #category : #accessing }
PNGRobotPosition >> y: anObject [
	y := anObject
]
