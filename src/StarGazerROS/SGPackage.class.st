Class {
	#name : #SGPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'process'
	],
	#category : #StarGazerROS
}

{ #category : #private }
SGPackage >> broadcastPoseWith: aBroadcaster [
	self controller nodelets stargazer landmarks for: [
		: lmk |
		| pose | 
		pose := self controller nodelets stargazer  landmarkToPose: lmk.
		aBroadcaster pose: pose.
	].

	
]

{ #category : #private }
SGPackage >> buildController [ 
	| ctrl | 
	ctrl :=  PhaROSHandleController  home.
	ctrl nodelets use: SGROSStarGazerNodelet  as: #stargazer.
	ctrl nodelets use: PhaROSTransformationNodelet  as: #transformation.
	^ ctrl. 
]

{ #category : #private }
SGPackage >> configureEnvironment: aStarGazer [
	| stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Setting HeightFix - yes ', String lf.

	aStarGazer heightFix: 'yes'.
	stream nextPutAll: 'Setting MarkHeight - 1200 ', String lf.
	aStarGazer markHeight: '1200'.
	stream nextPutAll: 'Setting MarkType- HLD1-S ', String lf.
	aStarGazer markType: 'HLD1-S'.
	


]

{ #category : #private }
SGPackage >> poseStampedSg [
	
	^(controller node buildConnectionFor: '/stargazer/pose') 
		 typedAs: PureROSRobulabNodelet poseStampedTopicType ;
		 adapted: #pose \> PhaROSPose  ;
	  	 connect.
]

{ #category : #scripts }
SGPackage >> scriptAbsoluteLandmark [
	| tfPseudoTopic |
.	
	tfPseudoTopic := self controller nodelets transformation between: '/base_link' 
														   and: '/map'.
	
	self controller nodelets stargazer mergeWithPose: tfPseudoTopic.

]

{ #category : #'scripts-configuration' }
SGPackage >> scriptConfiguration [

	| sg stream |
	
 
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer configureInstance.
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	stream nextPutAll: String lf, String lf, ' --------------------------------- ', String lf. 
	stream nextPutAll: ' Version=', sg version asString, String lf .
	stream nextPutAll: ' BaudRate=', sg baudRate asString, String lf .
	stream nextPutAll: ' --------------------------------- ', String lf. 
	stream nextPutAll: ' HeightFix=', sg heightFix asString, String lf .
	stream nextPutAll: ' MarkHeight=', sg markHeight asString, String lf .
	stream nextPutAll: ' MarkType=', sg markType asString, String lf .
	stream nextPutAll: ' --------------------------------- ', String lf. 
	stream nextPutAll: ' MarkMode=', sg markMode asString, String lf .
	stream nextPutAll: ' RefID=', sg refID asString, String lf .
	stream nextPutAll: ' IdNum=', sg idNum asString, String lf .
	stream nextPutAll: ' --------------------------------- ', String lf. 
	

	
	stream nextPutAll: 'Starting', String lf.
	sg startMeasurements .
	
	self quit.
]

{ #category : #scripts }
SGPackage >> scriptHDPose [

	| c |
	c := 	SGHDPoseBroadcaster for: self controller at: '/base_link'.
	self broadcastPoseWith: c .

	c start.
]

{ #category : #scripts }
SGPackage >> scriptLaunchStargazer [
	
	process := PhaROSSystemLauncher  instance launch: [: spec | 
		spec stargazer.
	].
	

]

{ #category : #'scripts-configuration' }
SGPackage >> scriptMapBuildingMode [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer mapBuilding.
	
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	

	sg startMapBuilding.
	
	
	stream nextPutAll: 'Please, move robot around, staying under each landmark and in between each pair for someseconds ', String lf.
	sg mode whenMapIsDone: [
		stream nextPutAll: 'Map is builded! You can start map-mode-based localization', String lf.
		self halt.
		self quit.
		
	].	 
	
	


]

{ #category : #scripts }
SGPackage >> scriptPose [

	self broadcastPoseWith: (SGPoseBroadcaster for: self controller at: '/base_link') .
]

{ #category : #'scripts-configuration' }
SGPackage >> scriptSetUpMap [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer configureInstance.
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting markMode - Map', String lf.
	sg markMode: 'Map'.
	stream nextPutAll: 'Setting RefID - 82', String lf.
	sg refID: '96'.
	stream nextPutAll: 'Setting IdNum- 4', String lf.
	sg idNum: 4.
	stream nextPutAll: 'Starting', String lf.
	sg startMeasurements .
	
	self quit.
]

{ #category : #'scripts-configuration' }
SGPackage >> scriptSetUpMapBuilding [

	| sg stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.
	
	sg := StarGazer configureInstance.
	
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting markMode - Map', String lf.
	sg markMode: 'Map'.
	stream nextPutAll: 'Setting RefID - 96', String lf.
	sg refID: '96'.
	stream nextPutAll: 'Setting IdNum- 6', String lf.
	sg idNum: 6.
	
	
	self quit.
	



]

{ #category : #'scripts-configuration' }
SGPackage >> scriptSetUpStandAlone [

	| sg  stream |
	
	
	stream  := FileStream stdout.
	stream nextPutAll: 'Getting starGazer', String lf.

	sg := StarGazer configureInstance.
	
	stream nextPutAll: 'Stopping starGazer', String lf.
	sg stopMeasurements.
	
	self configureEnvironment: sg.
	
	stream nextPutAll: 'Setting starGazer mark mode to Alone', String lf.
	sg markMode: 'Alone'.
	
	stream nextPutAll: 'Starting starGazer', String lf.
	sg startMeasurements .
 	5 seconds asDelay wait.
	self quit.
]

{ #category : #scripts }
SGPackage >> scriptStartMeasures [		
		
	self controller nodelets stargazer broadcastLandmarks: { 96 . 112 . 18 . 32 . 2 . 608 .0 }.

]

{ #category : #scripts }
SGPackage >> scriptTf [
	self controller nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	self controller nodelets pose2tf express: self poseStampedSg as: '/base_link'childOf: '/odom'.

	


]

{ #category : #private }
SGPackage >> updatePackages [ 
	super updatePackages.
	
	(Gofer it url:  'http://car.mines-douai.fr/squeaksource/Peripherics'
		username: 'SPB'
		password: ''; package: 'StarGazer') update.
		
	(Gofer it url:  'http://car.mines-douai.fr/squeaksource/Pure'
		username: 'SPB'
		password: ''; package: 'PureROS') update.
	
	(Gofer it url:  'http://car.mines-douai.fr/squeaksource/Pure'
		username: 'SPB'
		password: ''; package: 'PureNG') update.

]
