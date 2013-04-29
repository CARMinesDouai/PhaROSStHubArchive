Class {
	#name : #BoTestSuite,
	#superclass : #TestSuite,
	#category : #'BoTest-Kernel'
}

{ #category : #running }
BoTestSuite >> resultClass [
	^BoTestResult 
]
