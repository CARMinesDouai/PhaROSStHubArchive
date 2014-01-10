Class {
	#name : #PhaROSDurationTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#category : #'PhaROSTest-Types'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
PhaROSDurationTypeTest >> invalidValues [ 
	^ {
		-128 .   'a string' .  -1 . 4294967296 . (Duration seconds: 4294967298) 
	}.

]

{ #category : #'as yet unclassified' }
PhaROSDurationTypeTest >> relatedClass [ 
	^PhaROSDurationType 
]

{ #category : #'as yet unclassified' }
PhaROSDurationTypeTest >> testFailSerialize [
				^ super baseFailSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSDurationTypeTest >> testSerialize [
		^ super baseSerialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSDurationTypeTest >> testUnserialize [
				^ super baseUnserialize.
		
]

{ #category : #'as yet unclassified' }
PhaROSDurationTypeTest >> testUnserializeFail [
				^ super baseUnserializeFail.
		
]

{ #category : #'as yet unclassified' }
PhaROSDurationTypeTest >> validValues [ 
	^ {
		(Duration new seconds: 1 nanoSeconds: 0; yourself)  -> #[ 8 0 0 0 1 0 0 0 0 0 0 0 ] .
		(Duration new seconds: 4294967295 nanoSeconds: 4294967295; yourself)  -> #[ 8 0 0 0 255 255 255 255 255 255 255 255] .
		(Duration new seconds: 4294967295 nanoSeconds: 0; yourself)  -> #[ 8 0 0 0 255 255 255 255 0 0 0 0] .
	}.
]
