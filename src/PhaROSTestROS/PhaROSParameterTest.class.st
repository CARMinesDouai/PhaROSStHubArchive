Class {
	#name : #PhaROSParameterTest,
	#superclass : #PhaROSBaseCase,
	#instVars : [
		'service',
		'loggers',
		'node'
	],
	#category : #'PhaROSTestROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSParameterTest >> setUp [ 

	super setUp.	
	self startUpTurtle.
	
	node := PhaROSTestNode  name: '/TestNode' domain: '127.0.0.1' tcpPort: 92837 xmlRpcPort:  634987 master: master.
	master registerNode: node.
]

{ #category : #'as yet unclassified' }
PhaROSParameterTest >> testParameterCreation [
	|parameter|
	parameter := node parameter: #bla initialized: Number.
	
	parameter set: 1.
	self assert: parameter get = 1.

]

{ #category : #'as yet unclassified' }
PhaROSParameterTest >> testParameterMultipleInitializeTakeFirst [
	| parameter parameter2|
	parameter := node parameter: #bla initialized: 1.
	

	parameter set: 3.
	self assert: parameter get = 3.
	
	
	parameter2 := node parameter: #bla initialized:1. 
	
	self assert: parameter get = 3.
	self assert: parameter2 get = 3.
	

]

{ #category : #'as yet unclassified' }
PhaROSParameterTest >> testParameterMultiplePointing [
	| parameter parameter2|
	parameter := node parameter: #bla initialized: 1.
	parameter2 := node parameter: #bla initialized:1. 

	parameter set: 1.
	self assert: parameter get = 1.
	self assert: parameter2 get = 1.
	
	parameter2 set:2.
	
	self assert: parameter get = 2.
	self assert: parameter2 get = 2.

]

{ #category : #'as yet unclassified' }
PhaROSParameterTest >> testParameterTypeCheck [
	| parameter |
	parameter := node parameter: #bla initialized: 1.

	self should: [ parameter set: 'String'  ] raise: Error description:  'The parameter setting should reject invalid type'	.
	
]
