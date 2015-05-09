Class {
	#name : #PhaROSCompositeTypeTest,
	#superclass : #PhaROSTypeMarshallingBaseTest,
	#instVars : [
		'type'
	],
	#category : #'PhaROSTest-Types'
}

{ #category : #accessing }
PhaROSCompositeTypeTest >> expectedFailures [
	^ #( testFailSerialize testSerialize testUnserialize )
]

{ #category : #'tests - parametrization' }
PhaROSCompositeTypeTest >> invalidByteArrays [
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
PhaROSCompositeTypeTest >> invalidValues [ 
	^ {
		-128 .   'a string' .  -1 . 4294967296 . (Duration seconds: 4294967298) 
	}.

]

{ #category : #accessing }
PhaROSCompositeTypeTest >> newTestedClassInstance [
	^ self relatedClass new 
]

{ #category : #'tests - parametrization' }
PhaROSCompositeTypeTest >> relatedClass [ 
	^ type relatedClass.
]

{ #category : #running }
PhaROSCompositeTypeTest >> setUp [ 

	type := PhaROSType composite: {
				#float32 -> PhaROSFloat32Type new.
				#int32 -> PhaROSInt32Type new .
				#int8 -> PhaROSInt8Type new .
				#uint64Array -> (PhaROSArrayType of: PhaROSUInt64Type ).
				#int64FixedArray -> (PhaROSArrayFixedLenghtType of: 3 of: PhaROSInt64Type ). 
			} named: 'testedType' withConstants:{}.
	
	type relatedClass: (PhaROSCompositeType named: 'testedType').

	validValues := self validValues collect: [
		:assoc |
		(self newTestedClassInstance newPacket value: assoc key; yourself  )-> assoc value.
	].

	invalidValues := self invalidValues collect: [
		:value |
		self newTestedClassInstance newPacket value: value ; yourself.
	].
	
	

	
]

{ #category : #running }
PhaROSCompositeTypeTest >> tearDown [
	PhaROSCompositeType remove: 'testedType'.
]

{ #category : #tests }
PhaROSCompositeTypeTest >> testFailSerialize [
	^ super baseFailSerialize.
		
]

{ #category : #tests }
PhaROSCompositeTypeTest >> testSerialize [
	^ super baseSerialize.
		
]

{ #category : #tests }
PhaROSCompositeTypeTest >> testUnserialize [
	^ super baseUnserialize.
		
]

{ #category : #'tests - parametrization' }
PhaROSCompositeTypeTest >> validValues [ 	
	^{
		(self newTestedClassInstance float32: 2.0; int32: 1; int8: -1; uint64Array: { 0 . 0 };  int64FixedArray: { -1 . 0 . 1 }; yourself ) -> 
		#[53 0 0 0 0 0 0 64 1 0 0 0 255 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0]
	
	}
]
