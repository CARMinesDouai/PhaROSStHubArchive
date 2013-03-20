Class {
	#name : #SGExpectedEnvironmentTestSGDependant,
	#superclass : #SGTestCaseDeviceDependant,
	#traits : 'SGExpectedEnvironmentTestTrait',
	#classTraits : 'SGExpectedEnvironmentTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestSGDependant >> testStartCalculations [
	self withDefaultSGGate: [ : gate |
		self assert: gate startCalculations.
	].
]

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestSGDependant >> testStopCalculations [
	self withDefaultSGGate: [ : gate |
		self assert: gate stopCalculations.
	].
]
