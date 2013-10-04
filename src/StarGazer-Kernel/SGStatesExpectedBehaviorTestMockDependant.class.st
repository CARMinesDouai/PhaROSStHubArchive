Class {
	#name : #SGStatesExpectedBehaviorTestMockDependant,
	#superclass : #SGTestCaseMock,
	#traits : 'SGStatesExpectedBehaviorTestTrait',
	#classTraits : 'SGStatesExpectedBehaviorTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGStatesExpectedBehaviorTestMockDependant >> openSerialPort [ 
	^ serialMock ifNil: [serialMock := SGDummySerialMock new] ifNotNil: [ serialMock ].
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestMockDependant >> testFlowIdleCalculatingIdle [
	
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestMockDependant >> testFlowIdleCalculatingIdleRead [
	
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestMockDependant >> testFlowIdleCalculatingIdleWrite [
	
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestMockDependant >> testFlowIdleCalculatingRead [
	
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestMockDependant >> testFlowIdleCalculatingWrite [
	
]

{ #category : #'calculating state' }
SGStatesExpectedBehaviorTestMockDependant >> testHasMessageFalseAtCalculatingStateWithoutReading [

]

{ #category : #'calculating state' }
SGStatesExpectedBehaviorTestMockDependant >> testHasMessageTrueAtCalculatingStateWithReading [

]

{ #category : #'calculating state' }
SGStatesExpectedBehaviorTestMockDependant >> testNextMessageGetSomethingAtCalculatingStateWithReading [

]
