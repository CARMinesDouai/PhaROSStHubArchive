Trait {
	#name : #SGExpectedEnvironmentTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestTrait >> testOpenDefaultSerialPort [
	self withDefaultSerialPort: [: port  | 
		self assert: port readString isString  description: ' error reading from port. Assure that you have privileges to read / write the default port ' 
	].

]

{ #category : #'as yet unclassified' }
SGExpectedEnvironmentTestTrait >> testVersion [
	self withDefaultSGGate: [ : gate |
		self assert: ((gate get: SGProtocol version) = '2.0'). 
	].
]
