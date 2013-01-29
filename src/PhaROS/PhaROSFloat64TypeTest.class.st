Class {
	#name : #PhaROSFloat64TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSFloat64TypeTest >> expectedFailures [
	" Must be implemented first "
	^#(
		testFailSerialize		
		testSerialize
		testUnserialize 
		testUnserializeFail 
	)
]

{ #category : #'as yet unclassified' }
PhaROSFloat64TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSFloat64TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSFloat64TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSFloat64TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]
