Class {
	#name : #ActionlibTestResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestResult >> initialize [
	super initialize.
	 self result: 0. 

]

{ #category : #'as yet unclassified' }
ActionlibTestResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestResult >> result: aValue [
	^ self at: #result put: aValue. 

]
