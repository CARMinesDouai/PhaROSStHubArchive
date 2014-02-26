Class {
	#name : #PhaROSUInt16TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> invalidByteArrays [
	^ {
		 #[] .
		 '#[]' asByteArray .
		#[ 0 0 0].
		#[ 0 0 0 0] .
		65536 asByteArray 
	}.
]

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> invalidValues [ 
	^ {
		-128 .  65536 . 'a string' .  -1 
	}.

]

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> relatedClass [
	^ PhaROSUInt16Type.
]

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt16TypeTest >> validValues [ 
	^ {
		1 -> #[ 2 0 0 0 1 0 ] .
		0 -> #[ 2 0 0 0 0 0 ] .
		250 -> # [ 2 0 0 0 250 0 ].
		275 -> # [ 2 0 0 0 19 1].
		65535 -> #[ 2 0 0 0 255 255 ].
	}.
]
