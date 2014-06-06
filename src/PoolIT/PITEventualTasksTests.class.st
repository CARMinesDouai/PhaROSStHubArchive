Class {
	#name : #PITEventualTasksTests,
	#superclass : #TKTTaskTests,
	#category : #'PoolIT-Tasks-Test'
}

{ #category : #tests }
PITEventualTasksTests >> testConsumableEventualTaskCountJustWhenConditionalApply [
	| task booleanExpression flag |
	
	booleanExpression := false. 
	flag := false.
	task := PITConsumableEventualTask for: [ flag := flag not ] when: [ booleanExpression ] for: 2. 

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
PITEventualTasksTests >> testNewConsumableEventualTask [
	| task booleanExpression flag |
	
	booleanExpression := false. 
	flag := false.
	task := PITConsumableEventualTask for: [ flag := flag not ] when: [ booleanExpression ] for: 2. 

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
PITEventualTasksTests >> testNewEventualTask [
	| task booleanExpression flag |
	
	booleanExpression := false. 
	flag := false.
	task := PITEventualTask for: [ flag := true ] when: [ booleanExpression ]. 

	self assert: (task priority = Processor systemBackgroundPriority).

	task value.
	self deny: flag.	
	
	booleanExpression := true.
	
	task value. 
	self assert: flag.
	
]

{ #category : #tests }
PITEventualTasksTests >> testNewEventualTaskRequeueITSelfAtCleanup [
	| task booleanExpression flag |
	
	PITWorkersPool instance: PITWorkersPoolMock new.
	
	
	booleanExpression := false. 
	flag := false.
	task :=  [ flag := true ]  doItWhen: [ booleanExpression ]. 
	
	
	
	self assert: PITWorkersPool instance tasks size = 1.
	self assert: (task priority = Processor systemBackgroundPriority).	
	self assert: (PITWorkersPool instance tasks removeFirst) = task.
	self assert: PITWorkersPool instance tasks size = 0.
	
	task cleanup.
	
	self assert: PITWorkersPool instance tasks size = 1.
	self assert: (PITWorkersPool instance tasks removeFirst) = task.
	self assert: PITWorkersPool instance tasks size = 0.
	
	PITWorkersPool reset.
]
