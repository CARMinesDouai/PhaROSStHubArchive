Class {
	#name : #PhaROSTimeTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROS-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> expectedFailures [
	^ #(testSerialize)


]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> invalidByteArrays [
	^ {
		 #[] .
		 '#[]' asByteArray .
		#[ 0 0 0].
		#[ 0 0 0 0] .
		#[ 0 0 0 0 0 0 0] .
		65536 asByteArray 
	}.
]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> invalidValues [ 
	^ {
		-128 .   'a string' .  -1 . 4294967296 . (Time new seconds: 4294967298; yourself) .  (Time new seconds:0 nanoSeconds: 4294967298; yourself)
	}.

]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> relatedClass [ 
	^ PhaROSTimeType 
]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> testSerialize [
	
		^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> testUnserialize [
	^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSTimeTypeTest >> validValues [ 
	^ {
		(PhaROSTimestamp new)  -> #[8 0 0 0 0 0 0 0 0 0 0 0] .
"		(PhaROSTimestamp new seconds: 4294967295 nanoSeconds: 4294967295; yourself)  -> #[8 0 0 0 252 17 164 24 255 255 255 255].
		(PhaROSTimestamp new seconds: 4294967295 nanoSeconds: 0; yourself)  -> #[8 0 0 0 1 18 164 24 0 0 0 0].
		(PhaROSTimestamp new seconds: 0 nanoSeconds: 4294967295; yourself)  -> #[8 0 0 0 251 17 164 24 255 255 255 255].
"	}.
	

]
