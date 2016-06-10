Class {
	#name : #PhaROSUInt32TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSUInt32TypeTest >> invalidByteArrays [
	^ {
		 #[] .
		 '#[]' asByteArray .
		#[ 0 0 0 0 0 ]
	}.
]

{ #category : #'tests - parametrization' }
PhaROSUInt32TypeTest >> invalidValues [ 
	^ {
		-128 .   'a string' .  -1 . 4294967296
	}.

]

{ #category : #'tests - parametrization' }
PhaROSUInt32TypeTest >> relatedClass [
	^ PhaROSUInt32Type.
]

{ #category : #tests }
PhaROSUInt32TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSUInt32TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSUInt32TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSUInt32TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSUInt32TypeTest >> validValues [ 
	^ {
		1 -> #[ 4 0 0 0 1 0 0 0 ] .
		0 -> #[ 4 0 0 0 0 0 0 0 ] .
		250 -> #[ 4 0 0 0 250 0 0 0 ].
		275 -> #[ 4 0 0 0   19 1 0 0 ].
		65535 -> #[ 4 0 0 0 255 255 0 0  ].
		4294967295 -> #[ 4 0 0 0 255 255 255 255].
	}.
]
