Class {
	#name : #SmAutomataTest,
	#superclass : #TestCase,
	#instVars : [
		'initialState',
		'automaton'
	],
	#category : #StateMachine
}

{ #category : #testing }
SmAutomataTest >> setUp [
	super setUp.
	automaton := SmAutomaton new.
	initialState := SmState new.
	automaton initialState: initialState 
]

{ #category : #testing }
SmAutomataTest >> testAutomatonAtInitialState [
	self assert: automaton currentState equals: initialState
]

{ #category : #testing }
SmAutomataTest >> testChangeStateWhenTransitionConditionIsVerified [
	|newState flag|
	newState := SmState new.
	flag := false.
	initialState transitionTo: newState when: [flag = true].
	flag := true.
	automaton step.
	self assert: automaton currentState equals: newState
]

{ #category : #testing }
SmAutomataTest >> testEntryActionOfInitialStatePerformed [
	|newState entryActionPeformed|
	entryActionPeformed := false.
	newState := SmState entryAction: [ entryActionPeformed := true ].
	automaton initialState: newState.
	self assert: entryActionPeformed
]

{ #category : #testing }
SmAutomataTest >> testStateEntryActionPerformed [
	|newState entryActionPeformed|
	entryActionPeformed := false.
	newState := SmState entryAction: [ entryActionPeformed := true ].
	initialState transitionTo: newState when: [true].
	automaton step.
	self assert: entryActionPeformed
]

{ #category : #testing }
SmAutomataTest >> testStateExitActionPerformed [
	|newState exitActionPeformed|
	exitActionPeformed := false.
	newState := SmState new.
	initialState exitActionBlock: [ exitActionPeformed := true ].
	initialState transitionTo: newState when: [true].
	automaton step.
	self assert: exitActionPeformed
]

{ #category : #testing }
SmAutomataTest >> testStateUnchangedWhenNOTransitionIsActionable [
	|newState flag|
	newState := SmState new.
	flag := false.
	initialState transitionTo: newState when: [flag = true].
	automaton step.
	self assert: automaton currentState equals: initialState
]
