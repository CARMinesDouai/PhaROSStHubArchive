Class {
	#name : #PhaROSInt8TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Kernel-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> expectedLenght [
	^ 1.
]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> invalidByteArrays [ 
	^ {
		#[25 6] . #[ 10 10 ] . 'anString' asByteArray 
	}.

]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> invalidValues [ 
	^ {
		128 . 256 . 'a string' . -129
	}.

]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> relatedClass [
	^ PhaROSInt8Type.
]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt8TypeTest >> validValues [ 
	^
	{
		-128 -> # [ 1 0 0 0  128 ].
		-1 -> # [1  0 0 0  255 ]. 
		0 ->  #[ 1 0 0 0  0 ] .
		127 ->  #[ 1 0 0 0  127 ] .
	} .
]
