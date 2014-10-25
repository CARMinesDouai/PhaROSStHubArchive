"
A SmAutomaton is a finite state machine. States are connected by transitions. Each time an automaton receives the step message, it checks conditions attached to outgoing transitions from the current state. Whenever a condition of a transition is true, the machine switches to the target state of the transition.

Instance Variables
	currentState:		<SmState>

currentState
	- the last state to be activated


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
	aState automaton: self.
	self currentState: aState.
	aState activate.

]

{ #category : #stepping }
SmAutomaton >> step [
	self currentState step
]
