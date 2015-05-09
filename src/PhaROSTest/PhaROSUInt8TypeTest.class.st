Class {
	#name : #PhaROSUInt8TypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSUInt8TypeTest >> invalidByteArrays [ 
	^ {
		#[25 6 ] . #[ 10 10 ] . 'anString' asByteArray 
	}.

]

{ #category : #'tests - parametrization' }
PhaROSUInt8TypeTest >> invalidValues [ 
	^ {
		-128 . 256 . 'a string' .  -1 
	}.

]

{ #category : #'tests - parametrization' }
PhaROSUInt8TypeTest >> relatedClass [
	^ PhaROSUInt8Type 
]

{ #category : #tests }
PhaROSUInt8TypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSUInt8TypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSUInt8TypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSUInt8TypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSUInt8TypeTest >> validValues [ 
	^
	{
		255 -> # [ 1 0 0 0 255 ]. 
		128 -> # [ 1 0 0 0 128 ]. 
		0 ->  #[ 1 0 0 0 0 ] .
		127 ->  #[ 1 0 0 0 127 ] .
	} .
]
