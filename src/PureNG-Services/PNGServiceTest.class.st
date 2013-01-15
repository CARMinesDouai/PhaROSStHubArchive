Class {
	#name : #PNGServiceTest,
	#superclass : #TestCase,
	#instVars : [
		'robulab'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGServiceTest >> setUp [
	super setUp.
	robulab := PNGRobulab ip: #[192 168 1 2] port: 60000.
]
