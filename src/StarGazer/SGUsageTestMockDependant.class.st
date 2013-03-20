Class {
	#name : #SGUsageTestMockDependant,
	#superclass : #SGTestCaseMock,
	#traits : 'SGUsageTestTrait',
	#classTraits : 'SGUsageTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGUsageTestMockDependant >> testUseSGStream [
	self withDefaultSGPort: [ : port |
		| stream |
		stream := port asSGStream.
		self assert: stream isKindOf: SerialStream.
		self assert: stream nextMessage isKindOf: SerialStream.
	 ].
]
