Class {
	#name : #PhaROSStringTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> invalidByteArrays [
	^ {
		 #[] .
		#[ 0 ].
		#[ 0 0 ].
		#[ 0 0 0 ].
	}.
]

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> invalidValues [ 
	^ {
		-128 . self 
	}.

]

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> relatedClass [
	^ PhaROSStringType.
]

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSStringTypeTest >> validValues [ 
	^ {
		'1' -> #[ 5 0 0 0 1 0 0 0 49 ] .
		'0' -> #[ 5 0 0 0 1 0 0 0 48] .
		'hello world' -> #[ 15 0 0 0 11 0 0 0 104 101 108 108 111 32 119 111 114 108 100] .
		'A' -> #[5 0 0 0 1 0 0 0 65] .
	}.
	
 
]
