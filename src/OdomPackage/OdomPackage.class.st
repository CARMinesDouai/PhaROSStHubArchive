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
		'ySpeed'
	],
	#category : #OdomPackage
}

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
OdomPackage >> updatePositionFrom: imuData [
	xSpeed := xSpeed + imuData linear_acceleration x.
	x := x + xSpeed.
	ySpeed := ySpeed + imuData linear_acceleration y.
	y := y + ySpeed

]
