Class {
	#name : #PNGRobulabTest,
	#superclass : #TestCase,
	#instVars : [
		'robulab'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGRobulabTest >> setUp [
	super setUp.
	robulab := PNGRobulab ip: #[192 168 1 2] port: 60000.
]

{ #category : #testing }
PNGRobulabTest >> testServicesCount [
	self assert: robulab services size = 9
]
