Class {
	#name : #PITWorkersPoolTests,
	#superclass : #TestCase,
	#category : #'PoolIT-Tests'
}

{ #category : #tests }
PITWorkersPoolTests >> testNewTaskDispatcherDestroyWorkers [

		
	PITWorkersPool reset.
	PITWorkersPool instance.
	
	20 timesRepeat: [Smalltalk garbageCollect ].
	
	self assert: TKTWorker allInstances size = 2.
	
	PITWorkersPool reset.
	
	1 to: 3 do: [ : i | Smalltalk garbageCollect ].
	
	self assert: TKTWorker allInstances size = 0.
	

]

{ #category : #tests }
PITWorkersPoolTests >> testNewTaskDispatcherResetDestroyInstance [

	| instance |
	instance := PITWorkersPoolMock new.
	PITWorkersPool instance: instance.
	
	self deny: instance destroyed.
	PITWorkersPool reset.
	self assert: instance destroyed.
	

]
