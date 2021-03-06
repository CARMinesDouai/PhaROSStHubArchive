Class {
	#name : #PhaROSEncoderTests,
	#superclass : #TestCase,
	#instVars : [
		'encoder'
	],
	#category : #'PhaROSTest-Encoding'
}

{ #category : #setup }
PhaROSEncoderTests >> setUp [
	encoder := PhaROSEncoder new.
	
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeBoolean [
	 
			| buffer |
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeBoolean: true.
			encoder flush.
			self assert: (buffer = #[1]).
			
			
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeBoolean: false.
			encoder flush.
			self assert: (buffer = #[0])
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeByte [
	 
			| buffer |
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeByte: 0.
			encoder flush.
			self assert: (buffer = #[0]).
		
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeBytes [
	 
			| buffer |
			buffer := ByteArray new: 2.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeBytes: #[ 1 0 ].
			encoder flush.
			self assert: (buffer = #[ 1 0 ]).
		
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeDuration [
	 
			| buffer |
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeDuration: (Duration seconds: 0).
			encoder flush.
			self assert: (buffer = #[0 0 0 0 0 0 0 0]).
		
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeDuration: (Duration seconds: 100000).
			encoder flush.
			self assert: (buffer = #[160 134 1 0 0 0 0 0]).
		
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt16 [
	 
			| buffer |
			buffer := ByteArray new: 2.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt16: 1.
			encoder flush.
			self assert: (buffer = #[1 0]).
		
			buffer := ByteArray new: 2.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt16: 0.
			encoder flush.
			self assert: (buffer = #[0 0]).
		
			buffer := ByteArray new: 2.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt16: -1.
			encoder flush.
			self assert: (buffer = #[255 255]).
			
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt32 [
	 
			| buffer |
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt32: 1.
			encoder flush.
			self assert: (buffer = #[ 1 0 0 0 ]).
		
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt32: 0.
			encoder flush.
			self assert: (buffer = #[ 0 0 0 0 ]).
			
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt32: -1.
			encoder flush.
			self assert: (buffer = #[255 255 255 255]).
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt64 [

	 
			| buffer |
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt64: 1.
			encoder flush.
			self assert: (buffer = #[ 1 0 0 0 0 0 0 0 ]).
		
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt64: 0.
			encoder flush.
			self assert: (buffer = #[ 0 0 0 0 0 0 0 0 ]).
			
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt64: -1.
			encoder flush.
			self assert: (buffer = #[255 255 255 255 255 255 255 255]).
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt8 [
	 
			| buffer |
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt8: 1.
			encoder flush.
			self assert: (buffer = #[ 1 ]).
		
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt8: 0.
			encoder flush.
			self assert: (buffer = #[ 0 ]).
			
			
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeInt8: -1.
			encoder flush.
			self assert: (buffer = #[ 255 ]).
		
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeString [
	 
			| buffer |
			buffer := ByteArray new: 10.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeString: 'STRING'.
			encoder flush.
			self assert: (buffer = #[6 0 0 0 83 84 82 73 78 71]).
		
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeTime [
	| buffer |

	buffer := ByteArray new: 8.
	encoder stream: (WriteStream on: buffer).
			
	encoder encodeTime:  PhaROSTimestamp new.
	encoder flush.
	self assert: (buffer = #[0 0 0 0 0 0 0 0]).
		
	buffer := ByteArray new: 8.
	encoder stream: (WriteStream on: buffer).
		
	encoder encodeTime:  (PhaROSTimestamp new + (Duration seconds: 99999999)).
	encoder flush.
	self assert: (buffer = #[255 224 245 5 0 0 0 0]).
		
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint16 [
	 
			| buffer |
			buffer := ByteArray new: 2.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint16: 1.
			encoder flush.
			self assert: (buffer = #[1 0]).
		
			buffer := ByteArray new: 2.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint16: 0.
			encoder flush.
			self assert: (buffer = #[0 0]).
		
			buffer := ByteArray new: 2.
			encoder stream: (WriteStream on: buffer).
			
			self should: [
				encoder encodeUint16: -1.
			] raise: Error.
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint32 [
	 
			| buffer |
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint32: 1.
			encoder flush.
			self assert: (buffer = #[ 1 0 0 0 ]).
		
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint32: 0.
			encoder flush.
			self assert: (buffer = #[ 0 0 0 0 ]).
			
			
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			
			self should: [
				encoder encodeUint32: 9999999999.
			] raise: Error.
			

			
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			self should: [
				encoder encodeUint32: -1.
			] raise: Error.


]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint64 [
		 	| buffer |
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint64: 1.
			encoder flush.
			self assert: (buffer = #[ 1 0 0 0 0 0 0 0 ]).
		
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint64: 0.
			encoder flush.
			self assert: (buffer = #[ 0 0 0 0 0 0 0 0 ]).
			
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			self should: [
				encoder encodeUint64: -1.	
			] raise: Error.
			

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint8 [
	 
			| buffer |
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint8: 1.
			encoder flush.
			self assert: (buffer = #[ 1 ]).
		
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodeUint8: 0.
			encoder flush.
			self assert: (buffer = #[ 0 ]).
			
			
			buffer := ByteArray new: 1.
			encoder stream: (WriteStream on: buffer).
			
			self should: [
				encoder encodeUint8: -1.
			] raise: Error.	
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodefloat32 [
	 
			| buffer |
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat32: 1.0.
			encoder flush.
			self assert: (buffer = #[0 0 128 63]).
		
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat32: -1.0.
			encoder flush.
			self assert: (buffer = #[0 0 128 191]).
		
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat32: 0.0.
			encoder flush.
			self assert: (buffer = #[0 0 0 0]).
			
			buffer := ByteArray new: 4.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat32: 3.
			encoder flush.
			self assert: (buffer = #[0 0 64 64]).
		
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodefloat64 [
	 
			| buffer |
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat64: 1.0.
			encoder flush.
			self assert: (buffer = #[0 0 0 0 0 0 240 63]).
		
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat64: -1.0.
			encoder flush.
			self assert: (buffer = #[0 0 0 0 0 0 240 191]).
		
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat64: 0.0.
			encoder flush.
			self assert: (buffer = #[0 0 0 0 0 0 0 0]).
			
			buffer := ByteArray new: 8.
			encoder stream: (WriteStream on: buffer).
			
			encoder encodefloat64: 3.
			encoder flush.
			self assert: (buffer = #[0 0 0 0 0 0 8 64]).
		
]
