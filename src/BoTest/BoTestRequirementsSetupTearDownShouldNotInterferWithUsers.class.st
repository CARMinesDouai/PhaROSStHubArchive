Class {
	#name : #BoTestRequirementsSetupTearDownShouldNotInterferWithUsers,
	#superclass : #BoTestCase,
	#classVars : [
		'SharedValue'
	],
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoTestRequirementsSetupTearDownShouldNotInterferWithUsers >> required [
	SharedValue := #required.
]

{ #category : #testing }
BoTestRequirementsSetupTearDownShouldNotInterferWithUsers >> setUp [
	super setUp.
	SharedValue := #setUp
]

{ #category : #testing }
BoTestRequirementsSetupTearDownShouldNotInterferWithUsers >> tearDown [
	super tearDown.
	SharedValue := #tearDown
]

{ #category : #testing }
BoTestRequirementsSetupTearDownShouldNotInterferWithUsers >> testAAA [
	| requiredSelector selectors |
	requiredSelector := #testBBB.
	selectors := { self selector. requiredSelector } asSortedCollection.
	self assert: selectors first equals: self selector.
	self requires: requiredSelector.	
	self assert: SharedValue equals: #setUp
]

{ #category : #testing }
BoTestRequirementsSetupTearDownShouldNotInterferWithUsers >> testBBB [
	SharedValue := #BBB.
]
