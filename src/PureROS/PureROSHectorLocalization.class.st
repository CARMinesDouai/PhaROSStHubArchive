"
"" 
   Be sure that you have efk.launch file in the same folder than the image, and then execute the following two lines. ( Change kompai2 to kompai1 if is the case ) 
  Be sure that:
	- xsens bus is on
	- the port has the appropiate privileges ( sudo chmod 666 /dev/ttyUSB0 )
	
""

		experiment := PureROSHectorLocalization kompai2.
		experiment beginExperiment.
		
	"" Now, move the robot around with the joystick. and you can watch the comparing plot  ""
	
		experiment endExperiment. 
		
	
""
	With this experiment we can see that the EFK node does not improve too much the orientation of the robot, just a few degrees


""
"
Class {
	#name : #PureROSHectorLocalization,
	#superclass : #PureROSPlottingExperiment,
	#category : #'PureROS-Experiments-Localization'
}

{ #category : #'as yet unclassified' }
PureROSHectorLocalization >> consumeHLPose [
	 (pureros node buildConnectionFor: '/imu/orientation')  typedAs: 'geometry_msgs/Quaternion'; for: [ :msg :chn | self onOrientationReceived: msg ]  ; connect.
]

{ #category : #'as yet unclassified' }
PureROSHectorLocalization >> onOrientationReceived: aQuaternion [

"Transcript show: aQuaternion ;cr.
"

	pureros node sendTo: '/poseupdate' typedAs: 'geometry_msgs/PoseWithCovarianceStamped' a: [: msg | 
		pureros lastPosition intoGeometry_msgs_Pose: msg pose pose.
		self setCovariance: msg pose.	
		msg pose pose orientation x: aQuaternion x.
		msg pose pose orientation y: aQuaternion y.
		msg pose pose orientation z: aQuaternion z.
		msg pose pose orientation w: aQuaternion w.
		
	].
]

{ #category : #'as yet unclassified' }
PureROSHectorLocalization >> onPoseReceived: aMsg [
	pureros node sendTo: '/poseupdate' typedAs: 'geometry_msgs/PoseWithCovarianceStamped' a: [: msg | 
		pureros lastPosition intoGeometry_msgs_Pose: msg pose pose.
		self setCovariance: msg pose.	
		msg pose pose orientation x: aMsg pose orientation x.
		msg pose pose orientation y: aMsg pose orientation y.
		msg pose pose orientation z: aMsg pose orientation z.
		msg pose pose orientation w: aMsg pose orientation w.
		Transcript show: msg;cr.
	]
]

{ #category : #'as yet unclassified' }
PureROSHectorLocalization >> plot [
	self plot: [
		: spec |
		spec addPoseStamped pose orientation fields: { #z . #w }.
		spec addHectorPose pose orientation fields: { #z . #w }.
		
		spec addPoseStamped pose position fields: { #x . #y }.
		spec addHectorPose pose position fields: { #x . #y }.
	].
]

{ #category : #'as yet unclassified' }
PureROSHectorLocalization >> setup [ 
	self launch: 'hector-localization.launch'.
"	self configurePoseStampedWithCovarianceAs: '/poseupdate'."
	self configurePoseStamped. "For plotting"
	self configureInitialPose.
	self consumeHLPose.
	
	self plot.
]
