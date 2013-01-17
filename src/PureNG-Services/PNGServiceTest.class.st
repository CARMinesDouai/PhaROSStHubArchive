Class {
	#name : #PNGServiceTest,
	#superclass : #PNGTestCase,
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
