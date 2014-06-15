"
A TKTLoopingRunner is a persistent runner that will loop and execute a unique task many times
"
Class {
	#name : #TKTLoopingRunner,
	#superclass : #TKTPersistentRunner,
	#instVars : [
		'future',
		'loopsRun',
		'maxLoops',
		'jobToLoop'
	],
	#category : #'TaskIT-PersistentRunners'
}

{ #category : #running }
TKTLoopingRunner >> afterRunTask: aTask [

	loopsRun := loopsRun + 1
]

{ #category : #cancelling }
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

	maxLoops := someTimes.
]

{ #category : #running }
TKTLoopingRunner >> nextTask [

	^ jobToLoop
]

{ #category : #running }
TKTLoopingRunner >> run: aJob [ 

	jobToLoop := aJob asTKTJob.
	self start.
]

{ #category : #running }
TKTLoopingRunner >> shouldKeepRunning [

	^ loopsRun < maxLoops and: [ super shouldKeepRunning ].
]
