Class {
	#name : #ActionlibTwoIntsResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTwoIntsResult class >> rosMd5Sum [ 
^'b88405221c77b1878a3cbbfff53428d7'
]

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
ActionlibTwoIntsResult class >> typeCreationOrder [ 
^19
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
