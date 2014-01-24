Class {
	#name : #TKTWorkerTests,
	#superclass : #TestCase,
	#instVars : [
		'commonTask',
		'eventualTask',
		'ceventualTask',
		'deadWorker',
		'deadEventKindWorker'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTWorkerTests >> setUp [
	super setUp.
		
	TKTTaskDispatcher instance: TKTTaskDispatcherMock new.
	
	[] scheduleIt.
	[] doItWhen: [].	
	[] doItOnceWhen: []. 	
	
	commonTask :=TKTTaskDispatcher instance tasks at:1.
	eventualTask := TKTTaskDispatcher instance tasks at:2.
	ceventualTask := TKTTaskDispatcher instance tasks at:3.
	
	
	deadWorker := TKTWorker new priority: Processor userBackgroundPriority; yourself .
	deadEventKindWorker  := TKTWorker new priority: Processor systemBackgroundPriority; timeout: 300; yourself.
]

{ #category : #'as yet unclassified' }
TKTWorkerTests >> tearDown [ 
	super tearDown.
		
	TKTTaskDispatcher reset.

]

{ #category : #'as yet unclassified' }
TKTWorkerTests >> testMatchingIndexChangeWhenThereIsWork [
	
	self assert: commonTask class =TKTTask.
	self assert: eventualTask class =TKTEventualTask.
	self assert: ceventualTask class =TKTConsumableEventualTask.
	
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

{ #category : #'as yet unclassified' }
TKTWorkerTests >> testMatchingIndexIsAlwaysTheSame [
	
	
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

{ #category : #'as yet unclassified' }
TKTWorkerTests >> testMatchingIndexShouldAssignWell [

	self assert: (deadWorker matching: commonTask) < (deadWorker matching: eventualTask).
	self assert: (deadEventKindWorker matching: commonTask) > (deadEventKindWorker matching: eventualTask).

	
	
	
	
	
	

]
