Class {
	#name : #TKTTaskLoopingRunnerTimesRunning,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'times'
	],
	#category : #'TaskIT-PersistentRunners-Tests'
}

{ #category : #running }
TKTTaskLoopingRunnerTimesRunning >> setUp [

	super setUp.
	runner := TKTLoopingRunner new.
	times := 0.
	runner run: [ times := times + 1 ].
	runner loopTimes: self timesToLoop.
	runner start.
	runner waitToFinish.
]

{ #category : #tests }
TKTTaskLoopingRunnerTimesRunning >> testShouldBeFinished [

	self assert: runner isTerminated
]

{ #category : #tests }
TKTTaskLoopingRunnerTimesRunning >> testTimesLoopedAreTimesToLoop [

	self assert: times equals: self timesToLoop
]

{ #category : #running }
TKTTaskLoopingRunnerTimesRunning >> timesToLoop [

	^ 17
]
