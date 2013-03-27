Trait {
	#name : #SGExpectedEnvironmentTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #d }
SGExpectedEnvironmentTestTrait >> assertExpectedParameter: aParameterName  with: aValue [ 
	self withDefaultSGGate: [ : gate |
		| val |
		val := gate get: aParameterName .
		self assert: val value = aValue.
	].
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> assertExpectedParameter: aParameterName  withBlock: aBlock [ 
	self withDefaultSGGate: [ : gate |
		| val |
		val := gate get: aParameterName .
		self assert:( aBlock value: val value).
	].
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testBaudRate [
	self assertExpectedParameter: SGProtocol baudRate  with: '9600'.
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testHeightCalc [
	self assertExpectedParameter: SGProtocol heightCalc with: ''.

]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testHeightFix [
	self assertExpectedParameter: SGProtocol heightFix with: 'No'.
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testIDNum [
	self assertExpectedParameter: SGProtocol idNum with: '3'.

]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testMapMode [
	self assertExpectedParameter: SGProtocol mapMode with: 'Stop'.
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testMarkHeight [
	self assertExpectedParameter: SGProtocol markHeight  withBlock: [: val | val asInteger >= 0 ].

]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testMarkMode [
	self assertExpectedParameter: SGProtocol markMode with: 'Alone'.
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testMarkType [
	self assertExpectedParameter:  SGProtocol markType with:  'HLD1S'.
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testReadingFromGate [

	self withDefaultSGGate:  [: gate | 
		| message |
		gate startCalculating.
		self waitForUser: 'Please, put a landmark near the stargazer to proceed with the test'.
		
		message := gate nextMessage.
		self assert: message ~= SGMessage NoMessage.
	]
]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testRefID [
	self assertExpectedParameter: SGProtocol refID with: '32'.

]

{ #category : #d }
SGExpectedEnvironmentTestTrait >> testVersion [
	self assertExpectedParameter: SGProtocol version with: '2.1101.18'.
	

]
