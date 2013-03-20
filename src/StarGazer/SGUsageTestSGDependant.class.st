Class {
	#name : #SGUsageTestSGDependant,
	#superclass : #SGTestCaseDeviceDependant,
	#traits : 'SGUsageTestTrait',
	#classTraits : 'SGUsageTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGUsageTestSGDependant >> testUseSGStream [
	self withDefaultSGPort: [ : port |
		| stream |
		stream := port asSGStream.
		self assert: stream isKindOf: SerialStream.
		self assert: stream nextMessage isKindOf: SerialStream.
	 ].
]
