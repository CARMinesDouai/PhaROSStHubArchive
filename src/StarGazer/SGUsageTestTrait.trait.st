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
