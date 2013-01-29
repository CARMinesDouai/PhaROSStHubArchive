Class {
	#name : #PhaROSFloat32TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> invalidByteArrays [ 
	^ {
		 'anString' asByteArray . #[0 0 0 0 0 0 0 0 0]
	}.

]

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> invalidValues [ 
	^ {
		 'a string' . 4294967295654.232654 . 4299497.32 
	}.

]

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> relatedClass [ 
	^PhaROSFloat32Type.
]

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSFloat32TypeTest >> validValues [ 
	^ {
	
		-2.0 -> #[ 4 0 0 0 0 0 0 192].
		2.0 -> #[4 0 0 0 0 0 0 64] .
		1.0 -> #[4 0 0 0 0 0 128 63] .
		0.0 -> #[4 0 0 0  0 0 0 0] .
		250.2 ->  #[4 0 0 0 51 51 122 67].
		275.323 -> #[4 0 0 0 88 169 137 67].
		
	}.

]
