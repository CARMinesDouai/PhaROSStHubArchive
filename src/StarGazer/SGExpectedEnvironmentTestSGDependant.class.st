Class {
	#name : #SGExpectedEnvironmentTestSGDependant,
	#superclass : #SGTestCaseDeviceDependant,
	#traits : 'SGExpectedEnvironmentTestTrait',
	#classTraits : 'SGExpectedEnvironmentTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestSGDependant >> testOpenDefaultSerialPort [
	self withDefaultSerialPort: [: port  | 
		port nextPutAll: '~$Version`'.
		self halt: port readString.
		self assert: port readString isString  description: ' error reading from port. Assure that you have privileges to read / write the default port ' 
	].

]
