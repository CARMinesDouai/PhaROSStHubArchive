"
Luc (April 30th, 2015): This class is bloated, only pull up relevant things, then we will remove it

landmark navigation

	- all the cases need landmark recognition step based on laser.
	- the stargazer case just need to recognize the 0 landmark (according to default configurations: 82)
	
	AMCL 
	rosrun pharos headless amclbased.
	rosrun pharos headless launchkompai2.
	rosrun pharos headless launchstargazer.
	rosrun pharos headless landmarknavigation.
	
	Odometry+Stargazer
	rosrun pharos headless stargazerodometrybased.
	rosrun pharos headless launchkompai2.
	rosrun pharos headless launchstargazer.
	rosrun pharos headless landmarknavigation .
	
	
	
	StarGazer
	rosrun pharos headless stargazerbased.
	rosrun pharos headless launchkompai2. 
	rosrun pharos headless launchstargazer.
	rosrun pharos headless landmarknavigation .

"
Class {
	#name : #PureROSRobulabOld,
	#superclass : #PureROSRobulab,
	#instVars : [
		'experiment',
		'process',
		'lastPoseSettedStamp',
		'checked',
		'lastId'
	],
	#category : #PureROSPackageRobulab
}

{ #category : #'meta infos' }
PureROSRobulabOld class >> catkinPackageAuthor [
	^ 'SantiagoBragagnolo'
	
]

{ #category : #'meta infos' }
PureROSRobulabOld class >> catkinPackageName [ 
	^ 'OLDrobulab'
]

{ #category : #private }
PureROSRobulabOld >> buildController [ 
	self halt: 'mmm this should not be called yet. Refactor first'.
]

{ #category : #private }
PureROSRobulabOld >> finalize [
	super finalize .
	self controller ifNotNil: [ 
		self controller finalize.
		__ctrl := nil.
		].
	experiment ifNotNil:[ 
		experiment finalize.
		experiment := nil.	
	]
]

{ #category : #private }
PureROSRobulabOld >> mapFile [ 
	^ self class imageFolder  , '/map/map.yaml'
]

{ #category : #private }
PureROSRobulabOld >> multipleRobotMapBuildingFor: aRobotName [
	
	process:= PhaROSSystemLauncher  instance launch: [ : spec |
		spec gmapping remap: '/map' to:('/{1}/map' format: {aRobotName}).
		
	].
	
]

{ #category : #'scripts-error' }
PureROSRobulabOld >> scriptAbsoluteLandmarkLocator [

	| bot controller |
	controller := PhaROSHandleController robulab2.
	bot := controller nodelets robulab.
	
	controller nodelets spaceEvents registerLocalizationSensor: ( 
			bot nodelets stargazer landmarksAdaptedAs: PhaROSLocalizerMeasure 
	).
	
	controller nodelets localizer filein: bot landmarksFile.
	controller nodelets localizer transformations.
	
	self setupAbsolutePoseRecognizer.

	




]

{ #category : #'scripts-launchers-base' }
PureROSRobulabOld >> scriptAmclBased [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec kompaiTF.
		
		spec odometry .
		spec mapServer: self mapFile.
		spec amcl.
		spec moveBase.
		spec compressor.
		"spec velocitySmoother."
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
	
"
		
		spec rviz."
	].
	

]

{ #category : #'scripts-launchers-base-nomap' }
PureROSRobulabOld >> scriptAmclBasedNoMap [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec kompaiTF.
		spec odometry .
		
		spec amcl.
		spec moveBase.
		spec compressor.
		"spec velocitySmoother."
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
		spec rviz.
	].
	

]

{ #category : #'scripts-navigation' }
PureROSRobulabOld >> scriptFeedbackCompressor [
	|controller|
	controller := PhaROSHandleController homeWithNodeNamed: 'FeedbackCompressor'.
	controller nodelets use: PhaROSMoveBaseFeedbackCompressor as:#compressor.
	
	self inform: 'scriptFeedbackCompressor running...'.	
]

{ #category : #'scripts-launchers' }
PureROSRobulabOld >> scriptHardwareUp [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai2.
		spec stargazer.
		

	]
]

{ #category : #'scripts-navigation' }
PureROSRobulabOld >> scriptLandmarkAutoNavigation [

	| bot goals |
	
	self scriptLandmarkNavigation.
	
	bot := experiment robulab.
	
	goals := OrderedCollection new. 	
	1 to: 20 do: [: i | 
		goals add: 608; add: 96; add: 18; add: 2.
	].
	
	bot goToArray: goals shuffle asArray.



]

{ #category : #'scripts-navigation' }
PureROSRobulabOld >> scriptLandmarkLocator [

	| bot controller |
	controller := PhaROSHandleController robulab2.
	bot := controller nodelets robulab.
	
	controller nodelets spaceEvents registerLocalizationSensor: ( 
			controller nodelets stargazer landmarksAdaptedAs: PhaROSLocalizerMeasure 
	).
	controller nodelets localizer filein: bot landmarksFile.
	controller nodelets localizer transformations.
	
	self setupPoseRecognizer.

]

{ #category : #'scripts-navigation' }
PureROSRobulabOld >> scriptLandmarkNavigation [

	| bot controller |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	bot rpc.
	
	controller := experiment controller.
	
	experiment controller nodelets spaceEvents registerLocalizationSensor: ( 
			bot nodelets stargazer landmarksAdaptedAs: PhaROSLocalizerMeasure 
	).
	experiment controller nodelets localizer filein: bot landmarksFile.
	
	"experiment controller nodelets localizer filein: 'odometry-landmarks-inner.st'.
	"
	self setupPoseTracker.

	bot inspect.
	

]

{ #category : #'scripts-points' }
PureROSRobulabOld >> scriptLandmarksRecognition [

	| bot |
	experiment := PureROSAMCLBasedPathPlanning robulab2.
	experiment beginExperiment.	

	bot := experiment robulab.
	
	experiment controller nodelets localizer learn:( experiment controller nodelets stargazer absoluteLandmarks ) .
	
	"self nodelets localizer explore."
	
	2 seconds asDuration asDelay wait.
	experiment controller nodelets localizer map.
	experiment controller nodelets localizer mapPoints.
	experiment controller nodelets localizer transformations.
	2 seconds asDuration asDelay wait.
	
	bot inspect.
	
]

{ #category : #'scripts-launchers' }
PureROSRobulabOld >> scriptMRMBkompai1 [
	
	self multipleRobotMapBuildingFor: #kompai1.
]

{ #category : #'scripts-launchers' }
PureROSRobulabOld >> scriptMRMBkompai2 [
	
	self multipleRobotMapBuildingFor: #kompai2.
]

{ #category : #'scripts-launchers' }
PureROSRobulabOld >> scriptMapBuilding [

	process:= PhaROSSystemLauncher  instance launch: [ : spec |
		spec gmapping.
	].
	
]

{ #category : #'scripts-launchers-base-nomap' }
PureROSRobulabOld >> scriptOdometryForMappingNoMap [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec kompaiTF.
		spec odometry .
		
		spec moveBase.
		spec compressor.
		"spec velocitySmoother."
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
		spec rviz.
	].
	

]

{ #category : #'scripts-error' }
PureROSRobulabOld >> scriptOriginFixer [


	| controller |
	controller := PhaROSHandleController robulab2.
	controller nodelets spaceEvents registerLocalizationSensor: ( 
			controller nodelets stargazer landmarksAdaptedAs: PhaROSLocalizerMeasure 
	).
	self setupOriginRecognizer.
]

{ #category : #'scripts-navigation' }
PureROSRobulabOld >> scriptPointNavigation [
	
	| bot controller |
	controller := PhaROSHandleController robulab2.
	

	bot := controller nodelets robulab.
	bot rpc.
	
	
	
	controller nodelets localizer filein: bot landmarksFile.
	
	controller nodelets initialpose initialPose: (controller nodelets localizer entity:1) center .
	
	
	
	
"
	self setupPoseTracker.
"

	bot goToEntityID: 1.	
	bot inspect.
	




]

{ #category : #'scripts-points' }
PureROSRobulabOld >> scriptPoseRecording [
 
	| bot controller |
	controller := PhaROSHandleController robulab2. 
	bot := controller nodelets robulab.
	
	controller nodelets use: PhaROSPoseTrackerNodelet as: #poseTracker.
	controller nodelets poseTracker transformations.
	Transcript open.

	self halt: 'Execute the next line each time that the robot is in the wanted pose. (Remember to care about where the robot is facing). In case of navigation points, mind the static obstacles in RViz!'.
	
	controller nodelets poseTracker recordCurrentPose.
	
	self halt: 'After you have recorded all the poses, you need to execute the next line in order to save the poses in a file. Take in care that this process will override all previous poses overriding the file! '.
	
	controller nodelets poseTracker save: bot landmarksFile.
	
	
	self quit. 
	
]

{ #category : #'scripts-points' }
PureROSRobulabOld >> scriptPoseRecordingUpdate [

	| bot controller | 
	controller := PhaROSHandleController robulab2. 
	bot := controller nodelets robulab.
	
	controller nodelets use: PhaROSPoseTrackerNodelet as: #poseTracker.
	controller nodelets poseTracker transformations.

	Transcript open.

	controller nodelets poseTracker open: bot landmarksFile.
	self halt: 'Execute the next line each time that the robot is in the wanted pose. (Remember to care about where the robot is facing). In case of navigation points, mind the static obstacles in RViz!'.
	
	controller nodelets poseTracker recordCurrentPose.
	
	self halt: 'After you have recorded all the poses, you need to execute the next line in order to save the poses in a file. Take in care that this process will override all previous poses overriding the file! '.
	
	controller nodelets poseTracker save: bot landmarksFile.
	
	
	self quit. 
	
]

{ #category : #'scripts-points' }
PureROSRobulabOld >> scriptRemotePoseRecording [

	| bot controller |
	controller := PhaROSHandleController robulab2. 
	bot := controller nodelets robulab.
	
	controller nodelets use: PhaROSPoseTrackerNodelet as: #poseTracker. 
	
	controller nodelets use: PhaROSRPCNodelet as: #rpc.
	
	.
	
]

{ #category : #'scripts-points' }
PureROSRobulabOld >> scriptRemotePoseRecordingUpdate [

	| bot controller |
	controller := PhaROSHandleController robulab2. 
	bot := controller nodelets robulab.
	
	controller nodelets use: PhaROSPoseTrackerNodelet as: #poseTracker.
	controller nodelets poseTracker open: bot landmarksFile.
	
	controller nodelets use: PhaROSRPCNodelet as: #rpc.
	self log: 'LastID: ',  (controller nodelets localizer entities collect: #id) max asString.
	
	
]

{ #category : #'scripts-stargazer' }
PureROSRobulabOld >> scriptStandAloneMapBuildingStargazer [
	| bot stream controller |
	 
	stream  := FileStream stdout.	
	controller := PhaROSHandleController robulab2.
	bot := controller nodelets robulab.
	lastPoseSettedStamp  := DateAndTime now - 10 minutes.
	stream nextPutAll: 'Remember that the robot should start this process located under the landmark 82', String lf.	
	stream nextPutAll: 'Starting pose merge process with direct odometry', String lf.
	
	2 seconds asDuration asDelay wait.
	
	stream nextPutAll: 'Starting landmark place recognition ', String lf.
	controller nodelets localizer learn:(  controller nodelets stargazer absoluteLandmarks ) .
	
	controller nodelets spaceEvents whenLocalizerMeasure:  [ : lm | 
		controller nodelets localizer scannedEntities size >= 4 
	] doOnce: [ : lm | 
		stream nextPutAll: 'Saving landmark map', String lf.
		controller nodelets localizer fileout: 'odometry-landmarks-inner.st'. 
		self quit. 
	].
	
	controller nodelets spaceEvents whenLocalizerMeasure: [ : lm |  lm id = 82 ] do: [ : lm | 
		|now |
		now := DateAndTime now .
		(now - lastPoseSettedStamp ) asSeconds > 1 ifTrue: [
			controller nodelets initialpose initialPose:  lm pose . 
			lastPoseSettedStamp := now.
		]
	]. 	
	
	2 seconds asDuration asDelay wait.

	stream nextPutAll: 'Starting landmark TF broadcasting', String lf.
	controller nodelets localizer transformations.
	
	
	
]

{ #category : #'scripts-launchers-base' }
PureROSRobulabOld >> scriptStargazerBased [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec mapServer: self sgMapfile.

		spec moveBase.
		spec compressor.
		spec odometry. 
		"
		
		spec stargazerHDPose.
		spec stargazerTF.

		
		
		spec odometry."
		"spec velocitySmoother."
		
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec staticZeroTFFrom: '/map'  to: '/odom'.  
		spec relay: '/stargazer/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
		
		
		
		

	].
	

]

{ #category : #'scripts-launchers-base-nomap' }
PureROSRobulabOld >> scriptStargazerBasedNoMap [
		
	process:= PhaROSSystemLauncher  instance launch: [: spec | 


		spec odometry.
		spec moveBase.
		
		"spec velocitySmoother."
		
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec staticZeroTFFrom: '/map'  to: '/odom'.  
		spec relay: '/stargazer/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
		
		spec rviz.
	].
	

]

{ #category : #'scripts-launchers-base' }
PureROSRobulabOld >> scriptStargazerOdometryBased [
		
	process := PhaROSSystemLauncher  instance launch: [: spec | 
		spec mapServer: self mapFile.
		spec kompaiTF .
		spec odometry .
		spec moveBase.
		spec compressor.
		"
		spec velocitySmoother.
		"
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec staticZeroTFFrom: '/map'  to: '/odom'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.

	].
	

]

{ #category : #'scripts-launchers-base' }
PureROSRobulabOld >> scriptStargazerOdometryBasedNoMap [
		
	process := PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompaiTF .
		spec kompaiOdometry .
		spec moveBase.
		spec velocitySmoother.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec staticZeroTFFrom: '/map'  to: '/odom'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
		spec rviz.
	].
	

]

{ #category : #private }
PureROSRobulabOld >> setAbsolutePoseWith: aLocalizerMeasure [ 
	| pose  controller |
 
	controller := PhaROSHandleController robulab2. 
	lastPoseSettedStamp := DateAndTime now.
	pose := controller nodelets stargazer landmarkToPose: aLocalizerMeasure.
	controller nodelets initialpose initialPose:  pose.

]

{ #category : #private }
PureROSRobulabOld >> setOriginAs: aLocalizerMeasure [
	| pose controller | 
		controller := PhaROSHandleController robulab2. 
		pose := controller nodelets stargazer landmarkToPose: aLocalizerMeasure.
		
		controller nodelets initialpose initialPose:  pose.
]

{ #category : #private }
PureROSRobulabOld >> setPoseWith: aLocalizerMeasure [ 
	| entity pose lp  controller |

		lastPoseSettedStamp := DateAndTime now.
		controller := PhaROSHandleController robulab2. 
		entity := (controller nodelets localizer entity: aLocalizerMeasure id).
		pose := entity center.
		
		lp := controller nodelets stargazer landmarkToPose: aLocalizerMeasure.		
		
		pose position: pose position + lp position.
		
		((pose position - (controller nodelets transformation frame: '/base_link') pose position ) module2d > 0.3  and: [(lp position module2d < 0.5) ]) ifTrue: [
			
			self debug: 'setting pose'.
			controller nodelets initialpose initialPose:  pose.
			
		] ifFalse: [
			((controller nodelets transformation frame: '/base_link') pose orientation as2DOrientation z - pose orientation as2DOrientation z ) abs > 0.1 ifTrue:[
				self debug: 'setting orientation'.
				controller nodelets initialpose orientation: lp orientation as2DOrientation z.
			]
		]



]

{ #category : #private }
PureROSRobulabOld >> setupAbsolutePoseRecognizer [

	| controller |
	lastPoseSettedStamp := DateAndTime now - 1 minute.
	controller := PhaROSHandleController robulab2. 
	controller  nodelets spaceEvents whenLocalizerMeasure:  [ : lm |  
		(DateAndTime now - lastPoseSettedStamp ) asSeconds > 2
	] do: [ : lm | 
		self setAbsolutePoseWith: lm.
	].
	
	
]

{ #category : #private }
PureROSRobulabOld >> setupOriginRecognizer [
	| controller |
	checked := 0.
	controller := PhaROSHandleController robulab2. 
	lastPoseSettedStamp := DateAndTime now - 1 minute.
	controller  nodelets spaceEvents whenLocalizerMeasure:  [ : lm |  
		
		96 = lm id ifTrue: [
			checked := checked + 1.	
		] ifFalse: [
			checked := 0.
		].
		(DateAndTime now - lastPoseSettedStamp ) asSeconds > 4 and: [ 
			checked > 5 and: [
				lm pose position module2d < 2. 
			]	
		]
	] do: [ : lm | 
		self setOriginAs: lm.
	].
	
	
]

{ #category : #private }
PureROSRobulabOld >> setupPoseRecognizer [

	| controller |
	controller := PhaROSHandleController robulab2. 
	lastPoseSettedStamp := DateAndTime now - 1 minute.
	controller  nodelets spaceEvents whenLocalizerMeasure:  [ : lm |  

		(lastId = lm id and: [ lm id ~= 96]) ifTrue: [
			checked := checked + 1.	
		] ifFalse: [
			checked := 0.
		].
		lastId := lm id.

		(DateAndTime now - lastPoseSettedStamp ) asSeconds > 4 and: [ 
			checked > 5 and: [
				lm pose position module2d < 1 
			]	
		]
	] do: [ : lm | 
		self setPoseWith: lm.
	].
	
	
]

{ #category : #private }
PureROSRobulabOld >> setupPoseTracker [
	experiment controller  nodelets spaceEvents whenLocalizerMeasure:  [ : lm |  
		| entity |
		entity := (experiment controller nodelets localizer entity: lm id).
		(entity annotation: #measureStamp) isNil or: [
			( DateAndTime now - (entity annotation: #measureStamp)) asSeconds > 10 or: [ 
				(entity annotation: #lastPose ) position module2d > lm pose position module2d 
			]
		].
	] do: [ : lm | 
		| entity |
		entity := (experiment controller nodelets localizer entity: lm id).
		entity annotate:#lastPose with: (experiment controller nodelets transformation frame:'/base_link' ) pose.
		entity annotate:#measureStamp with: DateAndTime now.
	].
	
	
]

{ #category : #private }
PureROSRobulabOld >> sgMapfile [ 
	^ self class imageFolder , '/map/map.yaml'
]
