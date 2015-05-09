Class {
	#name : #PhaROSBoolTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSBoolTypeTest >> invalidByteArrays [ 
	^ {
		#[25 6] . #[ 10 10 ] . 'anString' asByteArray 
	}.
]

{ #category : #'tests - parametrization' }
PhaROSBoolTypeTest >> invalidValues [ 
	^ { True . False . 'anString' }.
	 
]

{ #category : #'tests - parametrization' }
PhaROSBoolTypeTest >> relatedClass [
	^ PhaROSBoolType.
]

{ #category : #tests }
PhaROSBoolTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSBoolTypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSBoolTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSBoolTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSBoolTypeTest >> validValues [ 
	^
	{
		true ->   #[ 1 0 0 0 1 ] .
		false ->  #[ 1 0 0 0 0 ] .
	} 
]
