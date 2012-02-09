Class {
	#name : #GHProxyTrap,
	#superclass : #GHInterceptionDelegator,
	#category : #GhostProxies
}

{ #category : #'class initialization' }
GHProxyTrap class >> initialize [
	self nilMethodDict 
]

{ #category : #'class initialization' }
GHProxyTrap class >> nilMethodDict [
	methodDict := nil. 
]
