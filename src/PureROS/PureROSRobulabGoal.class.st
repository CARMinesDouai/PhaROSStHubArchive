Class {
	#name : #PureROSRobulabGoal,
	#superclass : #Object,
	#instVars : [
		'goal',
		'entity',
		'robulab',
		'checks',
		'status',
		'event',
		'isRecoverable'
	],
	#category : #'PureROS-Nodelets-Robulab'
}

{ #category : #behavior }
PureROSRobulabGoal >> cancel [ 

	goal cancel. 
	event ifNotNil:[
	event cancel.
	event := nil.].
	
]

{ #category : #event }
PureROSRobulabGoal >> cleanup [ 
	event cancel. 
	event := nil.
]

{ #category : #event }
PureROSRobulabGoal >> configure [

	self tryAchieveGoal.
	isRecoverable := true.
	goal onAborted: [ 
		self log: 'goal was aborted! Starting recovery behaviors... ' .
		self recoveryFromAbort.
	].
	
	goal onPreempted:  [ self log: 'The goal was canceled by a cancel statement or a new goal' ].
	goal onRecalled:  [ self log: 'The goal was canceled by a cancel statement or a new goal' ].
	goal onRejected:  [ self log: 'Goal was rejected'].
	
	
	
]

{ #category : #event }
PureROSRobulabGoal >> configureNonRecoverable [

	self tryAchieveGoal.
	isRecoverable := false. 
	goal onAborted: [ 
		status := Actionlib_msgsGoalStatus aborted.
		self log: 'Error achiving goal!'.
	].
	
	goal onPreempted:  [ 
		self log: 'The  NON RECOVER goal was canceled by a cancel statement or a new goal'. 
	].
	goal onRecalled:  [ 
		self log: 'The NON RECOVER goal was canceled by a cancel statement or a new goal'.
	].
	goal onRejected:  [ 
		self log: 'NON RECOVER Goal was rejected' .
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
PureROSRobulabGoal >> hasArrived: aLocalizerMeasure [ 
	
	entity id = aLocalizerMeasure id  ifTrue: [
		checks := checks +1
	] ifFalse: [
		checks := 0.
	] .
  
	 ((
			entity id = aLocalizerMeasure id 
			and: [ checks > 5 
				and: [ aLocalizerMeasure pose position module2d < 0.26  ] 
			]
		) or: [ 
			self status = Actionlib_msgsGoalStatus succeeded 
		] ) ifTrue:[ 
			
			^ true
		
		].
		^ false.
]

{ #category : #event }
PureROSRobulabGoal >> hasReallyArrived [ 
	| pose |

	pose := robulab nodelets transformation transformBetween: entity frameName and: '/base_link'.
	
	
	(pose position module2d > 1.0  and: [ goal status = Actionlib_msgsGoalStatus succeeded ] ) ifTrue: [ 
		1 second asDelay wait.
		pose position module2d > 1.0 ifTrue:[ 
			^ false
		 ].
	]. 
	
	^ pose position module2d < 0.4 or: [goal status = Actionlib_msgsGoalStatus succeeded ]
]

{ #category : #behavior }
PureROSRobulabGoal >> initialize [ 
	super initialize.
	checks := 0.

]

{ #category : #event }
PureROSRobulabGoal >> onAborted: aBlock [ 
	goal onAborted:  aBlock.
]

{ #category : #event }
PureROSRobulabGoal >> onArrivalToGoal: aLocalizerMeasure [ 
	checks := 0. 
	
	self hasReallyArrived ifTrue: [
		goal status: Actionlib_msgsGoalStatus  succeeded.
		status := Actionlib_msgsGoalStatus  succeeded .
		
		self debug:' REALLY ARRIVED '.
		[
			4 seconds asDelay wait.
			self debug: ' ARRIVAL EXECUTION'. 
			goal cancel.
		] doIt .
	] ifFalse: [
		self debug: ' RECONFIGURING! '.
		self configure.
	].
	
	
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
	
	goal status: Actionlib_msgsGoalStatus active.
	
	self cleanup.
	
	(self target  position - robulab currentPose position) module2d < 0.3 ifTrue: [
		goal status: Actionlib_msgsGoalStatus  succeeded . 
		^ self.
	].
	self recoveryRotation.
	
	(self target  position - robulab currentPose position) module2d < 1.0 ifTrue: [
		"Plain retry"
		^ self configure.
	].
	
	PureROSRobulabRecoveryGoal recoverFrom: self target depthLimit: 3 pointReachedAt: 0.25 onSuccess: [
		self log: 'Recovery process successful. Retrying main goal'.
		self configure.	
	] onFailure: [
		self log: ' Recovery process has failed. Trying last intent for full goal'.
		self  recoveryRotation.	
		self configureNonRecoverable.
	] with: robulab.
	
	
	
	


]

{ #category : #event }
PureROSRobulabGoal >> recoveryRotation [
	| rotation |
	
	rotation := PhaROSPosition zero.
	
	rotation z: 1.0.
	robulab differentialMove: PhaROSPosition zero  and: rotation.
	(Delay forMilliseconds: 1500) wait.
	
	rotation z: 0.0.
	robulab differentialMove: PhaROSPosition zero  and: rotation.
		


]

{ #category : #accessing }
PureROSRobulabGoal >> robulab: aRobulabNodelet [
	robulab := aRobulabNodelet 
	
]

{ #category : #accessing }
PureROSRobulabGoal >> status [
	^ status ifNil: [
		goal ifNil:[ -1 ]
			ifNotNil: [
				(isRecoverable and: [ goal status = Actionlib_msgsGoalStatus aborted]) ifTrue: [
					Actionlib_msgsGoalStatus active.	
				] ifFalse:[
					 goal status
				]
			]
	]
	
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
