Class {
	#name : #StarGazer,
	#superclass : #Object,
	#instVars : [
		'settings',
		'gate',
		'landmarks'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
StarGazer class >> atGate: aPort [
	^ self new gate: aPort; yourself.
]

{ #category : #'as yet unclassified' }
StarGazer class >> atPortId: aPortId [
	^ self atGate:  (SGGate atPortId: aPortId).
]

{ #category : #'as yet unclassified' }
StarGazer class >> default [
	^ self atPortId: SGGate defaultPortID.
]

{ #category : #accessing }
StarGazer >> baudRate [
	^ settings at:  SGProtocol baudRate.

]

{ #category : #accessing }
StarGazer >> baudRate: aBaudRate [
	gate set:  SGProtocol baudRate with: aBaudRate.
	settings at: SGProtocol baudRate put: aBaudRate.

]

{ #category : #finalize }
StarGazer >> finalize [
	polling ifNotNil: [ polling cancel ].
]

{ #category : #accessing }
StarGazer >> gate:  aSGGate [
	gate := aSGGate asThreadsafeReference.
	aSGGate onLandMarkReading: [
		self updateWorld: (gate nextMessage asLandMark).
	].
	self loadConfiguration.

]

{ #category : #accessing }
StarGazer >> heightFix [
	^ settings at:  SGProtocol heightFix.
	
	
]

{ #category : #accessing }
StarGazer >> heightFix: aBaudRate [
	gate set:  SGProtocol heightFix with: aBaudRate.
	settings at: SGProtocol heightFix put: aBaudRate.

]

{ #category : #'initialize-release' }
StarGazer >> initialize [ 
	super initialize.
	settings := Dictionary new. 
	landmarks := Dictionary new. 
]

{ #category : #'initialize-release' }
StarGazer >> loadConfiguration [ 
	settings addAll: {
		SGProtocol version -> gate get: SGProtocol version.
		SGProtocol baudRate -> gate get: SGProtocol baudRate.
		SGProtocol heightFix -> gate get: SGProtocol heightFix.
		SGProtocol mapMode -> gate get: SGProtocol mapMode.
		SGProtocol markMode -> gate get: SGProtocol markMode.
		SGProtocol markType -> gate get: SGProtocol markType.
 	}
]

{ #category : #accessing }
StarGazer >> mapMode [
	^ settings at:  SGProtocol mapMode.
	
]

{ #category : #accessing }
StarGazer >> mapMode: aBaudRate [
	gate set:  SGProtocol mapMode with: aBaudRate.
	settings at: SGProtocol mapMode put: aBaudRate.

]

{ #category : #accessing }
StarGazer >> markMode [
	^ settings at:  SGProtocol markMode.
	
	
]

{ #category : #accessing }
StarGazer >> markMode: aBaudRate [
	gate set:  SGProtocol markMode with: aBaudRate.
	settings at: SGProtocol markMode put: aBaudRate.

]

{ #category : #accessing }
StarGazer >> markType [
	^ settings at:  SGProtocol markType.
	
	
]

{ #category : #accessing }
StarGazer >> markType: aBaudRate [
	gate set:  SGProtocol markType with: aBaudRate.
	settings at: SGProtocol markType put: aBaudRate.

]

{ #category : #update }
StarGazer >> updateWorld: aLandMark [
	landmarks at: aLandMark id ifPresent: [
		: registered | 
		landmarks at: aLandMark id put: (registered fuse: aLandMark).
	] ifAbsent:  [
		landmarks at: aLandMark id put: aLandMark.
	].
]

{ #category : #accessing }
StarGazer >> version [
	^ settings at:  SGProtocol version.
	
]
