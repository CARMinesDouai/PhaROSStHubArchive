Trait {
	#name : #SGUsageTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'as yet unclassified' }
SGUsageTestTrait >> testUseGate [
	self withDefaultSGGate: [ : gate |
		self deny: gate hasMessages.
	 ].
]

{ #category : #'as yet unclassified' }
SGUsageTestTrait >> testUsePort [
	self withDefaultSerialPort: [ : port |
		self halt.
	 ].
]

{ #category : #'as yet unclassified' }
SGUsageTestTrait >> testUseSGStream [
	self withDefaultSerialPort: [ : port |
		| stream |
		stream := port asSGStream.
		self assert: (stream isKindOf: SGStream).
	 ].
]

{ #category : #'as yet unclassified' }
SGUsageTestTrait >> testUseStarGazer [

	|   expectedPose  |
	
	self withDefaultStarGazer: 	[ : stargazer | 
		expectedPose := SGPose position: (SGPoint x: 0 y: 0 z: 0)  orientation: (Float pi /2).
		self assert: stargazer lastKnownPosition = expectedPose . 
		self assert: (stargazer lastMark = SGLandMark id: 1 height: 2.5 mts  pose:  expectedPose).
	]
]
