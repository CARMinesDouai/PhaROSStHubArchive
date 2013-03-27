Class {
	#name : #SGSwitchingStatesTestSGDependant,
	#superclass : #SGTestCaseDeviceDependant,
	#traits : 'SGSwitchingStatesTestTrait',
	#classTraits : 'SGSwitchingStatesTestTrait classTrait',
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'from calculate' }
SGSwitchingStatesTestSGDependant >> testCalculatingCalculating [
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
SGSwitchingStatesTestSGDependant >> testCalculatingIdle [
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
SGSwitchingStatesTestSGDependant >> testCalculatingRead [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).		
		self should: [ gate state switchReading ] raise: SGError.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestSGDependant >> testCalculatingWrite [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).		
		self should: [ gate state switchWriting ] raise: SGError.
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestSGDependant >> testIdleToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState ).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestSGDependant >> testIdleToIdle [
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
SGSwitchingStatesTestSGDependant >> testIdleToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestSGDependant >> testIdleToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestSGDependant >> testReadToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestSGDependant >> testReadToIdle [
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
SGSwitchingStatesTestSGDependant >> testReadToRead [
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
SGSwitchingStatesTestSGDependant >> testReadToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestSGDependant >> testWriteToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestSGDependant >> testWriteToIdle [
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
SGSwitchingStatesTestSGDependant >> testWriteToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestSGDependant >> testWriteToWrite [
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
