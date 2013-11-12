"
A ParameterizedTestCase is a test case that can have test methods that expect parameters. Such a method should have a pragma testParametersSelector:. The argument of the pragma is the selector of the method that provides an array of arrays of parameters. 

This is useful in situation where there are different scenarios to test that differ only in the some values. An example is given in ExampleOfParameterizedTestCase

Instance Variables
	parameterizedSelector:		<Symbol>
	parameters:		<Array>

parameterizedSelector
	- test selector with arguments

parameters
	- argument values for the test selector

"
Class {
	#name : #ParameterizedTestCase,
	#superclass : #TestCase,
	#instVars : [
		'parameters'
	],
	#category : #ParameterizedTests
}

{ #category : #'building suites' }
ParameterizedTestCase class >> addParametrizedTestsTo: suite [
	self parametrizedTestMethods do: [ :testMethod | 
		suite addTests: (self parametrizedTestsFrom: testMethod)
	]
]

{ #category : #'building suites' }
ParameterizedTestCase class >> buildSuite [
	| suite |
	suite := super buildSuite.
	self isAbstract ifTrue: [ ^suite].
	self addParametrizedTestsTo: suite.
	^suite
]

{ #category : #'building suites' }
ParameterizedTestCase class >> parameterizedTestPrgramaKeyword [
	^#testParametersSelector:
]

{ #category : #'building suites' }
ParameterizedTestCase class >> parametrizedTest: testSelector withValues: dataArray [
	^(self selector: testSelector) 
		parameters: dataArray;
		yourself
	
]

{ #category : #'building suites' }
ParameterizedTestCase class >> parametrizedTestMethods [
	^self allMethods select: [ :method |
		(method pragmaAt: self parameterizedTestPrgramaKeyword) notNil
	 ]
]

{ #category : #'building suites' }
ParameterizedTestCase class >> parametrizedTestsFrom: testMethod [
	| testSelector pragma dataTable |
	testSelector := testMethod selector.
	pragma := testMethod pragmaAt: self parameterizedTestPrgramaKeyword.
	dataTable := self  basicNew perform: pragma arguments first.
	^dataTable collect: [ :dataArray|
		self parametrizedTest: testSelector withValues: dataArray
	]
]

{ #category : #private }
ParameterizedTestCase >> cleanUpInstanceVariables [
	self instVarsToCleanUp do: [ :name |
		self instVarNamed: name put: nil ]
]

{ #category : #running }
ParameterizedTestCase >> debug [
	[ (self class parametrizedTest: self selector withValues: self parameters) runCase ]
		ensure: [ self classForTestResource resetResources: self resources ]
]

{ #category : #private }
ParameterizedTestCase >> instVarsToCleanUp [
	^self class allInstVarNames copyWithoutAll: self instVarsToKeepOnCleanUp
]

{ #category : #private }
ParameterizedTestCase >> instVarsToKeepOnCleanUp [
	^#(testSelector parameters)
]

{ #category : #accessing }
ParameterizedTestCase >> parameters [
	^ parameters ifNil: [ #() ]
]

{ #category : #accessing }
ParameterizedTestCase >> parameters: anObject [
	parameters := anObject
]

{ #category : #private }
ParameterizedTestCase >> performTest [
	self perform: self selector withArguments: self parameters
]

{ #category : #printing }
ParameterizedTestCase >> printOn: aStream [
	super printOn: aStream.
	aStream space.
	(self parameters isKindOf: Array) ifFalse: [ ^aStream print: self parameters ].
	aStream nextPut: ${.
	self parameters 
		do: [ :param | aStream print: param]
		separatedBy: [ aStream nextPut: $. ; space ].
	aStream nextPut: $}
]

{ #category : #running }
ParameterizedTestCase >> run [
	| suite |
	suite := self class suiteClass named: self selector.
	self class addParametrizedTestsTo: suite.
	^suite run
]
