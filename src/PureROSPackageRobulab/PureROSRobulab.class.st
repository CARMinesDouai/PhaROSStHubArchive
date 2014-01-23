"
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
	#name : #PureROSRobulab,
	#superclass : #PhaROSPackage,
	#instVars : [
		'experiment',
		'process',
		'lastPoseSettedStamp',
		'checked',
		'lastId',
		'controller'
	],
	#category : #PureROSPackageRobulab
}

{ #category : #private }
PureROSRobulab >> buildController [ 
	self halt: 'mmm this should not be called yet. Refactor first'.
]

{ #category : #private }
PureROSRobulab >> finalize [
	super finalize .
	controller ifNotNil: [ 
		controller finalize.
		controller := nil.
		].
	experiment ifNotNil:[ 
		experiment finalize.
		experiment := nil.	
	]
]

{ #category : #private }
PureROSRobulab >> locationRotation [
	| rotation |
	
	rotation := PhaROSPosition zero.
	
	
	rotation z: 0.0.
	controller nodelets robulab differentialMove: PhaROSPosition zero  and: rotation.
	1 hz wait.
		
	rotation z: 1.0.
	controller nodelets robulab differentialMove: PhaROSPosition zero  and: rotation.
	(Delay forMilliseconds: 2000) wait.
	
	rotation z: 0.0.
	controller nodelets robulab differentialMove: PhaROSPosition zero  and: rotation.
		
	rotation z: -1.0.
	controller nodelets robulab differentialMove: PhaROSPosition zero  and: rotation.
	(Delay forMilliseconds: 2000) wait.
	
	rotation z: 0.0.
	controller nodelets robulab differentialMove: PhaROSPosition zero  and: rotation.

]

{ #category : #private }
PureROSRobulab >> mapFile [ 
	^ self class catkin imageFolder  , '/map/map.yaml'
]

{ #category : #'scripts-error' }
PureROSRobulab >> scriptAbsoluteLandmarkLocator [

	| bot |
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
PureROSRobulab >> scriptAmclBased [
		
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
	
		
"		spec rviz."
	].
	

]

{ #category : #'scripts-launchers-base-nomap' }
PureROSRobulab >> scriptAmclBasedNoMap [
		
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

{ #category : #scripts }
PureROSRobulab >> scriptBaselinkAbsolutePose [
	controller  := PhaROSHandleController home.
	controller nodelets use: PhaROSTransformationNodelet as:#transformation.
	(controller nodelets transformation between: '/map' and: '/base_link') for: [: p | self kompaiAbsolutePose: p ]. 
	
]

{ #category : #'scripts-navigation' }
PureROSRobulab >> scriptFeedbackCompressor [

	controller := PhaROSHandleController home.
	controller nodelets use: PhaROSMoveBaseFeedbackCompressor as:#compressor.
		
]

{ #category : #'scripts-launchers' }
PureROSRobulab >> scriptHardwareUp [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec kompai2.
		spec stargazer.
		

	]
]

{ #category : #'scripts-navigation' }
PureROSRobulab >> scriptLandmarkAutoNavigation [

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
PureROSRobulab >> scriptLandmarkLocator [

	| bot |
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
PureROSRobulab >> scriptLandmarkNavigation [

	| bot |
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
PureROSRobulab >> scriptLandmarksRecognition [

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
PureROSRobulab >> scriptMapBuilding [

	process:= PhaROSSystemLauncher  instance launch: [ : spec |
		spec gmapping.
	].
	
]

{ #category : #'scripts-transformers' }
PureROSRobulab >> scriptOdometry [

	| bot |
	controller := PhaROSHandleController robulab2.
	controller nodelets odometer transformToOdometry: controller nodelets robulab  poseStamped.
	
	

]

{ #category : #'scripts-launchers-base-nomap' }
PureROSRobulab >> scriptOdometryBasedNoMap [
		
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
PureROSRobulab >> scriptOriginFixer [
	controller := PhaROSHandleController robulab2.
	controller nodelets spaceEvents registerLocalizationSensor: ( 
			controller nodelets stargazer landmarksAdaptedAs: PhaROSLocalizerMeasure 
	).
	self setupOriginRecognizer.
]

{ #category : #'scripts-navigation' }
PureROSRobulab >> scriptPointNavigation [

	| bot |
	controller := PhaROSHandleController robulab2.
	

	bot := controller nodelets robulab.
	bot rpc.
	
	
	controller nodelets spaceEvents useTfSensorTo:'/base_link'.
	
	controller nodelets localizer filein: bot landmarksFile.
	
	controller nodelets initialpose initialPose: (controller nodelets localizer entity:1) center .
	
	
	
	controller nodelets localizer transformations.
	
"
	self setupPoseTracker.
"

	bot goToEntityID: 1.	
	bot inspect.
	




]

{ #category : #'scripts-navigation' }
PureROSRobulab >> scriptPointTrajectoryNavigation [

	| bot |
	controller := PhaROSHandleController robulab2.
	

	bot := controller nodelets robulab.
	bot rpc.
	
	
	controller nodelets spaceEvents useTfSensorTo:'/base_link'.
	
	controller nodelets localizer filein: bot landmarksFile.
	
	"controller nodelets localizer filein: 'odometry-landmarks-inner.st'.
	"
	
	controller nodelets localizer transformations.
	
"
	self setupPoseTracker.
"

	bot goToEntityID: 1.	
	bot inspect.
	




]

{ #category : #'scripts-points' }
PureROSRobulab >> scriptPoseRecording [

	| bot |
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
PureROSRobulab >> scriptPoseRecordingUpdate [

	| bot |
	controller := PhaROSHandleController robulab2. 
	bot := controller nodelets robulab.
	
	controller nodelets use: PhaROSPoseTrackerNodelet as: #poseTracker.
	controller nodelets poseTracker transformations.
	controller nodelets poseTracker lastEntityRecorded: 10.
	Transcript open.

	controller nodelets poseTracker open: bot landmarksFile.
	self halt: 'Execute the next line each time that the robot is in the wanted pose. (Remember to care about where the robot is facing). In case of navigation points, mind the static obstacles in RViz!'.
	
	controller nodelets poseTracker recordCurrentPose.
	
	self halt: 'After you have recorded all the poses, you need to execute the next line in order to save the poses in a file. Take in care that this process will override all previous poses overriding the file! '.
	
	controller nodelets poseTracker save: bot landmarksFile.
	
	
	self quit. 
	
]

{ #category : #'scripts-launchers-base-nomap' }
PureROSRobulab >> scriptSandbox [
	controller := PhaROSHandleController home.
	(controller node buildConnectionFor: '/map') typedAs: 'nav_msgs/OccupancyGrid'; for: [ :grid | self halt ]; connect.
	process := PhaROSSystemLauncher instance launch: [ :spec |
		spec mapServer: self sgMapfile.
	].
	self halt.
]

{ #category : #'scripts-stargazer' }
PureROSRobulab >> scriptStandAloneMapBuildingStargazer [
	| bot stream |
	
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
PureROSRobulab >> scriptStargazerBased [
		
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
PureROSRobulab >> scriptStargazerBasedNoMap [
		
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
PureROSRobulab >> scriptStargazerOdometryBased [
		
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
PureROSRobulab >> scriptStargazerOdometryBasedNoMap [
		
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

{ #category : #'scripts-transformers' }
PureROSRobulab >> scriptTf [
	controller := PhaROSHandleController robulab2.
	controller nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	controller nodelets pose2tf express: controller nodelets robulab poseStamped 
									    as: PureROSRobulabNodelet baseLinkFrame 
								   childOf: PureROSRobulabNodelet baseLinkParentFrame.

	
]

{ #category : #private }
PureROSRobulab >> setAbsolutePoseWith: aLocalizerMeasure [ 
	| pose |

	lastPoseSettedStamp := DateAndTime now.
	pose := controller nodelets stargazer landmarkToPose: aLocalizerMeasure.
	controller nodelets initialpose initialPose:  pose.

]

{ #category : #private }
PureROSRobulab >> setOriginAs: aLocalizerMeasure [
	| pose | 
		pose := controller nodelets stargazer landmarkToPose: aLocalizerMeasure.
		
		controller nodelets initialpose initialPose:  pose.
]

{ #category : #private }
PureROSRobulab >> setPoseWith: aLocalizerMeasure [ 
	| entity pose lp  |

		lastPoseSettedStamp := DateAndTime now.

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
PureROSRobulab >> setupAbsolutePoseRecognizer [

	lastPoseSettedStamp := DateAndTime now - 1 minute.
	
	controller  nodelets spaceEvents whenLocalizerMeasure:  [ : lm |  
		(DateAndTime now - lastPoseSettedStamp ) asSeconds > 2
	] do: [ : lm | 
		self setAbsolutePoseWith: lm.
	].
	
	
]

{ #category : #private }
PureROSRobulab >> setupOriginRecognizer [
	checked := 0.
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
PureROSRobulab >> setupPoseRecognizer [

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
PureROSRobulab >> setupPoseTracker [
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
PureROSRobulab >> sgMapfile [ 
	^ self class catkin imageFolder , '/map/map.yaml'
]

{ #category : #private }
PureROSRobulab >> updatePackages [ 
	super updatePackages . 
	
	(Gofer it url:  'http://car.mines-douai.fr/squeaksource/Pure'
		username: 'SPB'
		password: ''; package: 'PureROS') update.
	
	(Gofer it url:  'http://car.mines-douai.fr/squeaksource/Pure'
		username: 'SPB'
		password: ''; package: 'PureNG') update.

	" Stargazer PAckage "
	(Gofer it url:  'http://car.mines-douai.fr/squeaksource/Peripherics'
		username: 'SPB'
		password: ''; package: 'StarGazer') update.
]
