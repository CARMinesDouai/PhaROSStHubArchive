Trait {
	#name : #SGExpectedEnvironmentTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> assertExpectedParameter: aParameterName  with: aValue [ 
	self withDefaultSGGate: [ : gate |
		| val |
		val := gate get: aParameterName .
		self assert: val value = aValue.
	].
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> assertExpectedParameter: aParameterName  withBlock: aBlock [ 
	self withDefaultSGGate: [ : gate |
		| val |
		val := gate get: aParameterName .
		self assert:( aBlock value: val value).
	].
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testBaudRate [
	self assertExpectedParameter: SGProtocol baudRate  with: '9600'.
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testHeightCalc [
	self assertExpectedParameter: SGProtocol heightCalc with: ''.

]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testHeightFix [
	self assertExpectedParameter: SGProtocol heightFix with: 'Yes'.
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testIDNum [
	self assertExpectedParameter: SGProtocol idNum with: '4'.

]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testMapMode [
	self assertExpectedParameter: SGProtocol mapMode with: 'Stop'.
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testMarkHeight [
	self assertExpectedParameter: SGProtocol markHeight  withBlock: [: val | val asInteger >= 0 ].

]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testMarkMode [
	self assertExpectedParameter: SGProtocol markMode with: 'Map'.
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testMarkType [
	self assertExpectedParameter:  SGProtocol markType with:  'HLD1S'.
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testReadingFromGate [

	self withDefaultSGGate:  [: gate | 
		| message |
		gate startCalculating.
		self waitForUser: 'Please, put a landmark near the stargazer to proceed with the test'.
		
		message := gate nextMessage.
		self assert: message ~= SGMessage NoMessage.
	]
]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testRefID [
	self assertExpectedParameter: SGProtocol refID with: '2'.

]

{ #category : #'environmental tests' }
SGExpectedEnvironmentTestTrait >> testVersion [
	self assertExpectedParameter: SGProtocol version with: '2.1101.18'.
	

]
