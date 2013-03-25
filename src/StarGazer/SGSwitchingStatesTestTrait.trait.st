Trait {
	#name : #SGSwitchingStatesTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'from calculate' }
SGSwitchingStatesTestTrait >> testCalculatingCalculating [
	self withDefaultSGGate: [ : gate | 
		| state |
		
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating).
		state := gate state.
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating).
		self assert:  state = gate state.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestTrait >> testCalculatingIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating).
		
		gate state switchIdle.
		self assert: (gate state isKindOf: SGStopped).
		self deny: state = gate state.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestTrait >> testCalculatingRead [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating).		
		self should: [ gate state switchReading ] raise: SGError.
	].
]

{ #category : #'from calculate' }
SGSwitchingStatesTestTrait >> testCalculatingWrite [
	self withDefaultSGGate: [ : gate | 
		
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating).		
		self should: [ gate state switchWriting ] raise: SGError.
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestTrait >> testIdleToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating ).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestTrait >> testIdleToIdle [
	self withDefaultSGGate: [ : gate | 
		| idle |
		
		idle := gate state.
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchIdle .
		self assert: (gate state isKindOf: SGStopped).
		self assert: idle = gate state.
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestTrait >> testIdleToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingParameters).
	].
]

{ #category : #'from idle' }
SGSwitchingStatesTestTrait >> testIdleToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchWriting.
		self assert: (gate state isKindOf: SGSettingParameters).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGStopped).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingParameters).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating).
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGStopped).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingParameters).
		gate state switchIdle.
		self assert: (gate state isKindOf: SGStopped).
		self deny: state = gate state.
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToRead [
	self withDefaultSGGate: [ : gate | 
		| state |
		
		self assert: (gate state isKindOf: SGStopped).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingParameters).
		state := gate state.
		gate state switchReading.
		
		self assert: (gate state isKindOf: SGReadingParameters).
		self assert: gate state = state.
	].
]

{ #category : #'from read' }
SGSwitchingStatesTestTrait >> testReadToWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGStopped).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingParameters).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGSettingParameters).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToCalculating [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGStopped).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGSettingParameters).
		gate state switchCalculating.
		self assert: (gate state isKindOf: SGCalculating).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToIdle [
	self withDefaultSGGate: [ : gate | 
		| state |
		state := gate state.
		self assert: (gate state isKindOf: SGStopped).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGSettingParameters).
		gate state switchIdle.
		self assert: (gate state isKindOf: SGStopped).
		self deny: state = gate state.
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGStopped).
		gate state switchWriting.
		self assert: (gate state isKindOf: SGSettingParameters).
		gate state switchReading.
		self assert: (gate state isKindOf: SGReadingParameters).
	].
]

{ #category : #'from write' }
SGSwitchingStatesTestTrait >> testWriteToWrite [
	self withDefaultSGGate: [ : gate | 
		| state |
		self assert: (gate state isKindOf: SGStopped).
		
		gate state switchWriting.
		self assert: (gate state isKindOf: SGSettingParameters).
		
		state := gate state.
		gate state switchWriting.
		self assert: (gate state isKindOf: SGSettingParameters).
		self assert: state = gate state.
	].
]
