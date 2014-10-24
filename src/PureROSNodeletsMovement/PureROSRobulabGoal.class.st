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
		'isRecoverable',
		'relatedGoals',
		'starting',
		'xRecovery'
	],
	#category : #PureROSNodeletsMovement
}

{ #category : #environment }
PureROSRobulabGoal >> arrivingThreshold [
	^ 0.30. " Meters "
]

{ #category : #behavior }
PureROSRobulabGoal >> cancel [ 
	relatedGoals do: #cancel.
	goal cancel. 
	event ifNotNil:[
		event cancel.
		event := nil.
	].
	
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
		status := #Actionlib_msgsGoalStatus asClass aborted.
		self cancel.
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

{ #category : #environment }
PureROSRobulabGoal >> enlapsedTime [
	^ DateAndTime now - starting
]

{ #category : #accessing }
PureROSRobulabGoal >> entity: anObject [
	entity := anObject
]

{ #category : #environment }
PureROSRobulabGoal >> expectedTime [
	 ^ 3 seconds.
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
  	^ [(checks > 1 and:[ entity id = aLocalizerMeasure id and: [ self isCloseEnough: aLocalizerMeasure pose ]]) or: [ 
			self status = #Actionlib_msgsGoalStatus asClass succeeded 
	].] on:Error do: [ self halt. ].
	
]

{ #category : #event }
PureROSRobulabGoal >> hasReallyArrived [ 
	| pose |

	pose := robulab nodelets transformation transformBetween: entity frameName and: '/base_link'.
	
	((self isCloseEnough: pose) not and: [goal status = #Actionlib_msgsGoalStatus asClass succeeded ]) ifTrue:[
		1 second asDelay wait.
		pose := robulab nodelets transformation transformBetween: entity frameName and: '/base_link'.
		(self isCloseEnough: pose) ifFalse: [
			^ false.
		].
	] .
	
	^ true.
]

{ #category : #behavior }
PureROSRobulabGoal >> initialize [ 
	super initialize.
	checks := 0.
	relatedGoals := Set new.
	xRecovery :=  -0.05.
]

{ #category : #testing }
PureROSRobulabGoal >> isCloseEnough: aDistanceAsPose [
	
	" This criteria is related with the environment and domain needs. This case is related with shopping mall DEMO (small place, not high accuracy needed, high density of people )"
	
	^ 
	
	(self enlapsedTime > self expectedTime and: [ aDistanceAsPose position module2d < self arrivingThreshold ])
	or: [
		(self enlapsedTime > (self expectedTime * 1.5) and: [ aDistanceAsPose position module2d < (self arrivingThreshold * 1.7)])
		or:[
			(self enlapsedTime > (self expectedTime * 2) and: [ aDistanceAsPose position module2d < (self arrivingThreshold * 2.5)])	
			or: [
				(self enlapsedTime > (self expectedTime * 2.5) and: [ aDistanceAsPose position module2d < (self arrivingThreshold * 3)])	
				or:[ 
					self enlapsedTime > (self expectedTime  * 3).
				]
			]
		]
	]

]

{ #category : #event }
PureROSRobulabGoal >> onAborted: aBlock [ 
	goal onAborted:  aBlock.
]

{ #category : #event }
PureROSRobulabGoal >> onArrivalToGoal: aLocalizerMeasure [ 
	| msgsGoalStatusClass |
	
	msgsGoalStatusClass := #Actionlib_msgsGoalStatus asClass.
	checks := 0. 
	
	self hasReallyArrived ifTrue: [
		goal status: msgsGoalStatusClass  succeeded.
		status := msgsGoalStatusClass  succeeded .
		
		self debug:' REALLY ARRIVED '.
		[
			1 seconds asDelay wait.
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
	| msgsGoalStatusClass |
	
	msgsGoalStatusClass := #Actionlib_msgsGoalStatus asClass.
	
	goal status: msgsGoalStatusClass active.
	
	self cleanup.

	(self target  position - robulab currentPose position) module2d < self arrivingThreshold ifTrue: [
		goal status: msgsGoalStatusClass  succeeded . 
		^ self.
	].

	self recoveryRotation.
	
	(self target  position - robulab currentPose position) module2d < 1.0 ifTrue: [
		"Plain retry"
		^ self configure.
	].
	
	self related:(
		PureROSRobulabRecoveryGoal recoverFrom: self target depthLimit: 2 pointReachedAt: 0.25 onSuccess: [
			self log: 'Recovery process successful. Retrying main goal'.
			self configure.	
		] onFailure: [
			self log: ' Recovery process has failed. Trying last intent for full goal'.
			self recoveryRotation.	
			self configureNonRecoverable.
		] with: robulab
	).
	
	
	


]

{ #category : #event }
PureROSRobulabGoal >> recoveryRotation [
	| rotation position |
	
	rotation := PhaROSPosition zero.
	position := PhaROSPosition zero.
	
  	position x: xRecovery.
	rotation z: -0.2.
	robulab differentialMove: position  and: rotation.
	(Delay forMilliseconds: 1000) wait.
	
	rotation z: 0.0.
	robulab differentialMove: PhaROSPosition zero  and: rotation.
	
	xRecovery := 0.0.	


]

{ #category : #testing }
PureROSRobulabGoal >> related: aGoal [
	relatedGoals add: aGoal.
]

{ #category : #accessing }
PureROSRobulabGoal >> robulab: aRobulabNodelet [
	robulab := aRobulabNodelet 
	
]

{ #category : #accessing }
PureROSRobulabGoal >> status [
	| msgsGoalStatusClass |
	
	msgsGoalStatusClass := #Actionlib_msgsGoalStatus asClass.
	^ status ifNil: [
		goal ifNil:[ -1 ]
			ifNotNil: [
				(isRecoverable and: [ goal status = msgsGoalStatusClass aborted]) ifTrue: [
					msgsGoalStatusClass active.	
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

	starting := DateAndTime now. 
	event ifNil: [
		event := robulab nodelets spaceEvents whenLocalizerMeasure:  [ :lm | 
			self hasArrived: lm. 
		] doOnce: [ : lm | 
			self onArrivalToGoal: lm 
		].
	].	
	goal := (robulab nodelets movebase client goTo: self target).
	
	
]
