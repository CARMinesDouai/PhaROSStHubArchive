Class {
	#name : #PhaROSTimeTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
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

{ #category : #'tests - parametrization' }
PhaROSTimeTypeTest >> invalidValues [ 
	^ {
		-128 .   'a string' .  -1 . 4294967296 . (Time new seconds: 4294967298; yourself) .  (Time new seconds:0 nanoSeconds: 4294967298; yourself)
	}.

]

{ #category : #'tests - parametrization' }
PhaROSTimeTypeTest >> relatedClass [ 
	^ PhaROSTimeType 
]

{ #category : #tests }
PhaROSTimeTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSTimeTypeTest >> testSerialize [
	
		^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSTimeTypeTest >> testUnserialize [
	^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSTimeTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSTimeTypeTest >> validValues [ 
	^ {
		(PhaROSTimestamp new)  -> #[8 0 0 0 0 0 0 0 0 0 0 0] .
"		(PhaROSTimestamp new seconds: 4294967295 nanoSeconds: 4294967295; yourself)  -> #[8 0 0 0 252 17 164 24 255 255 255 255].
		(PhaROSTimestamp new seconds: 4294967295 nanoSeconds: 0; yourself)  -> #[8 0 0 0 1 18 164 24 0 0 0 0].
		(PhaROSTimestamp new seconds: 0 nanoSeconds: 4294967295; yourself)  -> #[8 0 0 0 251 17 164 24 255 255 255 255].
"	}.
	

]
