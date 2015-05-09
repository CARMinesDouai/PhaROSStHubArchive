Class {
	#name : #PhaROSStringTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSStringTypeTest >> invalidByteArrays [
	^ {
		 #[] .
		#[ 0 ].
		#[ 0 0 ].
		#[ 0 0 0 ].
	}.
]

{ #category : #'tests - parametrization' }
PhaROSStringTypeTest >> invalidValues [ 
	^ {
		-128 . self 
	}.

]

{ #category : #'tests - parametrization' }
PhaROSStringTypeTest >> relatedClass [
	^ PhaROSStringType.
]

{ #category : #tests }
PhaROSStringTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSStringTypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSStringTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSStringTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSStringTypeTest >> validValues [ 
	^ {
		'1' -> #[ 5 0 0 0 1 0 0 0 49 ] .
		'0' -> #[ 5 0 0 0 1 0 0 0 48] .
		'hello world' -> #[ 15 0 0 0 11 0 0 0 104 101 108 108 111 32 119 111 114 108 100] .
		'A' -> #[5 0 0 0 1 0 0 0 65] .
	}.
	
 
]
