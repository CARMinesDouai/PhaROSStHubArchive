Class {
	#name : #TKTLoopingRunner,
	#superclass : #TKTPersistentRunner,
	#instVars : [
		'future',
		'taskToRun',
		'loopsRun',
		'maxLoops'
	],
	#category : #'TaskIT-PersistenRunners'
}

{ #category : #'as yet unclassified' }
TKTLoopingRunner >> cancelFutures [

	self cancel: future
]

{ #category : #accessing }
TKTLoopingRunner >> defaultProcessName [

	^ 'Looping runner'
]

{ #category : #private }
TKTLoopingRunner >> futureForTask: aTask [ 

	^ future
]

{ #category : #'initialize-release' }
TKTLoopingRunner >> initialize [

	super initialize.
	
	loopsRun := 0.
	"By default we loop forever"
	maxLoops := Float infinity.
]

{ #category : #accessing }
TKTLoopingRunner >> loopTimes: someTimes [

	maxLoops := 0.
]

{ #category : #running }
TKTLoopingRunner >> nextTask [

	^ taskToRun
]

{ #category : #running }
TKTLoopingRunner >> run: aTask [ 

	future := self newFuture.
	taskToRun := aTask asTask.
	self start.
	^ future.
]

{ #category : #running }
TKTLoopingRunner >> shouldKeepRunning [

	^ loopsRun < maxLoops and: [ super shouldKeepRunning ].
]
