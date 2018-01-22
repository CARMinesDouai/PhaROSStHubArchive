Class {
	#name : #ActionlibTwoIntsResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTwoIntsResult class >> rosTypeDefinition [ 
^' int64 sum
'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsResult class >> rosTypeName [ 
^'actionlib/TwoIntsResult'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsResult >> initialize [
	super initialize.
	 self sum: 0. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsResult >> sum [
	^ self getAt: #sum. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsResult >> sum: aValue [
	^ self at: #sum put: aValue. 

]
