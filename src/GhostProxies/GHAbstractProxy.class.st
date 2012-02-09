Class {
	#name : #GHAbstractProxy,
	#superclass : #GHProxyTrap,
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHAbstractProxy >> class [
	"We just need it for debugging purposes"
	
	<primitive: 111>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
GHAbstractProxy >> log: aString [
	GHGhostLogger logger log: aString.
]

{ #category : #'as yet unclassified' }
GHAbstractProxy >> proxyHandler [
]
