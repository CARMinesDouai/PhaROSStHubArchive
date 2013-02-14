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
	#name : #PNGRobotPose,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'orientation',
		'status'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #converting }
PNGRobotPose >> asPoint [
	^self x @ self y
]

{ #category : #accessing }
PNGRobotPose >> orientation [
	^ orientation
]

{ #category : #accessing }
PNGRobotPose >> orientation: anObject [
	orientation := anObject
]

{ #category : #printing }
PNGRobotPose >> printOn: aStream [ 
	super printOn: aStream.
	aStream
		cr;
		nextPutAll: 'x: '.
	self x printOn: aStream showingDecimalPlaces: 2.
	aStream	
		cr; 
		nextPutAll: 'y: '.
	self y printOn: aStream showingDecimalPlaces: 2.
	aStream
		cr;
		nextPutAll: 'orientation: '.
	 self orientation printOn: aStream showingDecimalPlaces: 2.
	aStream 
		cr;
		nextPutAll: 'status: ';
		print: self statusLabel

]

{ #category : #accessing }
PNGRobotPose >> status [
	^ status
]

{ #category : #accessing }
PNGRobotPose >> status: anObject [
	status := anObject
]

{ #category : #accessing }
PNGRobotPose >> statusLabel [
	^self statusLabelDict at: self status ifAbsent: ['Unknown status']
]

{ #category : #accessing }
PNGRobotPose >> statusLabelDict [
	^{0 -> 'The solution has a metric accuracy'.
	1 -> 'The solution has a decimetric accuracy'.
	2 -> 'The solution has a centimetric accuracy'.
	3 -> 'The solution is computed using proprioceptive input'.
	4 -> 'The solution is computed using exteroceptive input'.
	5 -> 'An error was detected in the computation' } asDictionary
]

{ #category : #accessing }
PNGRobotPose >> x [
	^ x
]

{ #category : #accessing }
PNGRobotPose >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PNGRobotPose >> y [
	^ y
]

{ #category : #accessing }
PNGRobotPose >> y: anObject [
	y := anObject
]
