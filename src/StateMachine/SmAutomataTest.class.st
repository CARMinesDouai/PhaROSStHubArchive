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
	initialState := automaton newState.
	automaton initialState: initialState 
]

{ #category : #testing }
SmAutomataTest >> testAutomatonAtInitialState [
	self assert: automaton currentState equals: initialState.
	self assert: initialState automaton equals: automaton
]

{ #category : #testing }
SmAutomataTest >> testChangeStateWhenTransitionConditionIsVerified [
	|newState flag|
	newState := automaton newState.
	flag := false.
	initialState transitionTo: newState when: [flag].
	flag := true.
	automaton step.
	self assert: automaton currentState equals: newState
]

{ #category : #testing }
SmAutomataTest >> testEntryActionOfInitialStatePerformed [
	|newState entryActionPeformed|
	entryActionPeformed := false.
	newState := automaton newStateOnEntryDo: [ entryActionPeformed := true ].
	automaton initialState: newState.
	self assert: entryActionPeformed
]

{ #category : #testing }
SmAutomataTest >> testMainActionOfInitialStatePerformedOnceEnabled [
	| count countingState |
	count := 0.
	countingState := automaton newStateDoing: [ count := count + 1 ].
	automaton initialState: countingState.
	self assert: count equals: 1.

]

{ #category : #testing }
SmAutomataTest >> testStateEntryActionPerformed [
	|newState entryActionPeformed|
	entryActionPeformed := false.
	newState := automaton newStateOnEntryDo: [ entryActionPeformed := true ].
	initialState transitionTo: newState when: [true].
	automaton step.
	self assert: entryActionPeformed
]

{ #category : #testing }
SmAutomataTest >> testStateExitActionPerformed [
	|newState exitActionPeformed|
	exitActionPeformed := false.
	newState := automaton newState.
	initialState exitActionBlock: [ exitActionPeformed := true ].
	initialState transitionTo: newState when: [true].
	automaton step.
	self assert: exitActionPeformed
]

{ #category : #testing }
SmAutomataTest >> testStateMainActionRepeatedAsLongNoTransitionOccurs [
	| count countingState shouldCount |
	count := 0.
	countingState := automaton newStateDoing: [ count := count + 1 ].
	shouldCount := false.
	initialState transitionTo: countingState when: [shouldCount].
	countingState transitionTo: initialState when: [shouldCount not].
	shouldCount := true.
	1 to: 4 do: [: expectedCount |
		automaton step.
		self assert: count equals: expectedCount].
	shouldCount := false.
	4 timesRepeat: [
		automaton step.
		self assert: count equals: 4]

]

{ #category : #testing }
SmAutomataTest >> testStateReferencesAutomaton [
	| targetState sourceState |
	self assert: initialState automaton equals: automaton.	
	targetState := automaton newState.
	initialState transitionTo: targetState when: [true].
	self assert: initialState automaton equals: automaton.	
	self assert: targetState automaton equals: automaton.	
	sourceState := automaton newState.
	sourceState transitionTo: initialState when: [true].
	self assert: initialState automaton equals: automaton.	
	self assert: targetState automaton equals: automaton.	
	self assert: sourceState automaton equals: automaton.	
	
]

{ #category : #testing }
SmAutomataTest >> testStateUnchangedWhenNOTransitionIsActionable [
	|newState flag|
	newState := automaton newState.
	flag := false.
	initialState transitionTo: newState when: [flag].
	automaton step.
	self assert: automaton currentState equals: initialState
]
