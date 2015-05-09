Class {
	#name : #PhaROSArrayFixedTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSArrayFixedTypeTest >> invalidByteArrays [
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
PhaROSArrayFixedTypeTest >> invalidValues [ 
	^ {
		 65536 . 'a string' .   32768 . -32769 . {-32769} .  { 32768 } .  { 'str' } . { 3220 } . { 32 . 45 . 3 . 3} . { 32 . 45 . 3  }
	}.

]

{ #category : #accessing }
PhaROSArrayFixedTypeTest >> newTestedClassInstance [
	^ self relatedClass of: 2 of: PhaROSInt16Type.
]

{ #category : #'tests - parametrization' }
PhaROSArrayFixedTypeTest >> relatedClass [
	^PhaROSArrayFixedLenghtType
]

{ #category : #tests }
PhaROSArrayFixedTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSArrayFixedTypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSArrayFixedTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSArrayFixedTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSArrayFixedTypeTest >> validValues [ 
	^ {
		
	 	{ 1 . 0 } -> #[ 4 0 0 0 1 0 0 0 ] .
		{ 0 . 1 } -> #[ 4 0 0 0 0 0 1 0 ] .
		
		{ 32767 . -1} -> #[  4 0 0 0 255 127  255 255].
	}.

]
