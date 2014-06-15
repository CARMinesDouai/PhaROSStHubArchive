Class {
	#name : #TKTWorkerTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'times',
		'worker'
	],
	#category : #'TaskIT-PersistentRunners-Tests'
}

{ #category : #running }
TKTWorkerTests >> setUp [

	super setUp.
	worker := TKTWorker suspended.
]

{ #category : #running }
TKTWorkerTests >> tearDown [

	super tearDown.
	worker stop.
]

{ #category : #tests }
TKTWorkerTests >> testRunningWorkerExecutesTasksAsTheyArrive [

	|  task  |
	task := [ 1 ].
	worker resume.
	
	worker run: task.
	(Delay forMilliseconds: 10) wait.
	self assert: worker pendingTasks size equals: 0.
	
	worker run: task.
	(Delay forMilliseconds: 10) wait.
	self assert: worker pendingTasks size equals: 0.
]

{ #category : #tests }
TKTWorkerTests >> testSuspendedWorkerQueuesTasks [

	| total task finished |
	total := 0.
	task := [ total := total + 1. self halt. ].
	finished := Semaphore new.
	
	worker run: task.
	worker run: task.
	worker run: task.
	worker run: task.
	
	self assert: worker pendingTasks size equals: 4
]

{ #category : #tests }
TKTWorkerTests >> testWorkerExecutesManyTasks [

	| total task finished |
	total := 0.
	task := [ total := total + 1 ].
	finished := Semaphore new.
	
	worker run: task.
	worker run: task.
	worker run: task.
	worker run: task.
	worker run: [ finished signal ].
	
	worker resume.
	finished wait.
	
	self assert: total equals: 4.
]

{ #category : #tests }
TKTWorkerTests >> testWorkerExecutesTasksInOrder [

	|   finished collection |
	collection := OrderedCollection new.
	finished := Semaphore new.
	
	worker run: [ collection add: 1 ].
	worker run: [ collection add: 2 ].
	worker run: [ collection add: 3 ].
	worker run: [ collection add: 4 ].
	worker run: [ finished signal ].
	
	worker resume.
	finished wait.
	
	self assert: collection size equals: 4.
	self assert: collection equals: collection sorted.
]
