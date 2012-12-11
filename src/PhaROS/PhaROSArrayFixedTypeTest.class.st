Class {
	#name : #PhaROSArrayFixedTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Kernel-Types-Test'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> invalidValues [ 
	^ {
		 65536 . 'a string' .   32768 . -32769 . {-32769} .  { 32768 } .  { 'str' } . { 3220 } . { 32 . 45 . 3 . 3} . { 32 . 45 . 3  }
	}.

]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> newTestedClassInstance [
	^ self relatedClass of:2 of: PhaROSInt16Type.
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> relatedClass [
	^PhaROSArrayFixedLenghtType
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedTypeTest >> validValues [ 
	^ {
		
	 	{ 1 . 0 } -> #[ 4 0 0 0 1 0 0 0 ] .
		{ 0 . 1 } -> #[ 4 0 0 0 0 0 1 0 ] .
		
		{ 32767 . -1} -> #[  4 0 0 0 255 127  255 255].
	}.

]
