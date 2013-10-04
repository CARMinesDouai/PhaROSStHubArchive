Trait {
	#name : #SGSwitchingStatesTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'from calculate' }
SGSwitchingStatesTestTrait >> testCalculatingCalculating [
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
SGSwitchingStatesTestTrait >> testCalculatingIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGIdleState ).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
		
		gate state switchIdle.
		self assert: (gate state isKindOf: SGIdleState).
		self deny: state = gate state.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestTrait >> testCalculatingRead [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGIdleState ).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState ).		
		self should: [ gate state switchReading ] raise: SGError.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestTrait >> testCalculatingWrite [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGIdleState ).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState ).		
		self should: [ gate state switchWriting ] raise: SGError.
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestTrait >> testIdleToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState  ).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestTrait >> testIdleToIdle [
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
SGSwitchingStatesTestTrait >> testIdleToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState ).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestTrait >> testIdleToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState ).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGWritingState ).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState ).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState ).
		gate state switchIdle.
		self assert: (gate state isKindOf: SGIdleState).
		self deny: state = gate state.
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToRead [
	self withDefaultSGGate: [ : gate | 
		| state |
		
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState ).
		state := gate state.
		gate state switchReading.
		
		self assert: (gate state isKindOf: SGReadingState ).
		self assert: gate state = state.
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState ).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState ).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState ).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculatingState ).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState ).
		gate state switchIdle.
		self assert: (gate state isKindOf: SGIdleState).
		self deny: state = gate state.
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState ).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingState ).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToWrite [
	self withDefaultSGGate: [ : gate | 
		| state |
		self assert: (gate state isKindOf: SGIdleState).
		
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState ).
		
		state := gate state.
		gate state switchWriting.
		self assert: (gate state isKindOf: SGWritingState ).
		self assert: state = gate state.
	].
]
