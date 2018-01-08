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
	#superclass : #BcSingleThreadController,
	#instVars : [
		'stateMachine',
		'stopBehavior',
		'stopAction',
		'currentAction'
	],
	#category : #'BotController-Controllers'
}

{ #category : #living }
BcStateMachineController >> act [
	currentAction step
]

{ #category : #initialization }
BcStateMachineController >> initStatesAndTransitions [
	stopAction := stateMachine newStateOnEntryDo: [currentAction := stopBehavior].

]

{ #category : #initialization }
BcStateMachineController >> initialState [
	^stopAction
]

{ #category : #initialization }
BcStateMachineController >> initialize [
	super initialize.
	stateMachine := SmAutomaton new.
	self initStatesAndTransitions.
	stopBehavior := BcStop new.

]

{ #category : #living }
BcStateMachineController >> plan [
	stateMachine step
]

{ #category : #living }
BcStateMachineController >> start [
	super start.
	stateMachine initialState: self initialState.
]
