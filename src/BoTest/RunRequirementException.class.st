Class {
	#name : #RunRequirementException,
	#superclass : #Error,
	#instVars : [
		'requiredTestCase'
	],
	#category : #'BoTest-Kernel'
}

{ #category : #accessing }
RunRequirementException >> requiredTestCase [
	^ requiredTestCase
]

{ #category : #accessing }
RunRequirementException >> requiredTestCase: anObject [
	requiredTestCase := anObject
]
