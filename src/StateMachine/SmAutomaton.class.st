"
A SmAutomaton is a finite state machine. States are connected by transitions. Each time an automaton receives the step message, it checks conditions attached to outgoing transitions from the current state. Whenever a condition of a transition is true, the machine switches to the target state of the transition.

Example
	automaton := SmAutomaton new.
	initialState := SmLoggedState new.
	automaton initialState: initialState.
	newState := SmLoggedState new.
	flag := false.
	initialState transitionTo: newState when: [flag = true].
	flag := true.
	automaton step.
	automaton currentState = newState. ""Should be true""

Instance Variables
	currentState:		<SmState>

currentState
	- the last state to be enabled


"
Class {
	#name : #SmAutomaton,
	#superclass : #Object,
	#instVars : [
		'currentState'
	],
	#category : #StateMachine
}

{ #category : #accessing }
SmAutomaton >> currentState [
	^ currentState
]

{ #category : #accessing }
SmAutomaton >> currentState: aState [
	currentState := aState

]

{ #category : #'initialize-release' }
SmAutomaton >> initialState: aState [
	self currentState: aState.
	aState enable.

]

{ #category : #'creating states' }
SmAutomaton >> newState [
	^SmState automaton: self
]

{ #category : #'creating states' }
SmAutomaton >> newStateOnEntryDo: aBlockClosure [ 
	^self newStateOnEntryDo: aBlockClosure onExitDo: [].
]

{ #category : #'creating states' }
SmAutomaton >> newStateOnEntryDo: entryActionBlock onExitDo: exitActionBlock [
	^self newState
		entryActionBlock: entryActionBlock;
		exitActionBlock: exitActionBlock;
		yourself

]

{ #category : #stepping }
SmAutomaton >> step [
	self currentState step
]
