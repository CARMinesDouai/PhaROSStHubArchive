"
I am a state machine based controller. The state machine takes care of the planning. It selects one state that meets the current context. Each state set the current action upon entry.  The current action  drives the robot by issuing commands to the actuators.

    Instance Variables
	stateMachine:		<SmAutomaton>
	stopAction:		<BcAction>
	stopState:		<SmState>

I know:
-the stopAction: That is the action that makes the robot stop moving.
-the stopState: That is state that sets the currentAction to the stopAction.

API
-newStateSelectingAction: actionBlock
Create states which do set the current action upon entry i.e. when the state machine selects  the state, the current action is set . The actionBlock parameter value is the action that is set to be the current one.

I am abstract. Subclasses are likely to override methods: 
-initStatesAndTransitions 
Creates states and transitions to those states. When reached, any state should simply set the currentAction.
-initialState
Defines the initial state of the state machine, set each time the controller is started (message start). By default, this is the stopState

"
Class {
	#name : #BcStateMachineController,
	#superclass : #BcSensePlanActController,
	#instVars : [
		'stateMachine',
		'stopState',
		'stopAction'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'initialize-release' }
BcStateMachineController >> initStatesAndTransitions [
	stopState := self newStateSelectingAction: [stopAction].

]

{ #category : #'initialize-release' }
BcStateMachineController >> initialState [
	^stopState
]

{ #category : #'initialize-release' }
BcStateMachineController >> initialize [
	super initialize.
	stopAction := self newAction: BcStop.
	stateMachine := SmAutomaton new.
	self initStatesAndTransitions.

]

{ #category : #'initialize-release' }
BcStateMachineController >> newStateSelectingAction: actionBlock [
	^stateMachine newStateDoing: [ self currentAction: actionBlock value ]
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
