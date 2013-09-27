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
	
	goal onAborted: [ self tryAchieveGoal.  ].
	goal onPreempted:  [ self trajectoryDifferential:  (entity annotation: #lastPose)  . ].
	goal onPreempting:  [ self trajectoryDifferential:  (entity annotation: #lastPose) . ].
	goal onRecalling:  [ self trajectoryDifferential:  (entity annotation: #lastPose) . ].
	goal onRecalled:  [ self trajectoryDifferential:  (entity annotation: #lastPose) . ].
	goal onRejected:  [ self tryAchieveGoal ].
	goal onLost:  [ self tryAchieveGoal ].
	
	
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
	Transcript show: ' asking arrival '; cr.
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
		2 seconds asDelay wait.
		Transcript show:' arrivalll' ;cr.
		goal status:Actionlib_msgsGoalStatus  succeeded . 
		status:= Actionlib_msgsGoalStatus  succeeded .
		goal cancel.
	] doIt .
	
	 


	"
	landmarkEvent := robulab nodelets sgevents whenLandmark: [ :lmk | true ] do: [ : lmk |
		self differentialGoal:   lmk.
	 ].
	"
]

{ #category : #accessing }
PureROSRobulabGoal >> onSucceeded: aBlock [ 
	goal onSucceeded: aBlock.
]

{ #category : #accessing }
PureROSRobulabGoal >> robulab: aRobulabNodelet [
	robulab := aRobulabNodelet 
	
]

{ #category : #accessing }
PureROSRobulabGoal >> status [
	^ status ifNil: [
		goal status	
	]
	
]

{ #category : #behavior }
PureROSRobulabGoal >> stopmovingAs: aState [
	robulab nodelets baseevent remove: landmarkEvent.
	goal cancel.
	goal status: aState.
	
]

{ #category : #behavior }
PureROSRobulabGoal >> trajectoryDifferential: aPose [
	 aPose ifNotNil: [
		^ robulab trajectoryDifferential: aPose.
	]
]

{ #category : #event }
PureROSRobulabGoal >> tryAchieveGoal [

	event ifNil: [
		event := robulab nodelets sgevents whenLandmark: [ :lmk | self hasArrived: lmk. ] doOnce: [ : lmk | self onArrivalToLandmark: lmk ].
	].	
	
	self trajectoryDifferential:  (entity annotation: #lastPose) .
	1 second asDelay wait.
	goal := (robulab nodelets movebase client goTo: entity center asPose).
	
	
]
