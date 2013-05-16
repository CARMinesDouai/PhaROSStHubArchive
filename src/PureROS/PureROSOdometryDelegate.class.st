Class {
	#name : #PureROSOdometryDelegate,
	#superclass : #Object,
	#instVars : [
		'previousNotification',
		'previousTime'
	],
	#category : #'PureROS-Util'
}

{ #category : #'as yet unclassified' }
PureROSOdometryDelegate >> callback [

	^ [	: notification :msg | 
			self configure: msg with: notification.
		].

	
]

{ #category : #'as yet unclassified' }
PureROSOdometryDelegate >> configure: aMessage with: aNotification [
	self initializeMessage: aMessage.
	aMessage header frame_id: 'odom'.
	aMessage child_frame_id: ''.
	
	aNotification position intoGeometry_msgs_Pose: aMessage pose pose.
	(self measurePoseDiference: aNotification) intoGeometry_msgs_Twist: aMessage twist twist.
]

{ #category : #'as yet unclassified' }
PureROSOdometryDelegate >> initializeMessage: aMessage [
	| dValue |
	36 timesRepeat: [ 
		aMessage pose covariance add: 0.0. 
		aMessage twist covariance add: 0.0.
	].
	self flag: #lookAtComment.
" This value is really arbitrar.. is based on turtlebot specs, it should be based on robulab, or even better, parametrized "
	dValue := (0.017 * 0.017) roundUpTo: 0.0000001. 
	
	aMessage pose covariance at:1 put: dValue.
	aMessage pose covariance at:8 put: dValue.
	aMessage pose covariance at:15 put: dValue.
	aMessage pose covariance at:22 put: dValue.
	aMessage pose covariance at:29 put: dValue.	
	aMessage pose covariance at:36 put: dValue.
		
	aMessage twist covariance at:1 put: dValue.
	aMessage twist covariance at:8 put: dValue.
	aMessage twist covariance at:15 put: dValue.
	aMessage twist covariance at:22 put: dValue.
	aMessage twist covariance at:29 put: dValue.	
	aMessage twist covariance at:36 put: dValue.
	
]

{ #category : #'as yet unclassified' }
PureROSOdometryDelegate >> measurePoseDiference: aNotification [

| time a b deltaTime  poseDifference | 


	time := DateAndTime now.
								
	poseDifference := PNGRobotPose x:0 y:0 o:0.
	
	previousNotification ifNotNil: [
		a := time asSeconds.
		b := previousTime asSeconds.
		deltaTime :=  (b - a) abs.
		
		deltaTime = 0 ifFalse:[
			poseDifference  x: ( aNotification position x - previousNotification position x ) / deltaTime.
			poseDifference y: ( aNotification position y - previousNotification position y ) / deltaTime  .
			poseDifference orientation:  ((aNotification position orientation  - previousNotification position orientation) / deltaTime) / ( 2 * Float pi ).
		
		]
	].
	previousNotification := aNotification.
	previousTime := time.
	^ poseDifference.
]
