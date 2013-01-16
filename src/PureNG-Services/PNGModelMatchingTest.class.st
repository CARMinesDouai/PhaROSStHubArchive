Class {
	#name : #PNGModelMatchingTest,
	#superclass : #TestCase,
	#instVars : [
		'robulabFromModel',
		'robulabFromDiscovery'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGModelMatchingTest >> setUp [
	super setUp.
	robulabFromModel := PNGRobulabHandcodedFactory kompai2.
	robulabFromDiscovery := PNGRobulabDiscoveryFactory robulabFromIp: #[192 168 1 2] port: 60000.
]

{ #category : #testing }
PNGModelMatchingTest >> testNumberOfServices [
	self assert: robulabFromDiscovery services size = robulabFromModel services size
]

{ #category : #testing }
PNGModelMatchingTest >> testServiceClasses [
	| classesFromDiscovery classesFromModel difference |
	classesFromDiscovery := robulabFromDiscovery services collect: [:service| service class].
	classesFromModel := robulabFromModel services collect: [:service| service class].
	difference := classesFromDiscovery copyWithoutAll: classesFromModel.
	self assert: difference isEmpty
]
