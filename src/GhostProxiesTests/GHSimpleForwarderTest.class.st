Class {
	#name : #GHSimpleForwarderTest,
	#superclass : #TestCase,
	#category : #GhostProxiesTests
}

{ #category : #running }
GHSimpleForwarderTest >> setUp [
	GHProxyTrap initialize.   
	FileDirectory default deleteFileNamed:  'GhostLog.txt'.
	GHGhostLogger changeToFileLogger 
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToClass [
    | aProxy aUser |
       aUser := GHUser named: 'Kurt'.
	[aProxy := GHClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
       self assert:  GHUser name equals: #GHUser. 
	] ensure: [ aProxy uninstall ]
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToInstance [
    | aProxy aUser |
       aUser := GHUser named: 'Kurt'.
       
	[ aProxy := GHClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
     self assert: aUser username equals: 'Kurt'.
	] ensure: [ aProxy uninstall ]
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToSubclass [
    | aProxy aUser |
       aUser := GHUser named: 'Kurt'.
	[aProxy := GHClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
	self assert:  GHUserSubclass name equals: #GHUserSubclass. 
	] ensure: [ aProxy uninstall ]
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToSubclassInstance [
    | aProxy aUser |
       aUser := GHUserSubclass named: 'Kurt'.
	[ aProxy := GHClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
     self assert: aUser username equals: 'Kurt'.
	] ensure: [ aProxy uninstall ]
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForMethodUsingBecome [
       | aProxy aUser method |
       aUser := GHUser named: 'Kurt'.
       method := GHUser methodDict at: #username.
       [aProxy := GHProxy createProxyAndReplace: method handler: GHSimpleForwarderProxyHandler new. 
       self assert: aProxy getSource equals: 'username ^ username'. 
       self assert: aUser username equals: 'Kurt'.
	 ] ensure: [ aProxy uninstall ]
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObject [
	| proxy |
	proxy := GHProxy createProxyFor: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy x equals: 3. 
	self assert: proxy y equals: 4.
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObject2 [
	| proxy |
	proxy := GHProxy createProxyFor: (GHUser named: 'mariano') handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy username = 'mariano'.
]

{ #category : #tests }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObjectWithBecome [
	| proxy |
	proxy := GHProxy createProxyAndReplace: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy x equals: 3. 
	self assert: proxy y equals: 4.
]
