Class {
	#name : #ActionlibTestResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestResult class >> rosMd5Sum [ 
^'034a8e20d6a306665e3a5b340fab3f09'
]

{ #category : #'as yet unclassified' }
ActionlibTestResult class >> rosTypeDefinition [ 
^' int32 result
'
]

{ #category : #'as yet unclassified' }
ActionlibTestResult class >> rosTypeName [ 
^'actionlib/TestResult'
]

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
