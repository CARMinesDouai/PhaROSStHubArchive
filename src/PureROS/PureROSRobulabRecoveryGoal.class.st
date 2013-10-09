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

	| vector currentPose  target  next newGoal |
		

	self flag: #refactorNeeded.
	
	
	"
		The nested goal limit is a recursive base case. When we reach the limit we cut. to do not let the system being forever in a goal.
	"
		
	aNestedGoalLimit <= 0 ifTrue: [
		Transcript show: 'Nested target limit reached. Aborting goal'; cr.
		onFailure value.
	].	
	
	
	target := aPoseTarget position. 
	currentPose := robulab currentPose position.
	vector := target -  currentPose .
	
	
	"
		If the distance to the previous target is less than the aMinDistanceToTarget value, we cannot do much here.
		
	"
	vector module2d <= aMinDistanceToTarget ifTrue: [
		Transcript show: 'Failed goal was to near to try to save'; cr.
		onSuccess value.	
	].
	
	" Rotate to clear costmap. "
	
	self recoveryRotation: robulab.
	
	"
		If the distance to the new target is less than the aMinDistanceToTarget value, we cannot do much here.
		
	"
	(vector / 2) module2d  <= aMinDistanceToTarget ifTrue: [
		Transcript show: 'Recovery goal was to near to try to save'; cr.
		onSuccess value.	
	].
	
	" 
		Then i pick a point in the half of the path (based on that the direct trajectory is a vector that belongs to continuous of known environment).
	
	"
	
	next := PhaROSPose zero. 
	
	next position:  currentPose + (vector / 2).
	next orientation: (PhaROS2DOrientation z: (vector y arcTan: vector x)).

	Transcript show: 'Recovering with ', next asString; cr.
	newGoal :=  (robulab nodelets movebase client goTo: next).
	newGoal onSucceeded: onSuccess .
	newGoal onAborted: [
		self recoverFrom: next depthLimit: aNestedGoalLimit -1 
								pointReachedAt: aMinDistanceToTarget 
								onSuccess: onSuccess 
								onFailure: onFailure 
								with: robulab
	].

	
]

{ #category : #'as yet unclassified' }
PureROSRobulabRecoveryGoal class >> recoveryRotation: robulab [
	| rotation |
	
	rotation := PhaROSPosition zero.
	
	rotation z: 1.0.
	robulab differentialMove: PhaROSPosition zero  and: rotation.
	(Delay forMilliseconds: 1500) wait.
	
	rotation z: 0.0.
	robulab differentialMove: PhaROSPosition zero  and: rotation.
		
]
