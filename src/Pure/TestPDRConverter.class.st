"
Les tests de la cette classe sont basés sur les conversions obtenues sur le site
www.binaryconvert.com
"
Class {
	#name : #TestPDRConverter,
	#superclass : #TestCase,
	#category : #'Pure-Tests-RobotIndependent'
}

{ #category : #'Test PDRConverter' }
TestPDRConverter >> testAs8BitsHexStringFromInteger [
	self assert:( (PDRConverter as8BitsHexStringFromInteger:0) = '00').
	self assert:( (PDRConverter as8BitsHexStringFromInteger:1) = '01').
	self assert:(  ((PDRConverter as8BitsHexStringFromInteger: 10))  = '0A').
	self assert:( (PDRConverter as8BitsHexStringFromInteger:16) = '10').
]

{ #category : #'as yet unclassified' }
TestPDRConverter >> testAsFloat64FromDataArray [
	| decoder val |

	decoder := PureDecoder for: (ReadStream on: (ByteArray readHexFrom: (PDRConverter asHexArrayFromString: '0000000000000000'))).
		
	self assert: (decoder nextEncodedFloat64 = 0.0 ).
	
	
	decoder := PureDecoder for: (ReadStream on: (PDRConverter asHexArrayFromString: '182D4454FB210940')).
	val := decoder nextEncodedFloat64.
	self assert:  val > (3.14 -0.01) .
	self assert:  val < (3.14 +0.01) .
	decoder := PureDecoder for: (ReadStream on: (PDRConverter asHexArrayFromString: '77BE9F1A2FDD5E40')).
	val := decoder nextEncodedFloat64.
	self assert: val > (123.456 -0.01) .
	self assert: val < (123.456 +0.01).
	














]

{ #category : #'Test PDRConverter' }
TestPDRConverter >> testAsHexStringFromFloat32 [
	self assert:( (PDRConverter as32BitsHexStringFromFloat:0) = '00000000').
	self assert:( (PDRConverter as32BitsHexStringFromFloat:1) = '0000803F').
	self assert:( (PDRConverter as32BitsHexStringFromFloat: -1) = '000080BF').
	
]

{ #category : #'as yet unclassified' }
TestPDRConverter >> testAsInt16FromDataArray [
	| decoder |
	
	decoder := PureDecoder for: ( ReadStream on:  (PDRConverter asHexArrayFromString:'0000')).

	self assert: decoder nextEncodedInt16 = 0.0.
	decoder := PureDecoder for: ( ReadStream on: (PDRConverter asHexArrayFromString: '7B00')).
	self assert: decoder nextEncodedInt16 = 123.
	decoder := PureDecoder for: ( ReadStream on: (PDRConverter asHexArrayFromString: '85FF')).
	self assert: decoder nextEncodedInt16 = -123.
]

{ #category : #'as yet unclassified' }
TestPDRConverter >> testAsInt32FromDataArray [
	| decoder |

	decoder := PureDecoder for: ( ReadStream on:(PDRConverter asHexArrayFromString: '00000000')).
	self assert: decoder nextEncodedInt32 = 0.0 .
	
	decoder := PureDecoder for: ( ReadStream on:(PDRConverter asHexArrayFromString: '1E000000')).
	self assert: decoder nextEncodedInt32  =30.
	
	decoder := PureDecoder for: ( ReadStream on:(PDRConverter asHexArrayFromString: 'D2040000')).
	self assert: decoder nextEncodedInt32 =1234.
	
	decoder := PureDecoder for: ( ReadStream on:(PDRConverter asHexArrayFromString: '3041AB00')).
	self assert: decoder nextEncodedInt32  =11223344 .
]

{ #category : #'as yet unclassified' }
TestPDRConverter >> testAsUnsignedInt16FromDataArray [
	| decoder |

	decoder := PureDecoder for: ( ReadStream on:(PDRConverter asHexArrayFromString: '0000')).
	self assert: decoder nextEncodedUInt16 = 0.0.

	decoder := PureDecoder for: ( ReadStream on:(PDRConverter asHexArrayFromString: '7B00')).
	self assert: decoder nextEncodedUInt16  = 123.
	
	decoder := PureDecoder for: ( ReadStream on:(PDRConverter asHexArrayFromString: 'E110')).
	self assert: decoder nextEncodedUInt16  = 4321.
]
