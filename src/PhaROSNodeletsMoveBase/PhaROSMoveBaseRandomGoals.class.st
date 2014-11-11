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

{ #category : #accessing }
PhaROSMoveBaseRandomGoals >> client: aClient [
	client := aClient 
]

{ #category : #'setting run state' }
PhaROSMoveBaseRandomGoals >> complete [
	self statsFor: currentGoal.
	(while cull: self)
		ifTrue: [ 
			(Delay forMilliseconds: 1000) wait.
			self start ]
		ifFalse: [ self halt: 'END :)' ]
]

{ #category : #initialization }
PhaROSMoveBaseRandomGoals >> initialize [ 
	stats := Dictionary new
]

{ #category : #accessing }
PhaROSMoveBaseRandomGoals >> poses: anArrayOfPoses [ 
	self assert: anArrayOfPoses size > 1. 
	poses := anArrayOfPoses 
]

{ #category : #accessing }
PhaROSMoveBaseRandomGoals >> start [
	| rnd |
	
	[ rnd := Random new nextInt: poses size ] doWhileTrue: [ rnd = currentPoseIDX ].
	currentPoseIDX := rnd.

	currentGoal := client goTo: (poses at: currentPoseIDX).	
	currentGoal onSucceeded: [self complete].
	currentGoal onAborted: [self complete].
	currentGoal onRejected: [self complete].
]

{ #category : #accessing }
PhaROSMoveBaseRandomGoals >> statsFor: aGoal [
	^ (stats at: aGoal destination 
				ifAbsentPut: [ OrderedCollection new ]) 
			add: aGoal statusText
]

{ #category : #accessing }
PhaROSMoveBaseRandomGoals >> while: aBLock [ 
	while := aBLock 
]
