"
A SmLoggedState is a state useful for demo or debugging purpose. It writes a log each time it is enabled or disable.

"
Class {
	#name : #SmLoggedState,
	#superclass : #SmState,
	#category : #StateMachine
}

{ #category : #stepping }
SmLoggedState >> disable [
	self logCr: 'Desabling ', self printString.
	super disable.
	
]

{ #category : #stepping }
SmLoggedState >> enable [
	self logCr: 'Enabling ', self printString.
	super enable
]
