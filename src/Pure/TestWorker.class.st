Class {
	#name : #TestWorker,
	#superclass : #TestCase,
	#instVars : [
		'worker',
		'semaphore'
	],
	#category : #'Pure-Tests-RobotIndependent'
}

{ #category : #'as yet unclassified' }
TestWorker >> setUp [ 
	worker := PureWorker pickOne.
	semaphore := Semaphore new.
]

{ #category : #'as yet unclassified' }
TestWorker >> tearDown [  
	worker stop.
		
]

{ #category : #'as yet unclassified' }
TestWorker >> testWorkerExecuteWork [
	| aValue |	

	aValue = false.
	worker addWork: [
		aValue := true.
		semaphore signal.
	].

	self deny: (semaphore waitTimeoutSeconds:  2).
	
	self assert: aValue.
	
]

{ #category : #'as yet unclassified' }
TestWorker >> testWorkerTimeOutExecution [
	| aValue |	

	aValue = false.
	worker onIdleTime: [
		aValue := true.
		semaphore signal.
	].

	worker waitTimeoutInSeconds: 1.
	worker addWork: [].
	
	self deny: (semaphore waitTimeoutSeconds:  2).
	
	self assert: aValue.
	
]
