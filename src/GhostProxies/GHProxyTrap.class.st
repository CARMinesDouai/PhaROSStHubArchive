Class {
	#name : #GHProxyTrap,
	#superclass : #GHInterceptionDelegator,
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHProxyTrap class >> initialize [
	self nilMethodDict 
]

{ #category : #'as yet unclassified' }
GHProxyTrap class >> nilMethodDict [
	methodDict := nil. 
]
