Class {
	#name : #PhaROSFloat64TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #testing }
PhaROSFloat64TypeTest >> expectedFailures [
	" Must be implemented first "
	^#(
		testFailSerialize		
		testSerialize
		testUnserialize 
		testUnserializeFail 
	)
]

{ #category : #tests }
PhaROSFloat64TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSFloat64TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSFloat64TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSFloat64TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]
