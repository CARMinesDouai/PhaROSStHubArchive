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
	"It just send one in 20 measures".
	checks := checks + 1.
	checks \\\ 20 = 0 ifTrue: [
		self trajectoryDifferential: aPose. 	
	].

 
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
 	| distance |
		distance := (PhaROSPose fromGeometry_msgsPose: lmk pose) position module2d.
		distance < 0.2  ifTrue: [
			"if is near enough, we stop driving and we set the goal status as succeeded"	
		
			self stopmovingAs: Actionlib_msgsGoalStatus succeeded . 
		] ifFalse: [
			(distance > 1.0 or: [ lmk id ~= entity id ]) ifTrue: [
				"if is going away from the landmark we stop moving and set the status as aborted"
				self stopmovingAs: Actionlib_msgsGoalStatus aborted. 
			] ifFalse: [
				"if we are in the interval of security we still going to the landmark"
				self differentialGoal: lmk pose.
			]
		].	
]

{ #category : #event }
PureROSRobulabGoal >> onArrivalToLandmark: aLandmark [
	goal cancel.
	goal status: PureROSRobulabGoal active.
	
	landmarkEvent := robulab nodelets baseevent whenLandmark: [ :lmk | true ] do: [ : lmk |
		self landmarkDriving: lmk.
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
	| delta |		
				
	delta := PhaROSPose position:( PhaROSPosition x: aPose position x* -1 y: aPose position y * -1 z: 0.0) 
						   orientation: self nodelets movebase  client currentPosition orientation.
	^ robulab trajectoryDifferential: delta.
]
