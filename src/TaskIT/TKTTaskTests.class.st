Class {
	#name : #TKTTaskTests,
	#superclass : #TestCase,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #tests }
TKTTaskTests >> testConsumableEventualTaskCountJustWhenConditionalApply [
	| task booleanExpression flag |
	
	booleanExpression := false. 
	flag := false.
	task := TKTConsumableEventualTask for: [ flag := flag not ] when: [ booleanExpression ] for: 2. 

	self assert: (task priority = Processor systemBackgroundPriority).

	task value.
	self deny: flag.	
	
	booleanExpression := true.
	
	task value. 
	self assert: flag.
	
	booleanExpression := false.
	
	task value. 
	self assert: flag.
	task value. 
	self assert: flag.
	task value. 
	self assert: flag.
	task value. 
	self assert: flag.
	
	booleanExpression := true.
	task value. 
	self deny: flag.
	task value. 
	self deny: flag.
	task value. 
	self deny: flag.
	task value. 
	self deny: flag.
]

{ #category : #tests }
TKTTaskTests >> testExecuteTask [
	| task shouldBeTrue |
	
	shouldBeTrue := false.
	task := [ shouldBeTrue := true ] asTask.
	task value. 
	
	self assert: shouldBeTrue.
	
	
	


]

{ #category : #tests }
TKTTaskTests >> testNewConsumableEventualTask [
	| task booleanExpression flag |
	
	booleanExpression := false. 
	flag := false.
	task := TKTConsumableEventualTask for: [ flag := flag not ] when: [ booleanExpression ] for: 2. 

	self assert: (task priority = Processor systemBackgroundPriority).

	task value.
	self deny: flag.	
	
	booleanExpression := true.
	
	
	
	task value. 
	self assert: flag.
	
	task value. 
	self deny: flag.
	
	task value. 
	self deny: flag.
]

{ #category : #tests }
TKTTaskTests >> testNewEventualTask [
	| task booleanExpression flag |
	
	booleanExpression := false. 
	flag := false.
	task := TKTEventualTask for: [ flag := true ] when: [ booleanExpression ]. 

	self assert: (task priority = Processor systemBackgroundPriority).

	task value.
	self deny: flag.	
	
	booleanExpression := true.
	
	task value. 
	self assert: flag.
	
]

{ #category : #tests }
TKTTaskTests >> testNewEventualTaskRequeueITSelfAtCleanup [
	| task booleanExpression flag |
	
	TKTTaskDispatcher instance: TKTTaskDispatcherMock new.
	
	
	booleanExpression := false. 
	flag := false.
	task :=  [ flag := true ]  doItWhen: [ booleanExpression ]. 
	
	
	
	self assert: TKTTaskDispatcher instance tasks size = 1.
	self assert: (task priority = Processor systemBackgroundPriority).	
	self assert: (TKTTaskDispatcher instance tasks removeFirst) = task.
	self assert: TKTTaskDispatcher instance tasks size = 0.
	
	task cleanup.
	
	self assert: TKTTaskDispatcher instance tasks size = 1.
	self assert: (TKTTaskDispatcher instance tasks removeFirst) = task.
	self assert: TKTTaskDispatcher instance tasks size = 0.
	
	TKTTaskDispatcher reset.
]

{ #category : #tests }
TKTTaskTests >> testNewTask [
	| task |
	
	task := TKTTask for: []. 
	self assert: (task priority = Processor userBackgroundPriority).

	
	


]

{ #category : #tests }
TKTTaskTests >> testNewTaskDispatcherDestroyWorkers [

		
	TKTTaskDispatcher reset.
	TKTTaskDispatcher instance.
	
	1 to: 3 do: [ : i | Smalltalk garbageCollect ].
	
	self assert: TKTWorker allInstances size = 2.
	
	TKTTaskDispatcher reset.
	
	1 to: 3 do: [ : i | Smalltalk garbageCollect ].
	
	self assert: TKTWorker allInstances size = 0.
	

]

{ #category : #tests }
TKTTaskTests >> testNewTaskDispatcherResetDestroyInstance [

	| instance |
	instance := TKTTaskDispatcherMock new.
	TKTTaskDispatcher instance: instance.
	
	self deny: instance destroyed.
	TKTTaskDispatcher reset.
	self assert: instance destroyed.
	

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
