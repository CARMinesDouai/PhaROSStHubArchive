Class {
	#name : #PhaROSMoveBaseRandomGoals,
	#superclass : #Object,
	#instVars : [
		'poses',
		'while',
		'client',
		'currentGoal',
		'currentPoseIDX',
		'stats'
	],
	#category : #PhaROSNodeletsMoveBase
}

{ #category : #'as yet unclassified' }
PhaROSMoveBaseRandomGoals >> client: aClient [
	client := aClient 
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseRandomGoals >> complete [
	self statsFor: currentGoal.
	(while cull: self) ifTrue: [( Delay forMilliseconds: 1000) wait.  self start ] ifFalse: [ self halt: 'END :)'].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseRandomGoals >> initialize [ 
	stats := Dictionary new
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseRandomGoals >> poses: anArrayOfPoses [ 
	self assert: anArrayOfPoses size >1. 
	poses := anArrayOfPoses 
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseRandomGoals >> start [
	| rnd |
	
	[ rnd := (Random new nextInt: poses size)] doWhileTrue: [ rnd = currentPoseIDX ].
	currentPoseIDX := rnd.
	
	currentGoal := client goTo: (poses at:currentPoseIDX).
	

	currentGoal onSucceeded: [self complete].
	currentGoal onAborted: [self complete].
	currentGoal onRejected: [self complete].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseRandomGoals >> statsFor: aGoal [
	^ (stats at: aGoal destination ifAbsentPut: [ OrderedCollection new ]) add: aGoal statusText. 
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseRandomGoals >> while: aBLock [ 
	while := aBLock 
]
