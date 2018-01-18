"
I am a state machine based controller with reified actions. The state machine takes care of the planning. It selects one action that meets the current context. Only the selected action is capable of driving the robot by issues commands to the actuators.

    Instance Variables
	currentAction:		<BcAction>
	stateMachine:		<SmAutomaton>
	stopAction:		<BcAction>
	stopState:		<SmState>

I know:
-the currentAction that is the action selected by the latest planning. It is performed when it's time to act.
-the stopState: That is state that sets the currentAction to the stopAction.

I am abstract. Subclasses are likely to override methods: 
-initStatesAndTransitions 
Creates states and transitions to those states. When reached, any state should simply set the currentAction.
-initialState
Defines the initial state of the state machine, set each time the controller is started (message start)

"
Class {
	#name : #BcStateMachineController,
	#superclass : #BcSensePlanActController,
	#instVars : [
		'stateMachine',
		'currentAction',
		'stopState',
		'stopAction'
	],
	#category : #'BotController-Controllers'
}

{ #category : #living }
BcStateMachineController >> act [
	currentAction perform
]

{ #category : #initialization }
BcStateMachineController >> initStatesAndTransitions [
	stopState := stateMachine newStateOnEntryDo: [currentAction := stopAction].

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
	stopAction := self newAction: BcStop.

]

{ #category : #living }
BcStateMachineController >> plan [
	stateMachine step
]

{ #category : #living }
BcStateMachineController >> start [
	stateMachine initialState: self initialState.
	super start.

]
