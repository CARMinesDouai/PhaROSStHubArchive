Class {
	#name : #GHAbstractProxy,
	#superclass : #GHProxyTrap,
	#category : #GhostProxies
}

{ #category : #'class membership' }
GHAbstractProxy >> class [
	"We just need it for debugging purposes"
	
	<primitive: 111>
	self primitiveFailed
]

{ #category : #logging }
GHAbstractProxy >> log: aString [
	GHGhostLogger log: aString.
]

{ #category : #API }
GHAbstractProxy >> proxyHandler [
	"This must be implemented in subclasses"
]
