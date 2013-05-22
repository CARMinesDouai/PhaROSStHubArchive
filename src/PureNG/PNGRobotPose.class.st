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
	#category : #'PureNG-ServiceData'
}

{ #category : #'as yet unclassified' }
PNGRobotPose class >> x: anX y: anY o: anO [
	^ self new x: anX ;y: anY ; orientation: anO; yourself.
]

{ #category : #converting }
PNGRobotPose >> asPoint [
	^self x @ self y
]

{ #category : #comparing }
PNGRobotPose >> closeTo: anOtherRobotPose [
	
	^ { x - anOtherRobotPose x . y - anOtherRobotPose y . orientation - anOtherRobotPose orientation } allSatisfy: [: n | n < 0.001 ].
	 
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
	"Robot sends a fixed status value. (for pure-4.1-r1563) So, this information is meanningless"
	"The documentation talks about bit values"
	^self statusLabelDict at: self status ifAbsent: ['Unknown status']
]

{ #category : #accessing }
PNGRobotPose >> statusLabelDict [
	"Robot sends a fixed status value. (for pure-4.1-r1563) So, this information is meanningless"
	"The documentation talks about bit values"
	^{1 -> 'The solution has a metric accuracy'.
	2 -> 'The solution has a decimetric accuracy'.
	4 -> 'The solution has a centimetric accuracy'.
	8 -> 'The solution is computed using proprioceptive input'.
	16 -> 'The solution is computed using exteroceptive input'.
	32 -> 'An error was detected in the computation' } asDictionary
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
