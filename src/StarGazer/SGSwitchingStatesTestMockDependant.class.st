Class {
	#name : #SGSwitchingStatesTestMockDependant,
	#superclass : #SGTestCaseMock,
	#traits : 'SGSwitchingStatesTestTrait',
	#classTraits : 'SGSwitchingStatesTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'from idle' }
SGSwitchingStatesTestMockDependant >> setUp [ 
	super setUp.
	selectedContent := '~!SetEnd`'.
]
