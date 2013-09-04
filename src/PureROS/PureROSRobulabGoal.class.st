Class {
	#name : #PureROSRobulabGoal,
	#superclass : #Object,
	#instVars : [
		'goal',
		'entity',
		'robulab',
		'landmarkEvent',
		'checks',
		'moves'
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
	
	pose := PhaROSPose fromGeometry_msgsPose: aPose pose.
	(pose position module2d < 0.25 or: [ moves > 2 ]) ifTrue: [
		entity extraInfo: (robulab nodelets transformation frame: '/base_link') pose.
		landmarkEvent cancel. 	
	] ifFalse: [
		checks \\\ 10 = 0 ifTrue: [
			self trajectoryDifferential: pose.  	
			moves := moves + 1.
		].
	].
	checks := checks + 1.
 
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
	checks := checks +1.
 	^ entity id = lmk landmark and: [ checks > 5 and: [ (PhaROSPose fromGeometry_msgsPose: lmk pose) position module2d < 2  ] ]
]

{ #category : #behavior }
PureROSRobulabGoal >> initialize [ 
	super initialize.
	checks := 0.
	moves := 0.
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
	
	checks := 0. 
	
	[
	
		Transcript show:'cutter';cr.
		 2 seconds asDelay wait.
		goal cancel.
		0.5 seconds asDelay wait.
		goal status: Actionlib_msgsGoalStatus  succeeded .
	
	 ] doIt.


	"
	landmarkEvent := robulab nodelets sgevents whenLandmark: [ :lmk | true ] do: [ : lmk |
		self differentialGoal:   lmk.
	 ].
	"
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
	
	position := PhaROSPosition x: position y y: position x* -1 z: 0.0.
	
	
	"position :=  baseo rotatePosition: position."
	delta := PhaROSPose position: position  orientation: PhaROSQuaternion zero.
	^ robulab trajectoryDifferential: delta.

]
