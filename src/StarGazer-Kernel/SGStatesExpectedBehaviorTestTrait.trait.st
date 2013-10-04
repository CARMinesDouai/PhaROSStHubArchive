Trait {
	#name : #SGStatesExpectedBehaviorTestTrait,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestTrait >> testFlowIdleCalculatingIdle [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate startCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	
		gate stopCalculating.
		self assert: (gate state isKindOf: SGIdleState).
	].
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestTrait >> testFlowIdleCalculatingIdleRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate startCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	
		gate stopCalculating.
		self assert: (gate state isKindOf: SGIdleState).
		
		gate get: SGProtocol version.
		self assert: (gate state isKindOf: SGReadingState).
	].
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestTrait >> testFlowIdleCalculatingIdleWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate startCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	
		gate stopCalculating.
		self assert: (gate state isKindOf: SGIdleState).
		
		gate set: SGProtocol markMode with: 'Alone'.
		self assert: (gate state isKindOf: SGWritingState).
	].
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestTrait >> testFlowIdleCalculatingRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate startCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	
		self should: [ gate get: SGProtocol version.]  raise: SGError.
	].
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestTrait >> testFlowIdleCalculatingWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate startCalculating.
		self assert: (gate state isKindOf: SGCalculatingState).
	
		self should: [ gate set: SGProtocol markMode with: 'Alone'. ]  raise: SGError.
	].
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestTrait >> testFlowIdleReadWriteRead [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate get: SGProtocol version.
		self assert: (gate state isKindOf: SGReadingState).
		
		gate set: SGProtocol markMode with: 'Alone'.
		self assert: (gate state isKindOf: SGWritingState).
		
		gate get: SGProtocol version.
		self assert: (gate state isKindOf: SGReadingState).
	].
]

{ #category : #'expected flowing' }
SGStatesExpectedBehaviorTestTrait >> testFlowIdleWriteReadWrite [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		
		gate set: SGProtocol markMode with: 'Alone'.
		self assert: (gate state isKindOf: SGWritingState).
		
		gate get: SGProtocol version.
		self assert: (gate state isKindOf: SGReadingState).
		
		gate set: SGProtocol markMode with: 'Alone'.
		self assert: (gate state isKindOf: SGWritingState).
	].
]

{ #category : #'calculating state' }
SGStatesExpectedBehaviorTestTrait >> testHasMessageFalseAtCalculatingStateWithoutReading [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate startCalculating.
		self deny: gate hasMessages.
	].


]

{ #category : #'idle state' }
SGStatesExpectedBehaviorTestTrait >> testHasMessageFalseAtIdleState [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		self deny: gate hasMessages.
	].
]

{ #category : #'reading state' }
SGStatesExpectedBehaviorTestTrait >> testHasMessageFalseAtReadingState [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self deny: gate hasMessages.
	].
]

{ #category : #'writing state' }
SGStatesExpectedBehaviorTestTrait >> testHasMessageFalseAtWritingState [
	
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self deny: gate hasMessages.
	].
]

{ #category : #'calculating state' }
SGStatesExpectedBehaviorTestTrait >> testHasMessageTrueAtCalculatingStateWithReading [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate startCalculating.
		
		self assert: (gate state isKindOf: SGCalculatingState).
		self waitForUser: 'Please, make the stargazer to read a landmark and then press proceed.'.
		self assert: gate hasMessages.
	].


]

{ #category : #'idle state' }
SGStatesExpectedBehaviorTestTrait >> testNextMessageExplodeAtIdleState [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		self should: [  gate nextMessage  ] raise: SGError.
	].
]

{ #category : #'reading state' }
SGStatesExpectedBehaviorTestTrait >> testNextMessageExplodeAtReadingState [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchReading.
		self should: [  gate nextMessage  ] raise: SGError.
	].
]

{ #category : #'writing state' }
SGStatesExpectedBehaviorTestTrait >> testNextMessageExplodeAtWritingState [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate state switchWriting.
		self should: [  gate nextMessage  ] raise: SGError.
	].
]

{ #category : #'calculating state' }
SGStatesExpectedBehaviorTestTrait >> testNextMessageGetSomethingAtCalculatingStateWithReading [
	self withDefaultSGGate: [ : gate | 
		self assert: (gate state isKindOf: SGIdleState).
		gate startCalculating.
		
		self assert: (gate state isKindOf: SGCalculatingState).
		self waitForUser: 'Please, make the stargazer to read a landmark and then press proceed.'.
		self assert: gate nextMessage ~= SGMessage NoMessage.
	].


]
