Class {
	#name : #SGUsageTestMockDependant,
	#superclass : #SGTestCaseMock,
	#traits : 'SGUsageTestTrait',
	#classTraits : 'SGUsageTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGUsageTestMockDependant >> setUp [ 
	selectedContent := '~!Soemthing`'
]

{ #category : #'as yet unclassified' }
SGUsageTestMockDependant >> testUseSGStream [
	self withDefaultSerialPort: [ : port |
		| stream |
		stream := port asSGStream.
		self assert: (stream isKindOf: SGStream).
	 ].
]
