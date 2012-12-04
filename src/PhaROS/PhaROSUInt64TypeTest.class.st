Class {
	#name : #PhaROSUInt64TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Kernel-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> invalidByteArrays [
	^ {
		 #[] .
		 '#[]' asByteArray .
		#[ 0 0 0 0 0 0 0 0 0].
		18446744073709551616 asByteArray 
	}.
]

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> invalidValues [ 
	^ {
		-128 .   'a string' .  -1 . 18446744073709551616
	}.


]

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> relatedClass [
	^ PhaROSUInt64Type.
]

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSUInt64TypeTest >> validValues [ 
	^ {
		1 -> #[ 8 0 0 0  1 0 0 0 0 0 0 0] .
		0 -> #[ 8 0 0 0  0 0 0 0 0 0 0 0 ] .
		250 -> # [8 0 0 0  250 0 0 0 0 0 0 0 ].
		275 -> # [ 8 0 0 0   19 1 0 0 0 0 0 0 ].
		65535 -> #[ 8 0 0 0  255 255 0 0 0 0 0 0  ].
		4294967295 -> #[ 8 0 0 0  255 255 255 255 0 0 0 0 ].
		18446744073709551615 -> #[8 0 0 0  255 255 255 255 255 255 255 255].
	}.
]
