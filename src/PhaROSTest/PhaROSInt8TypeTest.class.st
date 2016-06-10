Class {
	#name : #PhaROSInt8TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSInt8TypeTest >> invalidByteArrays [ 
	^ {
		#[25 6] . #[ 10 10 ] . 'anString' asByteArray 
	}.

]

{ #category : #'tests - parametrization' }
PhaROSInt8TypeTest >> invalidValues [ 
	^ {
		128 . 256 . 'a string' . -129
	}.

]

{ #category : #'tests - parametrization' }
PhaROSInt8TypeTest >> relatedClass [
	^ PhaROSInt8Type.
]

{ #category : #tests }
PhaROSInt8TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSInt8TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSInt8TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSInt8TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSInt8TypeTest >> validValues [ 
	^
	{
		-128 -> #[ 1 0 0 0  128 ].
		-1 -> #[1  0 0 0  255 ]. 
		0 ->  #[ 1 0 0 0  0 ] .
		127 ->  #[ 1 0 0 0  127 ] .
	} .
]
