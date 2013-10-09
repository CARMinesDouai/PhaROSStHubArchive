Class {
	#name : #PureROSRobulabGoal,
	#superclass : #Object,
	#instVars : [
		'goal',
		'entity',
		'robulab',
		'checks',
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
	
]

{ #category : #event }
PureROSRobulabGoal >> cleanup [ 
	event cancel. 
	event := nil.
]

{ #category : #event }
PureROSRobulabGoal >> configure [

	self tryAchieveGoal.
	
	goal onAborted: [ 
		Transcript show: 'goal was aborted! Starting recovery behaviors... ' ;cr.
		self recoveryFromAbort.
	].
	
	goal onPreempted:  [ Transcript show: 'The goal was canceled by a cancel statement or a new goal';cr ].
	goal onRecalled:  [ Transcript show: 'The goal was canceled by a cancel statement or a new goal';cr ].
	goal onRejected:  [ Transcript show: 'Goal was rejected' ;cr].
	
	
	
]

{ #category : #event }
PureROSRobulabGoal >> configureNonRecoverable [

	self tryAchieveGoal.
	
	goal onAborted: [ 
		self halt: 'Error achiving goal!'.
		self error: 'Error achiving goal!'.
	].
	
	goal onPreempted:  [ 
		Transcript show: 'The  NON RECOVER goal was canceled by a cancel statement or a new goal';cr 
	].
	goal onRecalled:  [ 
		Transcript show: 'The NON RECOVER goal was canceled by a cancel statement or a new goal' ; cr
	].
	goal onRejected:  [ 
		Transcript show: 'NON RECOVER Goal was rejected' ;cr
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
			self halt.
			^ true
		
		].
		^ false.
]

{ #category : #event }
PureROSRobulabGoal >> hasReallyArrived [ 
	| pose |

	robulab nodelets transformation transformBetween: entity frameName and: '/base_link'.
	
	
(	 pose position module2d > 1.0 goal and: [status = Actionlib_msgsGoalStatus succeeded ] ) ifTrue: [ self halt.]. 
	
	^ pose position module2d < 1.0 goal or: [status = Actionlib_msgsGoalStatus succeeded ]
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
		Transcript show: ' REALLY ARRIVED ';cr.
		[
			2 seconds asDelay wait.
			Transcript show:' arrivalll' ;cr.
			goal status:Actionlib_msgsGoalStatus  succeeded . 
			status:= Actionlib_msgsGoalStatus  succeeded .
			goal cancel.
		] doIt .
	] ifFalse: [
		Transcript show: ' RECONFIGURING! '; cr.
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
	
	self cleanup.
	
	PureROSRobulabRecoveryGoal recoverFrom: self target depthLimit: 3 pointReachedAt: 0.25 onSuccess: [
		Transcript show: 'Recovery process successful. Retrying main goal'.
		self configure.	
	] onFailure: [
		Transcript show: ' Recovery process has failed. Trying last intent for full goal'; cr.
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
			ifNotNil: [ goal status]
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
