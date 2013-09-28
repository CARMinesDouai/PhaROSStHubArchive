Class {
	#name : #ExampleOfParameterizedTestCase,
	#superclass : #ParameterizedTestCase,
	#category : #ParameterizedTests
}

{ #category : #testing }
ExampleOfParameterizedTestCase >> givenValuesAndTheirExpectSum [
	^{{1. 2. 3}.
	{10. 20. 30}.
	{100. 200. 300}}
]

{ #category : #testing }
ExampleOfParameterizedTestCase >> should: op1 plus: op2 equals: expectedSum [
	<testParametersSelector: #givenValuesAndTheirExpectSum>
	self assert: op1 + op2 equals: expectedSum
]
