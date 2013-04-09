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
	^ self settingsAt:  SGProtocol baudRate.

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
StarGazer >> gate [ 
	^ gate
]

{ #category : #accessing }
StarGazer >> gate:  aSGGate [
	gate := aSGGate asThreadsafeReference.
	aSGGate onLandMarkReading: [
		self updateWorld: (gate nextMessage asLandMark).
	].

]

{ #category : #accessing }
StarGazer >> heightFix [
	^ self settingsAt: SGProtocol heightFix.
	
	
]

{ #category : #accessing }
StarGazer >> heightFix: aBaudRate [
	gate set:  SGProtocol heightFix with: aBaudRate.
	settings at: SGProtocol heightFix put: aBaudRate.

]

{ #category : #accessing }
StarGazer >> idNum [
	^ self settingsAt: SGProtocol idNum.
]

{ #category : #accessing }
StarGazer >> idNum: anAmmountOfLandmarks [ 
	gate set:  SGProtocol idNum   with: anAmmountOfLandmarks.
	settings at: SGProtocol idNum   put: anAmmountOfLandmarks.

]

{ #category : #'initialize-release' }
StarGazer >> initialize [ 
	super initialize.
	settings := Dictionary new. 
	landmarks := Dictionary new. 
]

{ #category : #accessing }
StarGazer >> mapMode [
	^ self settingsAt:  SGProtocol mapMode.
	
]

{ #category : #accessing }
StarGazer >> mapMode: aMapMode [
	gate command:  SGProtocol mapMode with: aMapMode.
	settings at: SGProtocol mapMode put: aMapMode.

]

{ #category : #accessing }
StarGazer >> markMode [
	^ self settingsAt:  SGProtocol markMode.
	
	
]

{ #category : #accessing }
StarGazer >> markMode: aBaudRate [
	gate command:  SGProtocol markMode with: aBaudRate.
	settings at: SGProtocol markMode put: aBaudRate.

]

{ #category : #accessing }
StarGazer >> markType [
	^ self settingsAt:  SGProtocol markType.
	
	
]

{ #category : #accessing }
StarGazer >> markType: aBaudRate [
	gate set:  SGProtocol markType with: aBaudRate.
	settings at: SGProtocol markType put: aBaudRate.

]

{ #category : #accessing }
StarGazer >> refID [
	^ self settingsAt:  SGProtocol refID.
	
]

{ #category : #accessing }
StarGazer >> refID: aRefID [ 
	gate set:  SGProtocol refID  with: aRefID.
	settings at: SGProtocol refID  put: aRefID.

]

{ #category : #accessing }
StarGazer >> settingsAt: aSettingName [
	^ settings at: aSettingName ifAbsentPut: [
		 gate get: aSettingName.
	  ].
]

{ #category : #build }
StarGazer >> startMapBuilding [
	^ gate startMapBuilding.
]

{ #category : #'initialize-release' }
StarGazer >> startMeasurements [
	gate startCalculating.
]

{ #category : #'initialize-release' }
StarGazer >> stopMeasurements [
	gate stopCalculating.
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
	^ self settingsAt:  SGProtocol version.
	
]
