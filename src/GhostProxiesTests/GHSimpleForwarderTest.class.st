Class {
	#name : #GHSimpleForwarderTest,
	#superclass : #TestCase,
	#category : #GhostProxiesTests
}

{ #category : #'as yet unclassified' }
GHSimpleForwarderTest >> setUp [
	GHProxyTrap initialize.   
	FileDirectory default deleteFileNamed:  'GhostLog.txt'.
	GHGhostLogger changeToFileLogger.
	
]

{ #category : #'as yet unclassified' }
GHSimpleForwarderTest >> testSimpleForwardingForMethodUsingBecome [
       | aProxy aUser method |
       aUser := GHUser named: 'Kurt'.
       method := GHUser methodDict at: #username.
       [aProxy := GHProxy createProxyAndReplace: method handler: GHSimpleForwarderProxyHandler new. 
       self assert: aProxy getSource equals: 'username ^ username'. 
       self assert: aUser username equals: 'Kurt'.
	 ] ensure: [ aProxy name ]
]

{ #category : #'as yet unclassified' }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObject [
	| proxy |
	proxy := GHProxy createProxyFor: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy x equals: 3. 
	self assert: proxy y equals: 4.
]

{ #category : #'as yet unclassified' }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObject2 [
	| proxy |
	proxy := GHProxy createProxyFor: (GHUser named: 'mariano') handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy username = 'mariano'.
]

{ #category : #'as yet unclassified' }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObjectWithBecome [
	| proxy |
	proxy := GHProxy createProxyAndReplace: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy x equals: 3. 
	self assert: proxy y equals: 4.
]
