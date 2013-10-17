Class {
	#name : #PureROSRobulabRecoveryGoal,
	#superclass : #Object,
	#instVars : [
		'goal',
		'target',
		'event'
	],
	#category : #'PureROS-Nodelets-Robulab'
}

{ #category : #'as yet unclassified' }
PureROSRobulabRecoveryGoal class >> recoverFrom: aPoseTarget depthLimit: aNestedGoalLimit pointReachedAt: aMinDistanceToTarget 
onSuccess: onSuccess onFailure: onFailure with: robulab [

	| vector currentPose  target  next newGoal recovery  |
		

	self flag: #refactorNeeded.
	
	
	"
		The nested goal limit is a recursive base case. When we reach the limit we cut. to do not let the system being forever in a goal.
	"
		
	aNestedGoalLimit <= 0 ifTrue: [
		self log: 'Nested target limit reached. Aborting goal'.
		onFailure value.
	].	
	
	
	target := aPoseTarget position. 
	currentPose := robulab currentPose position.
	vector := target -  currentPose .
	
	
	"
		If the distance to the previous target is less than the aMinDistanceToTarget value, we cannot do much here.
		
	"
	vector module2d <= aMinDistanceToTarget ifTrue: [
		self log: 'Failed goal was to near to try to save'.
		onSuccess value.	
	].
	
	" Rotate to clear costmap. "
	
	self recoveryRotation: robulab.
	
	"
		If the distance to the new target is less than the aMinDistanceToTarget value, we cannot do much here.
		
	"
	(vector / 2) module2d  <= aMinDistanceToTarget ifTrue: [
		self log: 'Recovery goal was to near to try to save'.
		onSuccess value.	
	].
	
	" 
		Then i pick a point in the half of the path (based on that the direct trajectory is a vector that belongs to continuous of known environment).
	
	"
	
	next := PhaROSPose zero. 
	
	next position:  currentPose + (vector / (3/2)).
	
	next orientation: (PhaROS2DOrientation z: (vector y arcTan: vector x)).

	self log: 'Recovering with ', next asString.
	newGoal :=  (robulab nodelets movebase client goTo: next).
	
	
	
	recovery := [
		newGoal cancel.
			self recoverFrom: next depthLimit: aNestedGoalLimit -1 
									pointReachedAt: aMinDistanceToTarget 
									onSuccess: onSuccess 
									onFailure: onFailure 
									with: robulab

	].

	newGoal onSucceeded: [onSuccess value].
	
	newGoal onAborted: recovery.
	newGoal onRejected:  recovery.
	
	newGoal onPreempted:  [ self log:  'The RECOVERY goal was canceled by a cancel statement or a new goal'. ].
	newGoal onRecalled:  [self log:  'The RECOVERY goal was canceled by a cancel statement or a new goal' ].
	
	
	 ^ newGoal.
]

{ #category : #'as yet unclassified' }
PureROSRobulabRecoveryGoal class >> recoveryRotation: robulab [
	| rotation |
	
	rotation := PhaROSPosition zero.
	
	rotation z: -0.3.
	robulab differentialMove: PhaROSPosition zero  and: rotation.
	(Delay forMilliseconds: 1500) wait.
	
	rotation z: 0.0.
	robulab differentialMove: PhaROSPosition zero  and: rotation.
		
]
