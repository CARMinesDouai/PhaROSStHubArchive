Class {
	#name : #PhaROSInt16TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> invalidByteArrays [
	^ {
		 #[] .
		 '#[]' asByteArray .
		#[ 0 0 0].
		#[ 0 0 0 0] .
		65536 asByteArray  .
		32768 asByteArray 
	}.
]

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> invalidValues [ 
	^ {
		 65536 . 'a string' .   32768 . -32769
	}.

]

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> relatedClass [
	^ PhaROSInt16Type.
]

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSInt16TypeTest >> validValues [ 
	^ {
		1 -> #[ 2 0 0 0 1 0 ] .
		0 -> #[ 2 0 0 0 0 0 ] .
		250 -> # [ 2 0 0 0 250 0 ].
		275 -> # [ 2 0 0 0 19 1].
		32767 -> #[ 2 0 0 0 255 127].
		-1 -> #[ 2 0 0 0 255 255]. 
		-32767 -> #[ 2 0 0 0 1 128].
		-32768 -> #[ 2 0 0 0 0 128].
	}.
]
