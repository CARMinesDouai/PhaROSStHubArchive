"
I transform IMU data into Pose

"
Class {
	#name : #OdomPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'imuSubscriber',
		'posePublisher',
		'x',
		'y',
		'xSpeed',
		'ySpeed',
		'elpasedSeconds',
		'previousTimeStamp',
		'elapsedSeconds'
	],
	#category : #OdomPackage
}

{ #category : #scripts }
OdomPackage >> elapsedSecondsFrom: newTimeStamp [
	previousTimeStamp ifNil: [ ^0 ].
	^(newTimeStamp sec - previousTimeStamp sec) 
		+ (1000000000 
			* (newTimeStamp nsec - previousTimeStamp nsec))

]

{ #category : #'initalize-release' }
OdomPackage >> initialize [
	super initialize.
	x := 0.0.
	y := 0.0.
	xSpeed := 0.0.
	ySpeed := 0.0
]

{ #category : #scripts }
OdomPackage >> publishPoseFrom: imuData [
	self updatePositionFrom: imuData.
	posePublisher send: [ : pose |
			pose position
				x: self x;
				y: self y;
				z: 0.
			pose orientation: imuData orientation
		]
	
]

{ #category : #scripts }
OdomPackage >> scriptImuToOdom [
	imuSubscriber := 	(self controller node buildConnectionFor: '/imu/data' ) 
			typedAs: 'sensor_msgs/Imu'; 
			for: [ : imuData |  self publishPoseFrom: imuData ];
			connect.
	posePublisher := self controller node 
			topicPublisher: '/pose' 
			typedAs: 'geometry_msgs/Pose.msg'
]

{ #category : #scripts }
OdomPackage >> updateElapsedSecondsFrom: newTimeStamp [
	elapsedSeconds := self elapsedSecondsFrom: newTimeStamp.
	previousTimeStamp := newTimeStamp.

]

{ #category : #scripts }
OdomPackage >> updatePositionFrom: imuData [
	self updateElapsedSecondsFrom: imuData header stamp.
	xSpeed := xSpeed + (imuData linear_acceleration x * elpasedSeconds).
	x := x + (xSpeed * elpasedSeconds).
	ySpeed := (ySpeed + imuData linear_acceleration y * elpasedSeconds).
	y := y + (ySpeed * elpasedSeconds)

]
