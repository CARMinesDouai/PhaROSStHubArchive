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

{ #category : #'tests - handler answers' }
GHSimpleForwarderTest >> testHandlerAnswerDebugging [
	| proxy |
	proxy := GHTargetBasedProxy createProxyFor: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy printString = 'This is the print of a proxy'
]

{ #category : #'tests - proxy answers' }
GHSimpleForwarderTest >> testProxyAnswerDebugging [
	| proxy |
	proxy := GHTargetBasedProxy createProxyFor: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy isProxy
]

{ #category : #'tests - classes' }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToClass [
    | aProxy aUser |
       aUser := GHUser named: 'Kurt'.
	[aProxy := GHTargetBasedClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
       self assert:  GHUser name equals: #GHUser. 
	] ensure: [ aProxy uninstall ]
]

{ #category : #'tests - classes' }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToInstance [
    | aProxy aUser |
       aUser := GHUser named: 'Kurt'.
       
	[ aProxy := GHTargetBasedClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
     self assert: aUser username equals: 'Kurt'.
	] ensure: [ aProxy uninstall ]
]

{ #category : #'tests - classes' }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToSubclass [
    | aProxy aUser |
       aUser := GHUser named: 'Kurt'.
	[aProxy := GHTargetBasedClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
	self assert:  GHUserSubclass name equals: #GHUserSubclass. 
	] ensure: [ aProxy uninstall ]
]

{ #category : #'tests - classes' }
GHSimpleForwarderTest >> testSimpleForwardingForClassesToSubclassInstance [
    | aProxy aUser |
       aUser := GHUserSubclass named: 'Kurt'.
	[ aProxy := GHTargetBasedClassProxy createProxyAndReplace: GHUser handler: GHSimpleForwarderProxyHandler new. 
     self assert: aUser username equals: 'Kurt'.
	] ensure: [ aProxy uninstall ]
]

{ #category : #'tests - methods' }
GHSimpleForwarderTest >> testSimpleForwardingForMethodUsingBecome [
       | aProxy aUser method |
       aUser := GHUser named: 'Kurt'.
       method := GHUser methodDict at: #username.
       [aProxy := GHTargetBasedProxy createProxyAndReplace: method handler: GHSimpleForwarderProxyHandler new. 
       self assert: aProxy getSource equals: 'username ^ username'. 
       self assert: aUser username equals: 'Kurt'.
	 ] ensure: [ aProxy uninstall ]
]

{ #category : #'tests - regular objects' }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObject [
	| proxy |
	proxy := GHTargetBasedProxy createProxyFor: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy x equals: 3. 
	self assert: proxy y equals: 4.
]

{ #category : #'tests - regular objects' }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObject2 [
	| proxy |
	proxy := GHTargetBasedProxy createProxyFor: (GHUser named: 'mariano') handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy username = 'mariano'.
]

{ #category : #'tests - regular objects' }
GHSimpleForwarderTest >> testSimpleForwardingForRegularObjectWithBecome [
	| proxy |
	proxy := GHTargetBasedProxy createProxyAndReplace: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy x equals: 3. 
	self assert: proxy y equals: 4.
]

{ #category : #'tests - regular objects' }
GHSimpleForwarderTest >> testSimpleForwardingNoTargetLeak [
	| proxy |
	proxy := GHTargetBasedProxy createProxyFor: (Point x: 3 y: 4) handler: GHSimpleForwarderProxyHandler new. 
	self assert: proxy x equals: 3. 
	self assert: proxy y equals: 4.
]
