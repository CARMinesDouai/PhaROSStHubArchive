Class {
	#name : #TKTTaskDispatcherTests,
	#superclass : #TestCase,
	#category : #'TaskIT-Tasks-Worker-Tests'
}

{ #category : #tests }
TKTTaskDispatcherTests >> testNewTaskDispatcherDestroyWorkers [

		
	TKTTaskDispatcher reset.
	TKTTaskDispatcher instance.
	
	20 timesRepeat: [Smalltalk garbageCollect ].
	
	self assert: TKTWorker allInstances size = 2.
	
	TKTTaskDispatcher reset.
	
	1 to: 3 do: [ : i | Smalltalk garbageCollect ].
	
	self assert: TKTWorker allInstances size = 0.
	

]

{ #category : #tests }
TKTTaskDispatcherTests >> testNewTaskDispatcherResetDestroyInstance [

	| instance |
	instance := TKTTaskDispatcherMock new.
	TKTTaskDispatcher instance: instance.
	
	self deny: instance destroyed.
	TKTTaskDispatcher reset.
	self assert: instance destroyed.
	

]
