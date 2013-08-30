Class {
	#name : #PureROSRobulabGoal,
	#superclass : #Object,
	#instVars : [
		'goal',
		'entity',
		'robulab',
		'landmarkEvent',
		'checks'
	],
	#category : #'PureROS-Nodelets'
}

{ #category : #behavior }
PureROSRobulabGoal >> cancel [ 
	goal cancel. 
	landmarkEvent ifNotNil: [ self stopmovingAs: Actionlib_msgsGoalStatus aborted ]
]

{ #category : #behavior }
PureROSRobulabGoal >> differentialGoal: aPose [ 
	
	| pose |
	"It just send one in 20 measures".
	checks := checks + 1.
	pose := PhaROSPose fromGeometry_msgsPose: aPose pose.
	pose position module2d < 0.3 ifTrue: [
		landmarkEvent cancel. 	
	] ifFalse: [
		checks \\\ 20 = 0 ifTrue: [
			self trajectoryDifferential: aPose. 	
		].
	]

 
]

{ #category : #accessing }
PureROSRobulabGoal >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
PureROSRobulabGoal >> goal: aGoal [
	goal := aGoal.
]

{ #category : #testing }
PureROSRobulabGoal >> hasArrived: lmk [
 	^ entity id = lmk landmark and: [ (PhaROSPose fromGeometry_msgsPose: lmk pose) position module2d < 0.8  ]
]

{ #category : #behavior }
PureROSRobulabGoal >> initialize [ 
	super initialize.
	checks := 0.
]

{ #category : #behavior }
PureROSRobulabGoal >> landmarkDriving: lmk [
 	| pose |
	
		Transcript show: 'second goal'; cr.
	
		pose := PhaROSPose fromGeometry_msgsPose: lmk pose.
		goal:= robulab nodelets movebase client goTo: pose.
		
		
]

{ #category : #event }
PureROSRobulabGoal >> onArrivalToLandmark: aLandmark [
	goal cancel.
	goal status: Actionlib_msgsGoalStatus  active.
	
	landmarkEvent := robulab nodelets sgevents whenLandmark: [ :lmk | true ] do: [ : lmk |
		self differentialGoal:   lmk.
	 ].
	
]

{ #category : #accessing }
PureROSRobulabGoal >> robulab: aRobulabNodelet [
	robulab := aRobulabNodelet 
	
]

{ #category : #accessing }
PureROSRobulabGoal >> status [
	goal status
]

{ #category : #behavior }
PureROSRobulabGoal >> stopmovingAs: aState [
	robulab nodelets baseevent remove: landmarkEvent.
	goal cancel.
	goal status: aState.
	
]

{ #category : #behavior }
PureROSRobulabGoal >> trajectoryDifferential: aPose [
	| delta tf odomo baseo position |		
				
	"delta := PhaROSPose position:( PhaROSPosition x: aPose position x* -1 y: aPose position y * -1 z: 0.0) 
						   orientation: self nodelets movebase  client currentPosition orientation."
						
	

	"aPose poseRelativeTo: (robulab nodelets transformation frame: '/base_link')."
	position := aPose position. 
	
	odomo := (robulab nodelets transformation frame: '/odom' ) pose orientation.
	baseo := (robulab nodelets transformation frame: '/base_link' ) pose orientation.
	
	position := odomo rotatePosition:  position. 
	position x: position x * -1.
	"position :=  baseo rotatePosition: position."
	delta := PhaROSPose position: position orientation: PhaROSQuaternion zero.
	^ robulab trajectoryDifferential: delta.




]
