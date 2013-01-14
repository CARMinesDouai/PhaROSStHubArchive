Class {
	#name : #TestPureDecoder,
	#superclass : #TestCase,
	#category : #'Pure-Tests-RobotIndependent'
}

{ #category : #'as yet unclassified' }
TestPureDecoder >> testAsFloat64FromDataArray [
	| decoder val |

	decoder := PureDecoder for: (ReadStream on: (ByteArray readHexFrom: '0000000000000000')).
		
	self assert: (decoder nextEncodedFloat64 = 0.0 ).
	
	
	decoder := PureDecoder for: (ReadStream on: (ByteArray readHexFrom:  '182D4454FB210940')).
	val := decoder nextEncodedFloat64.
	self assert:  val > (3.14 -0.01) .
	self assert:  val < (3.14 +0.01) .
	
	decoder := PureDecoder for: (ReadStream on: (ByteArray readHexFrom:   '77BE9F1A2FDD5E40')).
	val := decoder nextEncodedFloat64.
	self assert: val > (123.456 -0.01) .
	self assert: val < (123.456 +0.01).
	














]

{ #category : #'as yet unclassified' }
TestPureDecoder >> testAsInt16FromDataArray [
	| decoder |
	
	decoder := PureDecoder for: ( ReadStream on:  (ByteArray readHexFrom:  '0000')).
	self assert: decoder nextEncodedInt16 = 0.0.
	decoder := PureDecoder for: ( ReadStream on: (ByteArray readHexFrom:   '7B00')).
	self assert: decoder nextEncodedInt16 = 123.
	decoder := PureDecoder for: ( ReadStream on: (ByteArray readHexFrom:  '85FF')).
	self assert: decoder nextEncodedInt16 = -123.
]

{ #category : #'as yet unclassified' }
TestPureDecoder >> testAsInt32FromDataArray [
	| decoder |

	decoder := PureDecoder for: ( ReadStream on:(ByteArray readHexFrom:  '00000000')).
	self assert: decoder nextEncodedInt32 = 0.0 .
	
	decoder := PureDecoder for: ( ReadStream on:(ByteArray readHexFrom:   '1E000000')).
	self assert: decoder nextEncodedInt32  =30.
	
	decoder := PureDecoder for: ( ReadStream on:(ByteArray readHexFrom:  'D2040000')).
	self assert: decoder nextEncodedInt32 = 1234.
	
	decoder := PureDecoder for: ( ReadStream on:(ByteArray readHexFrom:  '3041AB00')).
	self assert: decoder nextEncodedInt32  = 11223344 .
]

{ #category : #'as yet unclassified' }
TestPureDecoder >> testAsUnsignedInt16FromDataArray [
	| decoder |

	decoder := PureDecoder for: ( ReadStream on:(ByteArray readHexFrom:  '0000')).
	self assert: decoder nextEncodedUInt16 = 0.0.

	decoder := PureDecoder for: ( ReadStream on:(ByteArray readHexFrom:  '7B00')).
	self assert: decoder nextEncodedUInt16  = 123.
	
	decoder := PureDecoder for: ( ReadStream on:(ByteArray readHexFrom:  'E110')).
	self assert: decoder nextEncodedUInt16  = 4321.
]
