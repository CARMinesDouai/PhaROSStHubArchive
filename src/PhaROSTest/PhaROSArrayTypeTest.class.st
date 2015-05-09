Class {
	#name : #PhaROSArrayTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSArrayTypeTest >> invalidByteArrays [
	^ {
		 #[] .
		 '#[]' asByteArray .
		#[ 0 0 0].
		#[ 0 0 0 0] .
		65536 asByteArray  .
		32768 asByteArray 
	}.
]

{ #category : #'tests - parametrization' }
PhaROSArrayTypeTest >> invalidValues [ 
	^ {
		 65536 . 'a string' .   32768 . -32769 . {-32769} .  { 32768 } .  { 'str' } 
	}.

]

{ #category : #accessing }
PhaROSArrayTypeTest >> newTestedClassInstance [
	^ self relatedClass of: PhaROSInt16Type.
]

{ #category : #'tests - parametrization' }
PhaROSArrayTypeTest >> relatedClass [
	^PhaROSArrayType 
]

{ #category : #tests }
PhaROSArrayTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSArrayTypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSArrayTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSArrayTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSArrayTypeTest >> validValues [ 
	^ {
		{ 32767 } -> #[ 6 0 0 0 1 0 0 0 255 127 ] .
		{ -1 } -> #[ 6 0 0 0 1 0 0 0 255 255 ] .
		{ -32767 } -> #[ 6 0 0 0 1 0 0 0 1 128 ] .
		{ 1 } -> #[ 6 0 0 0 1 0 0 0 1 0 ] .		
		{ 0 } -> #[ 6 0 0 0 1 0 0 0 0 0 ] .
		
	 	{ 1 . 0 } -> #[ 8 0 0 0 2 0 0 0 1 0 0 0 ] .
		{ 0 . 1 } -> #[ 8 0 0 0 2 0 0 0 0 0 1 0 ] .
		
		{ 32767 . -32767 . -1 } -> #[  10 0 0 0 3 0 0 0 255 127 1 128  255 255].
	}.

]
