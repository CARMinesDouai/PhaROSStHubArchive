Class {
	#name : #BcStateMachineController,
	#superclass : #BcController,
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
