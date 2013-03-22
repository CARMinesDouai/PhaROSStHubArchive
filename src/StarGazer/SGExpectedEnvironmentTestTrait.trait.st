Trait {
	#name : #SGExpectedEnvironmentTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestTrait >> testReadingFromGate [

	self withDefaultSGGate:  [: gate | 
		| message |
		self waitForUser: 'Please, put a landmark near the stargazer to proceed with the test'.
		
		message := gate nextMessageOrNoMessage .
		self assert: message notNil.
		self assert: message ~= SGMessage NoMessage.
	]
]

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestTrait >> testStartCalculations [
	self withDefaultSGGate: [ : gate |
		self assert: gate startCalculations.
	].
]

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestTrait >> testStopCalculations [
	self withDefaultSGGate: [ : gate |
		self assert: gate stopCalculations.
	].
]

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestTrait >> testVersion [
	self withDefaultSGGate: [ : gate |
		self assert: ((gate get: SGProtocol version) = '2.0'). 
	].
]
