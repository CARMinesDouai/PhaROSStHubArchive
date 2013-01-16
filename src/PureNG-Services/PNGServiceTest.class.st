Class {
	#name : #PNGServiceTest,
	#superclass : #TestCase,
	#instVars : [
		'robot'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGServiceTest >> setUp [
	super setUp.
	robot := PNGRobulabHandcodedFactory kompai2
]
