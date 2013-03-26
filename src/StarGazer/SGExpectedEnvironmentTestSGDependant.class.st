Class {
	#name : #SGExpectedEnvironmentTestSGDependant,
	#superclass : #SGTestCaseDeviceDependant,
	#traits : 'SGExpectedEnvironmentTestTrait',
	#classTraits : 'SGExpectedEnvironmentTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #d }
SGExpectedEnvironmentTestSGDependant >> testIDNum [
	self assertExpectedParameter: SGProtocol idNum withBlock: [ :val | val asInteger > 0 ].

]

{ #category : #d }
SGExpectedEnvironmentTestSGDependant >> testReadingFromGate [

	"self withDefaultSGGate:  [: gate | 
		| message |
		gate startCalculations.
		self waitForUser: 'Please, put a landmark near the stargazer to proceed with the test'.
		
		message := gate nextMessageOrNoMessage .
		self assert: message notNil.
		self assert: message ~= SGMessage NoMessage.
	]"
]
