"
I am a window that displays a simulation.
To create an instance and have it immediatly displayed, you can either use one of the following messages:

-BGSSimulationWindow onClass:  simulationClass
-BGSSimulationWindow on: simulation
-BGSSimulationWindow onClass:  simulationClass terrainCellExtent: 5@5
-BGSSimulationWindow on: simulation terrainCellExtent: 5@5


"
Class {
	#name : #BGSSimulationWindow,
	#superclass : #BGSGridWindow,
	#instVars : [
		'simulation',
		'stepCounterMorph',
		'gridCellExtent'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'instance creation' }
BGSSimulationWindow class >> defaultGridCellExtent [ 
	^10@10
]

{ #category : #'instance creation' }
BGSSimulationWindow class >> on: aSimulation [
	^self on: aSimulation terrainCellExtent: self defaultGridCellExtent 
]

{ #category : #'instance creation' }
BGSSimulationWindow class >> on: aSimulation  terrainCellExtent: aPoint [
	^self new
		 gridCellExtent: aPoint;
		simulation: aSimulation;
		openInWorld;
		yourself
]

{ #category : #'instance creation' }
BGSSimulationWindow class >> onClass: aSimulationClass [
	^self on: aSimulationClass new
]

{ #category : #'instance creation' }
BGSSimulationWindow class >> onClass: aSimulationClass terrainCellExtent: aPoint [
	^self on: aSimulationClass new terrainCellExtent: aPoint
]

{ #category : #'initialize-release' }
BGSSimulationWindow >> addButtonsToPanel: panel [
	| stepBtn runBtn pauseBtn resetBtn inspectBtn|
	runBtn := self makeButton: 'Run' action: #run state: #isPaused.
	pauseBtn := self makeButton: 'Pause' action: #pause state: #isRunning.
	stepBtn := self makeButton: 'Step' action: #stepIfPaused state: #isPaused.
	resetBtn := self makeButton: 'Reset' action: #resetSimulation state: #canResetSimulation target: self. 
	inspectBtn := self makeButton: 'Inspect' action: #inspect state: nil. 
	{inspectBtn. resetBtn. pauseBtn. runBtn. stepBtn} do: [:button|
		panel addMorph: button]

]

{ #category : #'initialize-release' }
BGSSimulationWindow >> addCountersToPanel: panel [ 
	| stepsView |
	self stepCounterMorph: (LabelMorph contents: '0').
	stepsView := self wrapMorph: self stepCounterMorph andAddLabel: 'Steps:'. 
	panel 
		addMorph: stepsView
		fullFrame: (LayoutFrame 
				fractions: (0 @ 0 corner: 1 @ 0)
				offsets: (4 @ 4 corner: -8 @ 44))
]

{ #category : #'initialize-release' }
BGSSimulationWindow >> buttonsWidth [
	^150
]

{ #category : #testing }
BGSSimulationWindow >> canResetSimulation [
	^self simulation isRunning not
]

{ #category : #displaying }
BGSSimulationWindow >> displayGridView [
	| newExtent deltaWidth board deltaHeight |
	board := AlignmentMorph newRow.
	board extent: self gridView extent + (self buttonsWidth @ 0).
	board addMorphBack: self newControlPanelMorph.
	board addMorphBack: self gridView.
	deltaWidth := 2 * (self borderWidth + self class borderWidth).
	deltaHeight := 2 * (self borderWidth + self class borderWidth) + self labelHeight.
	newExtent := board fullBounds extent + (deltaWidth @ deltaHeight).
	self extent: newExtent.
	self addMorph: board frame: (0 @ 0 extent: 1 @ 1)
]

{ #category : #accessing }
BGSSimulationWindow >> gridCellExtent [
	^ gridCellExtent
]

{ #category : #accessing }
BGSSimulationWindow >> gridCellExtent: anObject [
	gridCellExtent := anObject
]

{ #category : #'initialize-release' }
BGSSimulationWindow >> makeButton:  aString action: actionSelector state: stateSelector [
	 ^self makeButton:  aString action: actionSelector state: stateSelector target: self simulation
		
]

{ #category : #'initialize-release' }
BGSSimulationWindow >> makeButton:  aString action: actionSelector state: stateSelector target: target [
	| btn labelMorph |
	btn := PluggableButtonMorph 
		on: target
		getState: stateSelector
		action: actionSelector.
	labelMorph := StringMorph contents: aString.
	labelMorph emphasis: 1.
	btn
		label: labelMorph;
		useRoundedCorners;
		hResizing: #spaceFill;
		onColor: self onButtonColor offColor: self offButtonColor;
		borderWidth: 2;
		borderColor: #raised.
	btn label color: Color darkGray.
	btn extent: self buttonsWidth @ 50. "50 is not an important value since it will be changed by the enclosing alignment morph"
	^btn
]

{ #category : #'initialize-release' }
BGSSimulationWindow >> newControlPanelMorph [
	| panel |
	panel := AlignmentMorph newColumn.
	panel color: Color darkGray.
	panel extent: self buttonsWidth @ self gridView extent y.
	self addCountersToPanel: panel.
	self addButtonsToPanel: panel.
	^ panel
]

{ #category : #'initialize-release' }
BGSSimulationWindow >> offButtonColor [ 
	^Color white
]

{ #category : #'initialize-release' }
BGSSimulationWindow >> onButtonColor [ 
	^Color green 
]

{ #category : #testing }
BGSSimulationWindow >> resetSimulation [
	| shouldReset |
	self canResetSimulation ifFalse: [^self].
	shouldReset := self proceed: 'Do you really want to reset the simulation?' title: 'Reset simulation?' .
	shouldReset ifFalse: [^self].
	self simulation reset
]

{ #category : #accessing }
BGSSimulationWindow >> simulation [
	^ simulation
]

{ #category : #accessing }
BGSSimulationWindow >> simulation: newSimulation [
	simulation := newSimulation.
	simulation addDependent: self.
	self displayGrid: simulation terrain cellExtent: self gridCellExtent.
	self update: newSimulation
]

{ #category : #displaying }
BGSSimulationWindow >> simulationStatusString [
	self simulation autoStopConditionReached ifTrue: [^'Stop condition reached'].
	self simulation isPaused ifTrue: [^'Paused'].
	^'Running'
]

{ #category : #accessing }
BGSSimulationWindow >> stepCounterMorph [
	^ stepCounterMorph
]

{ #category : #accessing }
BGSSimulationWindow >> stepCounterMorph: anObject [
	stepCounterMorph := anObject
]

{ #category : #displaying }
BGSSimulationWindow >> update: anObject [
	super update: anObject.
	self setLabel: self simulation name, ' - ', self simulationStatusString.
	self stepCounterMorph contents: self simulation stepCount printString.

]

{ #category : #'initialize-release' }
BGSSimulationWindow >> wrapMorph: aMorph andAddLabel: aString [
    "creates a wrapping panel for aMorph with  a label above it"
    | column strM |
    column := AlignmentMorph newColumn
                wrapCentering: #topLeft;
                cellPositioning: #topLeft;
                hResizing: #spaceFill;
                vResizing: #shrinkWrap;
                borderWidth: 2;
                layoutInset: 5;
                color: Color transparent;
                useRoundedCorners;
                borderStyle: (BorderStyle complexAltInset width: 2).
    column addMorph: aMorph.
    strM := StringMorph contents: aString.
    strM color: Color veryVeryLightGray.
    column addMorph: strM.
    ^ column 
]
