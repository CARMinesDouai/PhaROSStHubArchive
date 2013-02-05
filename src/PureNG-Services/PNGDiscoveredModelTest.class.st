Class {
	#name : #PNGDiscoveredModelTest,
	#superclass : #PNGTestCase,
	#instVars : [
		'robulabFromDiscovery'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #accessing }
PNGDiscoveredModelTest >> robulabFromModel [
	^robot
]

{ #category : #testing }
PNGDiscoveredModelTest >> setUp [
	super setUp.
	robulabFromDiscovery := PNGRobulabDiscoveryFactory robulabFromIp: robot ip port: robot port.
]

{ #category : #testing }
PNGDiscoveredModelTest >> testNumberOfServices [
	self assert: robulabFromDiscovery services size = self robulabFromModel services size
]

{ #category : #testing }
PNGDiscoveredModelTest >> testServiceClasses [
	| classesFromDiscovery classesFromModel difference |
	classesFromDiscovery := robulabFromDiscovery services collect: [:service| service class].
	classesFromModel := self robulabFromModel services collect: [:service| service class].
	difference := classesFromDiscovery copyWithoutAll: classesFromModel.
	self assert: difference isEmpty
]
