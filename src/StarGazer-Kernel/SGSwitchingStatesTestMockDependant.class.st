Class {
	#name : #SGSwitchingStatesTestMockDependant,
	#superclass : #SGTestCaseMock,
	#traits : 'SGSwitchingStatesTestTrait',
	#classTraits : 'SGSwitchingStatesTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'from read' }
SGSwitchingStatesTestMockDependant >> openSerialPort [ 
	^ serialMock ifNil: [serialMock := SGDummySerialMock new] ifNotNil: [ serialMock ].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestMockDependant >> testCalculatingCalculating [
	self withDefaultSGGate: [ : gate | 
		| state |
		
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
		state := gate state.
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
		self assert:  state = gate state.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestMockDependant >> testCalculatingIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
		
		gate state switchIdle.
		self assert: (gate state isKindOf: SGIdleState).
		self deny: state = gate state.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestMockDependant >> testCalculatingRead [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).		
		self should: [ gate state switchReading ] raise: SGError.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestMockDependant >> testCalculatingWrite [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).		
		self should: [ gate state switchWriting ] raise: SGError.
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestMockDependant >> testIdleToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState ).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestMockDependant >> testIdleToIdle [
	self withDefaultSGGate: [ : gate | 
		| idle |
		
		idle := gate state.
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchIdle .
		self assert: (gate state isKindOf: SGIdleState).
		self assert: idle = gate state.
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestMockDependant >> testIdleToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestMockDependant >> testIdleToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestMockDependant >> testReadToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestMockDependant >> testReadToIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
		gate state switchIdle.
		self assert: (gate state isKindOf: SGIdleState).
		self deny: state = gate state.
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestMockDependant >> testReadToRead [
	self withDefaultSGGate: [ : gate | 
		| state |
		
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
		state := gate state.
		gate state switchReading.
		
		self assert: (gate state isKindOf: SGReadingState).
		self assert: gate state = state.
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestMockDependant >> testReadToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestMockDependant >> testWriteToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestMockDependant >> testWriteToIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
		gate state switchIdle.
		self assert: (gate state isKindOf: SGIdleState).
		self deny: state = gate state.
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestMockDependant >> testWriteToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestMockDependant >> testWriteToWrite [
	self withDefaultSGGate: [ : gate | 
		| state |
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
		
		state := gate state.
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
		self assert: state = gate state.
	].
]
