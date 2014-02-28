Extension { #name : #Float }

{ #category : #'*PhaROS' }
Float class >> fromIEEE32BitByteArray: aByteArray [ 
	^ self fromIEEE32Bit: (LargePositiveInteger fromByteArray: aByteArray ).
]

{ #category : #'*PhaROS' }
Float class >> parameterClass [
	^ Float
]
