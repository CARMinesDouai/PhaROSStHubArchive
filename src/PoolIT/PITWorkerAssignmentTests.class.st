Class {
	#name : #PITWorkerAssignmentTests,
	#superclass : #TestCase,
	#instVars : [
		'commonTask',
		'eventualTask',
		'ceventualTask',
		'deadWorker',
		'deadEventKindWorker'
	],
	#category : #'PoolIT-Tests'
}

{ #category : #running }
PITWorkerAssignmentTests >> setUp [
	super setUp.
		
	PITWorkersPool instance: PITWorkersPoolMock new.
	
	[] scheduleIt.
	[] doItWhen: [].	
	[] doItOnceWhen: []. 	
	
	commonTask :=PITWorkersPool instance tasks at:1.
	eventualTask := PITWorkersPool instance tasks at:2.
	ceventualTask := PITWorkersPool instance tasks at:3.
	
	
	deadWorker := TKTWorker with: Processor userBackgroundPriority .
	deadEventKindWorker  := (TKTWorker with: Processor systemBackgroundPriority) timeout: 300; yourself.
]

{ #category : #running }
PITWorkerAssignmentTests >> tearDown [ 
	super tearDown.
		
	PITWorkersPool reset.

]

{ #category : #tests }
PITWorkerAssignmentTests >> testMatchingIndexChangeWhenThereIsWork [
	
	self assert: commonTask class =TKTJob.
	self assert: eventualTask class =PITEventualTask.
	self assert: ceventualTask class =PITConsumableEventualTask.
	
	self assert: (deadWorker matching: commonTask) < (deadWorker scheduleTask: commonTask;  matching: commonTask).
	
	self assert: (deadWorker matching: commonTask) = (deadWorker matching: commonTask).
	self assert: (deadWorker matching: eventualTask) = (deadWorker matching: eventualTask).
	self assert: (deadWorker matching: ceventualTask) = (deadWorker matching: ceventualTask).
	self assert: (deadWorker matching: ceventualTask) = (deadWorker matching: eventualTask).
	self deny: (deadWorker matching: commonTask) = (deadWorker matching: eventualTask).
	
	self assert: (deadEventKindWorker matching: commonTask) < (deadEventKindWorker scheduleTask: commonTask; matching: commonTask).
	
	self assert: (deadEventKindWorker matching: commonTask) = (deadEventKindWorker matching: commonTask).
	self assert: (deadEventKindWorker matching: eventualTask) = (deadEventKindWorker matching: eventualTask).
	self assert: (deadEventKindWorker matching: ceventualTask) = (deadEventKindWorker matching: ceventualTask).
	self assert: (deadEventKindWorker matching: ceventualTask) = (deadEventKindWorker matching: eventualTask).
	self deny: (deadEventKindWorker matching: commonTask) = (deadEventKindWorker matching: eventualTask).
	
	
	
	
	
	
	

]

{ #category : #tests }
PITWorkerAssignmentTests >> testMatchingIndexIsAlwaysTheSame [
	
	
	self assert: (deadWorker matching: commonTask) = (deadWorker matching: commonTask).
	self assert: (deadWorker matching: eventualTask) = (deadWorker matching: eventualTask).
	self assert: (deadWorker matching: ceventualTask) = (deadWorker matching: ceventualTask).
	self assert: (deadWorker matching: ceventualTask) = (deadWorker matching: eventualTask).
	self deny: (deadWorker matching: commonTask) = (deadWorker matching: eventualTask).

	self assert: (deadEventKindWorker matching: commonTask) = (deadEventKindWorker matching: commonTask).
	self assert: (deadEventKindWorker matching: eventualTask) = (deadEventKindWorker matching: eventualTask).
	self assert: (deadEventKindWorker matching: ceventualTask) = (deadEventKindWorker matching: ceventualTask).
	self assert: (deadEventKindWorker matching: ceventualTask) = (deadEventKindWorker matching: eventualTask).
	self deny: (deadEventKindWorker matching: commonTask) = (deadEventKindWorker matching: eventualTask).
	
	
	
	
	
	

]

{ #category : #tests }
PITWorkerAssignmentTests >> testMatchingIndexShouldAssignWell [

	self assert: (deadWorker matching: commonTask) < (deadWorker matching: eventualTask).
	self assert: (deadEventKindWorker matching: commonTask) > (deadEventKindWorker matching: eventualTask).

	
	
	
	
	
	

]
