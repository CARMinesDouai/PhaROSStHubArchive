Class {
	#name : #TKTTaskTests,
	#superclass : #TestCase,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
TKTTaskTests >> testExecuteTask [
	| task shouldBeTrue |
	
	shouldBeTrue := false.
	task := [ shouldBeTrue := true ] asTask.
	task value. 
	
	self assert: shouldBeTrue.
	
	
	


]

{ #category : #'as yet unclassified' }
TKTTaskTests >> testExecuteTaskAlsoReturnsResult [
	| task shouldBeTrue |
	
	shouldBeTrue := false.
	task := [  TKTTaskTests  ] asTask.
	self assert: task value = TKTTaskTests.

	
	
	


]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
TKTTaskTests >> testNewTask [
	| task |
	
	task := TKTTask for: []. 
	self assert: (task priority = Processor userBackgroundPriority).

	
	


]

{ #category : #'as yet unclassified' }
TKTTaskTests >> testNewTaskWithAsTask [
	| task |
	
	task := [] asTask.
	self assert: (task priority = Processor userBackgroundPriority).

]

{ #category : #'as yet unclassified' }
TKTTaskTests >> testNewTaskWithAsTaskAndPriority [
	| task |
	

	task := [] asTaskAt: Processor highIOPriority.
	self assert: (task priority = Processor highIOPriority).
	
	


]

{ #category : #'as yet unclassified' }
TKTTaskTests >> testNewTaskWithPriority [
	| task |
	
	
	task := TKTTask for: [] at: Processor highIOPriority. 	
	self assert: (task priority = Processor highIOPriority).
	
	
	


]

{ #category : #'as yet unclassified' }
TKTTaskTests >> testTaskAssertOrderedByPriority [
	| taskHighPriority taskLowPriority |
	
	
	taskHighPriority  := [] asTaskAt: Processor highIOPriority. 	
	taskLowPriority := [ ] asTask.
	self assert: ( taskHighPriority > taskLowPriority ).
	self assert: ( taskLowPriority < taskHighPriority ).
		
	
	


]

{ #category : #'as yet unclassified' }
TKTTaskTests >> testTaskDenialOrderedByPriority [
	| taskHighPriority taskLowPriority |
	
	
	taskHighPriority  := [] asTaskAt: Processor highIOPriority. 	
	taskLowPriority := [ ] asTask.
	self deny: ( taskHighPriority < taskLowPriority ).
	self deny: ( taskLowPriority > taskHighPriority ).
		
	
	


]

{ #category : #'as yet unclassified' }
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
