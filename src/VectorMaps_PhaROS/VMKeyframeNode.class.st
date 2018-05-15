"
This object represents a ROS node that handles keyframe selection. It subscribes to odom and scan data. if the robot has moved enough (based on the odom input) then we create a local map from the scan input and publish it (to be used by the map merger).


Public API and Key Messages

- node: aNode
	sets the controller node. typically called on instance creation.
- processLaserScan: aScanMsg
	subscriber callback method for the laser scan topic. creates and publishes local maps from the laser scan data on every keyframe
- reset 
	resets the state of the node as if it has just been initialized. topic subscriptions and publishers remain untouched. this method is mainly meant for debugging, allowing to reset the node without having to deal with a clean shutdown or the result of an unclean shutdown.
- processOdomMsg: anOdomMsg
	subscriber callback method for the odom topic. determines if we have moved enough to create another key frame.
- publish: aScanMsg
	publishes a local map based on the scan message. uses ICP to align the scan with the previous keyframe
- subscribeToTopics
	simply subscribes to the ROS topics (laser scan data & odometry)


example(s) for instance creation can be found at the package script  'scriptKeyFrameNode'


Object members:

- icp
	a VMICP instance for correcting the position of the laser scan transformation.
- lastKeyPose
	a VMTransform instance that holds the pose (position and orientation) of the robot at the last key frame
- lastKeyTf
	translation from the robots starting position to the last key frame.
-  readyForKeyFrame
	true if the laser scan topic handler should create a new keyframe. false otherwise
- odomKeyDelta
	the transform from the last key frame to the current keyframe, according to odometry. used as initial guess for the ICP correction


"
Class {
	#name : #VMKeyframeNode,
	#superclass : #VMBaseNode,
	#instVars : [
		'icp',
		'publisher',
		'keyframeSelector',
		'keyframeCounter',
		'lastOdomPose',
		'currentOdomPose',
		'lastKeyPose',
		'lastKeyPointCloud',
		'icpViewer',
		'loggerPrefix',
		'logLaser'
	],
	#category : #'VectorMaps_PhaROS-Nodes'
}

{ #category : #'keyframe creation' }
VMKeyframeNode >> createKeyFrameWithPointCloud: pc [
	| scanMap currentKeyPose |
	
	keyframeCounter := keyframeCounter + 1.
	
	lastKeyPointCloud
		ifNil: [
			currentKeyPose := currentOdomPose asVMTFMatrix.
			"transformedPc := VMPointCloud2d new points: (pc points collect: [ :aPoint | currentKeyPose applyToPoint: aPoint copy ])."
			
			self logCr: '  currentKeyPose=', currentKeyPose asVMTFMatrix printString.
		]
		ifNotNil: [
			| deltaTf deltaOdom |
			
			"deltaOdom is the transformation estimate from the last keyframe up to now, based on the robot's odometry.
			it is used as an initial guess for the ICP correction."
			deltaOdom := (lastOdomPose inverse) * (currentOdomPose).
			
			"self log: 'saving ...'.
			GenSTONBuilder save: deltaOdom asVMTFMatrix inverse prefix: 'debug/kf_', keyframeCounter printString.
			GenSTONBuilder save: pc prefix: 'debug/kf_', keyframeCounter printString.
			self logCr: ' done'."
			
			"deltaTF is the final estimate of the transformation of the point cloud into the map frame."
			deltaTf := self performICP: pc guess: deltaOdom asVMTFMatrix.
			
			currentKeyPose := lastKeyPose * (deltaTf).
			"transformedPc := VMPointCloud2d new points: (pc deepCopy points collect: [ :aPoint | currentKeyPose applyToPoint: aPoint ])."
			
			
			self logCr: '  lastKeyPose=', lastKeyPose asVMTFMatrix printString.
			self logCr: '  lastOdomPose=', lastOdomPose asVMTFMatrix printString.
			self logCr: '  currentKeyPose=', currentKeyPose asVMTFMatrix printString.
			self logCr: '  currentOdomPose=', currentOdomPose asVMTFMatrix printString.
			self logCr: '  deltaOdom=', deltaOdom asVMTFMatrix printString.
			self logCr: '  deltaTf=', deltaTf asVMTFMatrix printString.
			
		].
	
	scanMap := VMLocalMap new fromPointCloud: pc tf: currentKeyPose asVMTFMatrix.
	lastOdomPose := currentOdomPose. "pose of the last odom message before we created the last point cloud & scanMap"
	lastKeyPose := currentKeyPose. "pose of the last scanMap, global frame (from this robots point of view)"
	lastKeyPointCloud := pc.
	
	self logCr: 'publishing map for keyframe ', keyframeCounter printString.
	self publish: scanMap.
	

]

{ #category : #initialization }
VMKeyframeNode >> initialize [
	super initialize.
	
	loggerPrefix := ''.
	
	self reset.
	
	"note: the caller should call 'subsribeToTopics' (which also calls 'setupPublisher') after the instance creation to complete initialization."

]

{ #category : #accessing }
VMKeyframeNode >> keyframeSelector [
	^keyframeSelector.
]

{ #category : #accessing }
VMKeyframeNode >> logLaser [
	^logLaser
]

{ #category : #accessing }
VMKeyframeNode >> logLaser: aBoolean [
	logLaser := aBoolean.
]

{ #category : #logging }
VMKeyframeNode >> logLaserMsg: aMsg [
	"logs the laser scan message, using STON for serialization"
	self logCr: 'laser scan message (keyframe ', keyframeCounter printString ,'):'.
	self logCr:	'  ', (STON toString: aMsg).

]

{ #category : #logging }
VMKeyframeNode >> logPointCloud: aPC [
	"logs the point cloud, using STON for serialization"
	self logCr: 'point cloud (keyframe ', keyframeCounter printString ,'):'.
	self logCr:	'  ', (STON toString: aPC).

]

{ #category : #logging }
VMKeyframeNode >> logToFile: anObj [
	"logs an object (e.g. a VMLocalMap instance) to a file in the path specified below.
	STON is used to serialize the object."
	| path filename type extension file fullPath handle |
	
	path := '/opt/shared/developer/data/vector_maps/2018-05-15/'.
	filename := 'keyframe_', (keyframeCounter printPaddedWith: $0 to: 4).
	type := '.', anObj class name.
	extension := '.ston'.
	
	fullPath := path, loggerPrefix, filename, type, extension.
	
	file := File named: fullPath.
	
	handle := file openForWrite.
	
	handle truncate;
		nextPutAll: (STON toString: anObj);
		close.
	
	Transcript show: 'logged at: ',fullPath; cr.

]

{ #category : #logging }
VMKeyframeNode >> logToFile: anObj prefix: prefixString [
	"logs an object (e.g. a VMLocalMap instance) to a file in the path specified below.
	STON is used to serialize the object."
	| path filename type extension file handle |
	
	path := '/opt/shared/developer/data/vector_maps/'.
	filename := 'keyframe_', (keyframeCounter printPaddedWith: $0 to: 4).
	type := '.', anObj class name.
	extension := '.ston'.
	
	file := File named: path, prefixString, filename, type, extension.
	
	handle := file openForWrite.
	
	handle truncate;
		nextPutAll: (STON toString: anObj);
		close.

]

{ #category : #accessing }
VMKeyframeNode >> loggerPrefix [
	^loggerPrefix.
]

{ #category : #accessing }
VMKeyframeNode >> loggerPrefix: aString [
	loggerPrefix := aString.
]

{ #category : #'ICP computation' }
VMKeyframeNode >> performICP: aPointCloud guess: initialTf [
	"run ICP on the last point cloud and the provided point cloud, using 'guess' as an initial guess for the transformation.
	the resulting transformation should be added to lasyKeyTf, and lastKeyPointCloud should be replaced by 'aPointCloud'."
	
	icp alignPointCollection: aPointCloud points with: lastKeyPointCloud points initialGuess: initialTf asVMTFMatrix.
	
	self logCr: 'icp final error=', icp computeError printString.
	
	^icp tfMatrix.
	

]

{ #category : #'topic handler' }
VMKeyframeNode >> processLaserScan: aMsg [
	"note: we process the scan data for keyframe creation only. obstacle detection and mapping is not done here."
	| pc |
	
	keyframeSelector hasNewKeyframe ifFalse: [ ^self. ].
	
	logLaser ifTrue: [
		self logLaserMsg: aMsg.
	].
	
	pc := VMPointCloud2d new fromMsg: aMsg.
	
	"debug code"
	(pc points size < 1) ifTrue: [
		Transcript show: 'dropping empty laser scan'; cr.
		^self.
	].
	
	self createKeyFrameWithPointCloud: pc.

]

{ #category : #'topic handler' }
VMKeyframeNode >> processOdomMsg: msg [
	
	currentOdomPose := VMTransform fromOdomMsg: msg.
	keyframeSelector updatePose: currentOdomPose.

	




]

{ #category : #'topic handler' }
VMKeyframeNode >> publish: aVMLocalMap [
	
	publisher send: [ :obj |
		aVMLocalMap lineSegments do: [ :lineSeg |
			"add pointA"
			obj vertices add: ( Vector_mapsvm_vertex new
				x: lineSeg pointA x;
				y: lineSeg pointA y;
				type: lineSeg type asInteger;
				flags: 0).
			
			"add pointB"
			obj vertices add: ( Vector_mapsvm_vertex new
				x: lineSeg pointB x;
				y: lineSeg pointB y;
				type: lineSeg type asInteger;
				flags: 0).

		].
	].
	
	self logToFile: aVMLocalMap.

]

{ #category : #'private - debugging' }
VMKeyframeNode >> republish [
	lastKeyPointCloud ifNotNil: [ 
		self createKeyFrameWithPointCloud: lastKeyPointCloud.
	].
]

{ #category : #initialization }
VMKeyframeNode >> reset [
	
	keyframeSelector := VMKeyFrameSelector new.
	icp := VMICP new.
	keyframeCounter := 0.
	
	lastKeyPose := nil.
	lastOdomPose := nil.
	currentOdomPose := nil.
	lastKeyPointCloud := nil.
	
	logLaser := false.
	
	icpViewer := nil.

]

{ #category : #initialization }
VMKeyframeNode >> setupPublisher [

	publisher := node 
						topicPublisher: self robotPrefix, '/scanMap' 
						typedAs: 'vector_maps/vm_map'.
	
	"note: vm_vertex is part of vm_map. both are required to publish."
	self assert: (Smalltalk hasClassNamed: 'Vector_mapsvm_vertex').
	self assert: (Smalltalk hasClassNamed: 'Vector_mapsvm_map').
	

]

{ #category : #visualization }
VMKeyframeNode >> showICPViewer [
	
	icpViewer ifNotNil: [  ^self. ].
	icp ifNil: [ ^self. ].
	
	icpViewer := (VMMapViewer
		openOn: { icp asRenderableElement }
		extent: 800@800)
			zoomFactor: 50 at: 0@0;
			panTo: 300@350.


]

{ #category : #initialization }
VMKeyframeNode >> subscribeToTopics [
	"	- subscribe to odom
		- subscribe to sensor topic(s)
		
		todo:
		- support custom topic names
		- support multiple sensors
	"
	self logCr: self class name, ': subscribing to topics'.
	
	self assert: node isNotNil.
	
	(node buildConnectionFor: self robotPrefix, '/laser/scan')
		typedAs: 'sensor_msgs/LaserScan';
		for: [ :msg |
			self processLaserScan: msg.
		];
		connect.
	
	(node buildConnectionFor: self robotPrefix, '/odom')
		typedAs: 'nav_msgs/Odometry';
		for: [ :msg |
			self processOdomMsg: msg.
		];
		connect.
	
	self setupPublisher.
	

]
