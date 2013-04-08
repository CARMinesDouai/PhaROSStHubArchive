Class {
	#name : #SGUsageTestSGDependant,
	#superclass : #SGTestCaseDeviceDependant,
	#traits : 'SGUsageTestTrait',
	#classTraits : 'SGUsageTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGUsageTestSGDependant >> testUsePort [
	self withDefaultSerialPort: [ : port |
		
	 ].
]
