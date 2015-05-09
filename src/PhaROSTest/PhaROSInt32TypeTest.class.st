Class {
	#name : #PhaROSInt32TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSInt32TypeTest >> invalidByteArrays [
	^ {
		 #[] .
		 '#[]' asByteArray .
		#[ 0 0 0 0 0 ]
	}.
]

{ #category : #'tests - parametrization' }
PhaROSInt32TypeTest >> invalidValues [ 
	^ {
		'a string' .   2147483648
	}.

]

{ #category : #'tests - parametrization' }
PhaROSInt32TypeTest >> relatedClass [
	^ PhaROSInt32Type.
]

{ #category : #tests }
PhaROSInt32TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSInt32TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSInt32TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSInt32TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSInt32TypeTest >> validValues [ 
	^ {
		1 -> #[ 4 0 0 0 1 0 0 0 ] .
		0 -> #[ 4 0 0 0 0 0 0 0 ] .
		250 -> # [ 4 0 0 0 250 0 0 0 ].
		275 -> # [ 4 0 0 0   19 1 0 0 ].
		65535 -> #[ 4 0 0 0 255 255 0 0  ].
		2147483647 -> #[ 4 0 0 0 255 255 255 127  ].
		-2147483648 -> #[ 4 0 0 0 0    0     0     128  ].
		-1 -> #[ 4 0 0 0 255 255 255 255].
	}.
	

]
