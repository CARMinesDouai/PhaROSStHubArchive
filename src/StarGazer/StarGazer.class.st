Class {
	#name : #StarGazer,
	#superclass : #Object,
	#instVars : [
		'settings',
		'mode',
		'gate',
		'heightFix',
		'baudRate',
		'markHeight',
		'markMode',
		'markType',
		'refID',
		'idNum',
		'version',
		'onLandMarkRead'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #constructors }
StarGazer class >> atGate: aGate  forMode: aMode [

	^ self new gate: aGate;  mode: aMode; yourself.
]

{ #category : #constructors }
StarGazer class >> atPortId: aPortId  withInitialState: aStateClass forMode: aMode [ 
	| gate |
	gate :=  (SGGate atPortId: aPortId).
	gate state: (aStateClass for: gate).
	^ self atGate:  gate  forMode: aMode
]

{ #category : #constructors }
StarGazer class >> configureInstance [ 
	| def |
	" Instance for configuration use "
	def := self default:[:w| ].
	def gate configure.
	^ def.
]

{ #category : #constructors }
StarGazer class >> default [

	" The default configuration open ttyUSB0, is already able to scan and in stand alone mode (each landmark give the data needed )"

	^ self default:[  self halt: ' you should define a callback ']. 
]

{ #category : #constructors }
StarGazer class >> default: aCallbackForMeasures [

	" The default configuration open ttyUSB0, is already able to scan and in stand alone mode (each landmark give the data needed )"
	| def |
	def := ( self atPortId: SGGate defaultPortID
		    withInitialState: SGCalculatingState 
		    forMode: (SGStandAloneMode new callback: aCallbackForMeasures ;yourself)) startMeasurements; yourself  . 
	"def gate configure."
	^ def .
]

{ #category : #thresholds }
StarGazer class >> differentialPositionThreshold [
	^ 20."CM"
]

{ #category : #thresholds }
StarGazer class >> differentialRotationThreshold [
	^ 20 degreesToRadians.
]

{ #category : #constructors }
StarGazer class >> mapBuilding [
	|def |
	" The default configuration open ttyUSB0, is already able to scan and in stand alone mode (each landmark give the data needed )"


	def :=  self atPortId: SGGate defaultPortID
		    withInitialState: SGCalculatingState 
		    forMode: (SGMapMode new).
		
	def gate configure.
	
	^ def.
]

{ #category : #position }
StarGazer >> announceNewPose: aPose fromSystem: aLandMark [
	onLandMarkRead cull: aPose cull: aLandMark.
]

{ #category : #accessing }
StarGazer >> baudRate [
	^ baudRate value.

]

{ #category : #accessing }
StarGazer >> baudRate: aBaudRate [
	baudRate value: aBaudRate.
	

]

{ #category : #finalize }
StarGazer >> finalize [
	gate finalize.
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
	self initializeBindings.
]

{ #category : #accessing }
StarGazer >> heightFix [
	^ heightFix value.
	
]

{ #category : #accessing }
StarGazer >> heightFix: yesOrNo [
	heightFix value: yesOrNo

]

{ #category : #accessing }
StarGazer >> idNum [
	^  idNum value
]

{ #category : #accessing }
StarGazer >> idNum: anAmmountOfLandmarks [ 
	idNum value: anAmmountOfLandmarks.
]

{ #category : #'initialize-release' }
StarGazer >> initialize [ 
	super initialize.
	settings := Dictionary new. 
	mode := SGMapMode new.
	
	
	
]

{ #category : #'initialize-release' }
StarGazer >> initializeBindings [
	baudRate :=   SGBind bind: SGProtocol baudRate  trought: gate.
	heightFix := SGBind bind: SGProtocol heightFix  trought: gate.
	idNum := SGBind bind: SGProtocol idNum  trought: gate.
	markHeight := SGBind bind: SGProtocol markHeight  trought: gate.
	markMode := SGBind bind: SGProtocol markMode  trought: gate.
	markType := SGBind bind: SGProtocol markType  trought: gate.
	refID := SGBind bind: SGProtocol refID  trought: gate.
		 
	 version := SGBindReadOnly bind: SGProtocol version trought: gate.
]

{ #category : #accessing }
StarGazer >> markHeight [
	^  markHeight value.
	
	
]

{ #category : #accessing }
StarGazer >> markHeight: aHeightInCm [
	markHeight value: 	aHeightInCm
	
]

{ #category : #accessing }
StarGazer >> markMode [
	^ markMode value. 
	
	
]

{ #category : #accessing }
StarGazer >> markMode: aMode [
	markMode value: aMode.

]

{ #category : #accessing }
StarGazer >> markType [
	^ markType value.
	
	
]

{ #category : #accessing }
StarGazer >> markType: aBaudRate [
	markType value: aBaudRate.
]

{ #category : #accessing }
StarGazer >> mode [
	^ mode
]

{ #category : #accessing }
StarGazer >> mode: aMode [ 
	mode := aMode
]

{ #category : #position }
StarGazer >> onLandMarkRead:  aBlock [
	onLandMarkRead := aBlock.
]

{ #category : #accessing }
StarGazer >> refID [
	^ refID value.
	
]

{ #category : #accessing }
StarGazer >> refID: aRefID [ 
	refID value: aRefID 
]

{ #category : #accessing }
StarGazer >> settingsAt: aSettingName [
	^ settings at: aSettingName ifAbsentPut: [
		 (gate get: aSettingName) value.
	  ].
]

{ #category : #build }
StarGazer >> startMapBuilding [
	
	mode withZeroAt:  (SGLandMarkMeasure id: self refID pose: SGPose zero ).
	
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
StarGazer >> updateWorld: aLandMarkMeasure [
	mode updateWorld: aLandMarkMeasure.

	"self announceNewPose: (mode absolutePoseFor: aLandMarkMeasure) fromSystem: mode currentCoordinateSystem. 
	"
]

{ #category : #accessing }
StarGazer >> version [
	^ version value.
	
]
