"
PNGRobotPosition is produced by the localization service of the robot. 

Instance Variables:
	x	<Float>
	y	<Float>
	orientation	<Float>
	status	<int>
		
-status
This field is a bit field which gives information about the localization data. If all bits are zeroed, the data is invalid.
(The solution has a metric/decimetric/ centimetric accuracy, ...).
"
Class {
	#name : #PNGRobotPosition,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'orientation',
		'status'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #accessing }
PNGRobotPosition >> orientation [
	^ orientation
]

{ #category : #accessing }
PNGRobotPosition >> orientation: anObject [
	orientation := anObject
]

{ #category : #printing }
PNGRobotPosition >> printOn: aStream [ 
	super printOn: aStream.
	aStream
		nextPutAll: 'x: ';
		print: self x;
		cr;
		nextPutAll: 'y: ';
		print: self y;
		cr;
		nextPutAll: 'orientation: ';
		print: self orientation;
		cr;
		nextPutAll: 'status: ';
		print: self statusLabel

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
	^self statusLabelDict at: self status ifAbsent: ['Unknown status']
]

{ #category : #accessing }
PNGRobotPosition >> statusLabelDict [
	^{0 -> 'The solution has a metric accuracy'.
	1 -> 'The solution has a decimetric accuracy'.
	2 -> 'The solution has a centimetric accuracy'.
	3 -> 'The solution is computed using proprioceptive input'.
	4 -> 'The solution is computed using exteroceptive input'.
	5 -> 'An error was detected in the computation' } asDictionary
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
