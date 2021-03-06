Class {
	#name : #TKTTaskTests,
	#superclass : #TestCase,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #tests }
TKTTaskTests >> testExecuteTask [
	| task shouldBeTrue |
	
	shouldBeTrue := false.
	task := [ shouldBeTrue := true ] asTask.
	task value. 
	
	self assert: shouldBeTrue.
	
	
	


]

{ #category : #tests }
TKTTaskTests >> testNewTask [
	| task |
	
	task := TKTTask for: []. 
	self assert: (task priority = Processor userBackgroundPriority).

	
	


]

{ #category : #tests }
TKTTaskTests >> testNewTaskWithAsTask [
	| task |
	
	task := [] asTask.
	self assert: (task priority = Processor userBackgroundPriority).

]

{ #category : #tests }
TKTTaskTests >> testNewTaskWithAsTaskAndPriority [
	| task |
	

	task := [] asTaskAt: Processor highIOPriority.
	self assert: (task priority = Processor highIOPriority).
	
	


]

{ #category : #tests }
TKTTaskTests >> testNewTaskWithPriority [
	| task |
	
	
	task := TKTTask for: [] at: Processor highIOPriority. 	
	self assert: (task priority = Processor highIOPriority).
	
	
	


]

{ #category : #tests }
TKTTaskTests >> testTaskAssertOrderedByPriority [
	| taskHighPriority taskLowPriority |
	
	
	taskHighPriority  := [] asTaskAt: Processor highIOPriority. 	
	taskLowPriority := [ ] asTask.
	self assert: ( taskHighPriority > taskLowPriority ).
	self assert: ( taskLowPriority < taskHighPriority ).
		
	
	


]

{ #category : #tests }
TKTTaskTests >> testTaskDenialOrderedByPriority [
	| taskHighPriority taskLowPriority |
	
	
	taskHighPriority  := [] asTaskAt: Processor highIOPriority. 	
	taskLowPriority := [ ] asTask.
	self deny: ( taskHighPriority < taskLowPriority ).
	self deny: ( taskLowPriority > taskHighPriority ).
		
	
	


]

{ #category : #tests }
TKTTaskTests >> testTaskOrderInASortedCollection [
	| taskHighPriority taskLowPriority taskMiddlePriority collection |
	
	
	collection := SortedCollection sortBlock: [ :w1 :w2 | w1 > w2 ].
	taskHighPriority  := [] asTaskAt: Processor highIOPriority. 	
	taskMiddlePriority := [] asTaskAt: Processor lowIOPriority.
	taskLowPriority := [] asTask.
	
	collection add: taskLowPriority.
	collection add: taskHighPriority.
	collection add: taskMiddlePriority.
	
	self assert: (collection at:1 ) = taskHighPriority.
	self assert: (collection at:2 ) = taskMiddlePriority.
	self assert: (collection at:3 ) = taskLowPriority.


]
