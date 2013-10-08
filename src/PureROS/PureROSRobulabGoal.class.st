Class {
	#name : #PureROSRobulabGoal,
	#superclass : #Object,
	#instVars : [
		'goal',
		'entity',
		'robulab',
		'landmarkEvent',
		'checks',
		'moves',
		'status',
		'event'
	],
	#category : #'PureROS-Nodelets-Robulab'
}

{ #category : #behavior }
PureROSRobulabGoal >> cancel [ 

	goal cancel. 
	event ifNotNil:[
	event cancel.
	event := nil.].
	landmarkEvent ifNotNil: [ self stopmovingAs: Actionlib_msgsGoalStatus aborted ]
]

{ #category : #event }
PureROSRobulabGoal >> configure [

	self tryAchieveGoal.
	
	goal onAborted: [ 
		self halt: 'goal was aborted!' .
		self recoveryFromAbort.
	].
	
	goal onPreempted:  [ self halt: 'The goal was canceled by a cancel statement or a new goal' ].
	goal onRecalled:  [ self halt: 'The goal was canceled by a cancel statement or a new goal' ].
	
	goal onRejected:  [ self halt: 'Goal was rejected' ].
	
	
	
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
PureROSRobulabGoal >> hasArrived: aLocalizerMeasure [ 
	
	entity id = aLocalizerMeasure id  ifTrue: [
		checks := checks +1
	] ifFalse: [
		checks := 0.
	] .
  
	^ (
			entity id = aLocalizerMeasure id 
			and: [ checks > 5 
				and: [ aLocalizerMeasure pose position module2d < 0.26  ] 
			]
		) or: [ 
			self status = Actionlib_msgsGoalStatus succeeded 
		].
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
PureROSRobulabGoal >> onAborted: aBlock [ 
	goal onAborted:  aBlock.
]

{ #category : #event }
PureROSRobulabGoal >> onArrivalToGoal: aLocalizerMeasure [ 
	
	checks := 0. 
	[
		2 seconds asDelay wait.
		Transcript show:' arrivalll' ;cr.
		goal status:Actionlib_msgsGoalStatus  succeeded . 
		status:= Actionlib_msgsGoalStatus  succeeded .
		goal cancel.
	] doIt .
	
]

{ #category : #event }
PureROSRobulabGoal >> onRejected: aBlock [ 
	goal onRejected:  aBlock.
]

{ #category : #event }
PureROSRobulabGoal >> onSucceeded: aBlock [ 
	goal onSucceeded: aBlock.
]

{ #category : #event }
PureROSRobulabGoal >> recoveryFromAbort [

	| vector currentPose  target  next newGoal |

	target := self target position. 
	currentPose := robulab currentPose position.
	vector := target -  currentPose .
	
	
	next := PhaROSPose zero. 
	
	next position:  currentPose + (vector / 2).
	next orientation: (PhaROS2DOrientation z: (vector y arcTan: vector x)).
	Transcript show:'trying middle goal' , next asString ;cr.
	newGoal :=  (robulab nodelets movebase client goTo: next).
	
	newGoal onSucceeded: [ Transcript show:'going back to main goal' ;cr. self tryAchieveGoal ].
	newGoal onAborted: [ self halt: ' Error to reach goal'. self tryAchieveGoal].
		


]

{ #category : #accessing }
PureROSRobulabGoal >> robulab: aRobulabNodelet [
	robulab := aRobulabNodelet 
	
]

{ #category : #accessing }
PureROSRobulabGoal >> status [
	^ status ifNil: [
		goal ifNil:[ -1 ]
			ifNotNil: [ goal status]
	]
	
]

{ #category : #behavior }
PureROSRobulabGoal >> stopmovingAs: aState [
	robulab nodelets baseevent remove: landmarkEvent.
	goal cancel.
	goal status: aState.
	
]

{ #category : #behavior }
PureROSRobulabGoal >> target [
	^  entity center asPose.
]

{ #category : #behavior }
PureROSRobulabGoal >> trajectoryDifferential: aPose [
	 aPose ifNotNil: [
		^ robulab trajectoryDifferential: aPose.
	]
]

{ #category : #behavior }
PureROSRobulabGoal >> tryAchieveGoal [

	event ifNil: [
		event := robulab nodelets spaceEvents whenLocalizerMeasure:  [ :lm | 
			self hasArrived: lm. 
		] doOnce: [ : lm | 
			self onArrivalToGoal: lm 
		].
	].	
	goal := (robulab nodelets movebase client goTo: self target).
	
	
]
