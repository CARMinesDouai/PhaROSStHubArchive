Class {
	#name : #PhaROSDurationTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'tests - parametrization' }
PhaROSDurationTypeTest >> invalidByteArrays [
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
PhaROSDurationTypeTest >> invalidValues [ 
	^ {
		-128 .   'a string' .  -1 . 4294967296 . (Duration seconds: 4294967298) 
	}.

]

{ #category : #'tests - parametrization' }
PhaROSDurationTypeTest >> relatedClass [ 
	^PhaROSDurationType 
]

{ #category : #tests }
PhaROSDurationTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSDurationTypeTest >> testSerialize [
		^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSDurationTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #tests }
PhaROSDurationTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'tests - parametrization' }
PhaROSDurationTypeTest >> validValues [ 
	^ {
		(Duration new seconds: 1 nanoSeconds: 0; yourself)  -> #[ 8 0 0 0 1 0 0 0 0 0 0 0 ] .
		(Duration new seconds: 4294967295 nanoSeconds: 4294967295; yourself)  -> #[ 8 0 0 0 255 255 255 255 255 255 255 255] .
		(Duration new seconds: 4294967295 nanoSeconds: 0; yourself)  -> #[ 8 0 0 0 255 255 255 255 0 0 0 0] .
	}.
]
