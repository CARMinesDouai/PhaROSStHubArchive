Class {
	#name : #TKTLoopingRunnerTimesRunning,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'times'
	],
	#category : #'TaskIT-PersistentRunners-Tests'
}

{ #category : #running }
TKTLoopingRunnerTimesRunning >> setUp [

	super setUp.
	runner := TKTLoopingRunner new.
	times := 0.
	runner run: [ times := times + 1 ].
	runner loopTimes: self timesToLoop.
	runner start.
	runner wait.
]

{ #category : #tests }
TKTLoopingRunnerTimesRunning >> testShouldBeFinished [

	self assert: runner isTerminated
]

{ #category : #tests }
TKTLoopingRunnerTimesRunning >> testTimesLoopedAreTimesToLoop [

	self assert: times equals: self timesToLoop
]

{ #category : #running }
TKTLoopingRunnerTimesRunning >> timesToLoop [

	^ 17
]
