"
I am a controller based on a state machine. The initial state is stop.
Subclasses can extend and adapt the state machine by redefining methods:
-iniitStateAndTransitions
-initialState

The initial state is set only once the controller is started (message start). This is because the initial state might perform some action on the body. 
The default initial state (stopState) does set the body's speed to 0.

    Instance Variables
	stateMachine:		<SmAutomaton>
	stopState:		<SmState>



"
Class {
	#name : #BcStateMachineController,
	#superclass : #BcController,
	#instVars : [
		'stateMachine',
		'stopState'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcStateMachineController >> initStatesAndTransitions [
	stopState := stateMachine newStateDoing: [self body stop].

]

{ #category : #initialization }
BcStateMachineController >> initialState [
	^stopState
]

{ #category : #initialization }
BcStateMachineController >> initialize [
	super initialize.
	stateMachine := SmAutomaton new.
	self initStatesAndTransitions.

]

{ #category : #living }
BcStateMachineController >> start [
	"Setting the initial state might trigger some actions on the body such as setting the speed"
	stateMachine initialState: self initialState.
]
