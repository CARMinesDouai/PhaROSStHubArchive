Class {
	#name : #PhaROSBoolTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> invalidByteArrays [ 
	^ {
		#[25 6] . #[ 10 10 ] . 'anString' asByteArray 
	}.
]

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> invalidValues [ 
	^ { True . False . 'anString' }.
	 
]

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> relatedClass [
	^ PhaROSBoolType.
]

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> testSerialize [
				^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSBoolTypeTest >> validValues [ 
	^
	{
		true ->   #[ 1 0 0 0 1 ] .
		false ->  #[ 1 0 0 0 0 ] .
	} 
]
