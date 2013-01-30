Class {
	#name : #PhaROSDecoderTests,
	#superclass : #TestCase,
	#instVars : [
		'decoder'
	],
	#category : #'PhaROS-Encoding-Test'
}

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> setUp [
	decoder := PhaROSDecoder new.
	
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedByte [
	 decoder stream: (ReadStream on: #[ 0 1 ] ).
	 self assert: (decoder nextEncodedByte= 0). 
	 self assert: (decoder nextEncodedByte= 1).
	self should: [ decoder nextEncodedByte ] raise: Error.  
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedDuration [
	"in the stream  { time . time . 1 . 0} "
	 decoder stream: (ReadStream on: #[0 0 0 0 0 0 0 0 160 134 1 0 0 0 0 0 1 0] ).
	 self assert: (decoder nextEncodedDuration= (Duration seconds: 0)). 
	 self assert: (decoder nextEncodedDuration= (Duration seconds: 100000)). 

	self should: [ decoder nextEncodedDuration ] raise: Error.  
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedFloat32 [
	" in the stream { float . float . float . float . 1 . 0}"
	decoder stream: (ReadStream on: #[0 0 128 63 0 0 128 191 0 0 0 0 0 0 64 64 1 0] ).
	self assert: (decoder nextEncodedFloat32= 1.0 ). 
	self assert: (decoder nextEncodedFloat32= -1.0 ).
	self assert: (decoder nextEncodedFloat32= 0.0 ).
	self assert: (decoder nextEncodedFloat32= 3.0 ).

	self should: [decoder nextEncodedFloat32] raise: Error.
	

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedFloat64 [
	
	" in the stream { float . float . float . float . 1 . 0 . 0 . 0}"
	 decoder stream: (ReadStream on: #[0 0 0 0 0 0 240 63 0 0 0 0 0 0 240 191 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8 64 1 0 0 0 ] ).
	
	
	self assert: (decoder nextEncodedFloat64= 1.0 ). 
	self assert: (decoder nextEncodedFloat64= -1.0 ).
	self assert: (decoder nextEncodedFloat64= 0.0 ).
	self assert: (decoder nextEncodedFloat64= 3.0 ).

	self should: [decoder nextEncodedFloat64] raise: Error.
	

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt16 [
	" in stream { int16 . int16. int16.  1}".
	
	 decoder stream: (ReadStream on: #[1 0 0 0 255 255 1] ).
	
	 self assert: (decoder nextEncodedInt16= 1). 
	 self assert: (decoder nextEncodedInt16= 0). 
	 self assert: (decoder nextEncodedInt16= -1). 

	self should: [decoder nextEncodedInt16] raise: Error.

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt32 [
	" in the stream { int32 . int32 . int32 . 1 . 0 . 0}"
	 decoder stream: (ReadStream on: #[ 1 0 0 0 0 0 0 0 255 255 255 255 1 0 0 ] ).

	 self assert: (decoder nextEncodedInt32 = 1). 
	 self assert: (decoder nextEncodedInt32= 0). 
	 self assert: (decoder nextEncodedInt32= -1). 

	 self should: [decoder nextEncodedInt32] raise: Error.

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt64 [
	" in the stream { int32 . int32 . int32 . 1 . 0 . 0}"
	 decoder stream: (ReadStream on: #[ 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255 1 0 0 ] ).

	 self assert: (decoder nextEncodedInt64 = 1). 
	 self assert: (decoder nextEncodedInt64= 0). 
	 self assert: (decoder nextEncodedInt64= -1). 

	 self should: [decoder nextEncodedInt64] raise: Error.

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt8 [
	decoder stream: (ReadStream on: #[ 1 2 3 4] ).
	self assert: (decoder nextEncodedInt8= 1). 
	self assert: (decoder nextEncodedInt8= 2).
	self assert: (decoder nextEncodedInt8= 3).
	self assert: (decoder nextEncodedInt8= 4).
	
	 self should: [decoder nextEncodedInt8] raise: Error.
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedString [
	" in the stream { string([size|content]) . 6 0 0 0 }"
	 decoder stream: (ReadStream on: #[6 0 0 0 83 84 82 73 78 71 6 0 0 0] ).
	 self assert: (decoder nextEncodedString= 'STRING'). 
	
	 self should: [decoder nextEncodedString] raise: Error.
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedTime [
	 decoder stream: (ReadStream on: #[0 0 0 0 0 0 0 0 255 227 11 84 0 0 0 0] ).
	 self assert: (decoder nextEncodedTime = PhaROSTimestamp new).
	 self assert: (decoder nextEncodedTime = PhaROSTimestamp new + (Duration seconds: 9999999999)).

	 self should: [decoder nextEncodedTime] raise: Error.

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint16 [
	 decoder stream: (ReadStream on: #[1 0 0 0 255 255] ).
	
	 self assert: (decoder nextEncodedUint16 = 1). 
	 self assert: (decoder nextEncodedUint16 = 0). 
	 self assert: (decoder nextEncodedUint16 = 65535). 
	 self should: [decoder nextEncodedUint16] raise: Error.
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint32 [
       decoder stream: (ReadStream on: #[1 0 0 0 0 0 0 0 255 255 255 255] ).
	
	 self assert: (decoder nextEncodedUint32 = 1). 
	 self assert: (decoder nextEncodedUint32 = 0). 
	 self assert: (decoder nextEncodedUint32 = 4294967295). 
	 self should: [decoder nextEncodedUint32] raise: Error.
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint64 [
      decoder stream: (ReadStream on: #[1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255] ).
	
	 self assert: (decoder nextEncodedUint64 = 1). 
	 self assert: (decoder nextEncodedUint64 = 0). 
	 self assert: (decoder nextEncodedUint64 = 18446744073709551615). 
	 self should: [decoder nextEncodedUint64] raise: Error.
]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint8 [
	 decoder stream: (ReadStream on: #[ 0 1 ] ).
	 self assert: (decoder nextEncodedUint8= 0). 
	 self assert: (decoder nextEncodedUint8= 1).
	self should: [ decoder nextEncodedUint8 ] raise: Error.  

]
