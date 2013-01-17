Class {
	#name : #PNGDiscoveredModelTest,
	#superclass : #PNGTestCase,
	#instVars : [
		'robulabFromModel',
		'robulabFromDiscovery'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGDiscoveredModelTest >> setUp [
	super setUp.
	robulabFromModel := PNGRobulabHandcodedFactory kompai2.
	robulabFromDiscovery := PNGRobulabDiscoveryFactory robulabFromIp: #[192 168 1 2] port: 60000.
]

{ #category : #testing }
PNGDiscoveredModelTest >> testNumberOfServices [
	self assert: robulabFromDiscovery services size = robulabFromModel services size
]

{ #category : #testing }
PNGDiscoveredModelTest >> testServiceClasses [
	| classesFromDiscovery classesFromModel difference |
	classesFromDiscovery := robulabFromDiscovery services collect: [:service| service class].
	classesFromModel := robulabFromModel services collect: [:service| service class].
	difference := classesFromDiscovery copyWithoutAll: classesFromModel.
	self assert: difference isEmpty
]
