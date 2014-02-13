Class {
	#name : #TaskITExamples,
	#superclass : #Object,
	#category : #'TaskIT-Examples'
}

{ #category : #'as yet unclassified' }
TaskITExamples class >> bla [

]

{ #category : #'as yet unclassified' }
TaskITExamples class >> bla: anObject [
	"FileStream stdout nextPutAll: anObject asString, String lf."

]

{ #category : #'as yet unclassified' }
TaskITExamples >> commonSchedduledTask [
	"
	self new commonSchedduledTask
	"
	
	^ [ 2 + 2 ] scheduleIt value = 4 
]

{ #category : #'as yet unclassified' }
TaskITExamples >> commonTask [ 
	"
	self new commonTask
	
	This code snippett execute this block as an individual process and return a TKTStickyFuture, which is related with the process and the result of the execution.
	
	"
	
	^ [ 2 + 2 ] shootIt value = 4 .
]

{ #category : #'as yet unclassified' }
TaskITExamples >> commonTaskResult [
	"
	self new commonTaskResult
	
	In this case, we ask to the future for a result. A result object is an object that depends in that future and it becomes into the value of the future when it is finally processed. 
	"
	| result |
	result :=  [ 2 + 2 ] shootIt asResult.
	self assert: result class = TKTLazyResult.
	(Delay forMilliseconds: 300) wait.
	self assert: result = 4.0. 
]

{ #category : #'as yet unclassified' }
TaskITExamples >> referencedProcess [
	^ [1 to: 23330 do: [ :i |Transcript show: 'running'; cr. (Delay forMilliseconds: 500) wait] ] shootIt asStickyReference.
]

{ #category : #'as yet unclassified' }
TaskITExamples >> referencedTask [
	^ [[ true ] whileTrue: [ Transcript show: 'running in a task'; cr. (Delay forMilliseconds: 500) wait] ] scheduleIt asStickyReference.
]

{ #category : #'as yet unclassified' }
TaskITExamples >> wrappingCalls [
	"
	self new wrappingCalls. 
	
	In this snippet of code we can see how to transform a call to method to any object into a task and executeit paralelly
	"
	| result |
	result :=   2 paralellize + 2.
	self assert: result class = TKTLazyResult.
	(Delay forMilliseconds: 300) wait.
	self assert: result = 4.0. 
	
	result := Object paralellize new.
	self assert: result class = TKTLazyResult.
	(Delay forMilliseconds: 300) wait.
	self assert: result class = Object. 
]
