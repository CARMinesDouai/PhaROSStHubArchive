"
A SmState is a state in an automaton.

Instance Variables
	automaton:		<SmAutomaton>
	entryActionBlock:		<BlockClosure>
	exitActionBlock:		<BlockClosure>
	transitions:		<Set of SmTransition>

automaton
	- The automaton to which belongs this state

entryActionBlock
	- Action performed when the state is enabled, i.e. when it becomes the current state of the automaton.

exitActionBlock
	- Action performed when the the state is disabled, i.e. when the state is not the current state of the automaton anymore.

transitions
	- Transitions outgoing from this state

"
Class {
	#name : #SmState,
	#superclass : #Object,
	#instVars : [
		'transitions',
		'automaton',
		'entryActionBlock',
		'exitActionBlock'
	],
	#category : #StateMachine
}

{ #category : #'instance creation' }
SmState class >> automaton: anAutomaton [
	^super new
		automaton: anAutomaton;
		yourself
]

{ #category : #'instance creation' }
SmState class >> new [
	self error: 'Use automaton: message to create states'
]

{ #category : #accessing }
SmState >> automaton [
	^automaton
]

{ #category : #accessing }
SmState >> automaton: anAutomaton [
	automaton := anAutomaton
]

{ #category : #stepping }
SmState >> disable [
	self exitActionBlock value
]

{ #category : #stepping }
SmState >> enable [
	self automaton currentState: self.
	self entryActionBlock value
]

{ #category : #accessing }
SmState >> entryActionBlock [
	^ entryActionBlock
]

{ #category : #accessing }
SmState >> entryActionBlock: anObject [
	entryActionBlock := anObject
]

{ #category : #accessing }
SmState >> exitActionBlock [
	^ exitActionBlock
]

{ #category : #accessing }
SmState >> exitActionBlock: anObject [
	exitActionBlock := anObject
]

{ #category : #'initialize-release' }
SmState >> initialize [
	super initialize.
	transitions := Set new
]

{ #category : #stepping }
SmState >> step [
	transitions
		detect:  [ :aTransition| aTransition isActionable] 
		ifFound: [ :actionableTransition| actionableTransition perform]
]

{ #category : #transitions }
SmState >> transitionTo: targetState when: conditionBlock [ 
	| newTransition |
	newTransition := SmTransition from: self to:  targetState when: conditionBlock.
	transitions add: newTransition
]
