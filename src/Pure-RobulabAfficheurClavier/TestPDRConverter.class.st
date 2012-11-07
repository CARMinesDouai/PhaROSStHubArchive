"
Les tests de la cette classe sont basés sur les conversions obtenues sur le site
www.binaryconvert.com
"
Class {
	#name : #TestPDRConverter,
	#superclass : #TestCase,
	#category : #'Pure-Robulab'
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
	| aDataArray |
	aDataArray := PDRConverter asHexArrayFromString: '0000000000000000'.
	self assert: ((PDRConverter  asFloat64FromDataArray: aDataArray fromIndex: 1) = 0.0 ).
	aDataArray := PDRConverter asHexArrayFromString: '182D4454FB210940'.
	self assert: ((PDRConverter  asFloat64FromDataArray: aDataArray fromIndex: 1) > (3.14 -0.01) ).
	self assert: ((PDRConverter  asFloat64FromDataArray: aDataArray fromIndex: 1) < (3.14 +0.01) ).
	aDataArray := PDRConverter asHexArrayFromString: '77BE9F1A2FDD5E40'.
	self assert: ((PDRConverter  asFloat64FromDataArray: aDataArray fromIndex: 1) > (123.456 -0.01) ).
	self assert: ((PDRConverter  asFloat64FromDataArray: aDataArray fromIndex: 1) < (123.456 +0.01) ).
]

{ #category : #'Test PDRConverter' }
TestPDRConverter >> testAsHexStringFromFloat32 [
	self assert:( (PDRConverter as32BitsHexStringFromFloat:0) = '00000000').
	self assert:( (PDRConverter as32BitsHexStringFromFloat:1) = '0000803F').
	self assert:( (PDRConverter as32BitsHexStringFromFloat: -1) = '000080BF').
	
]

{ #category : #'as yet unclassified' }
TestPDRConverter >> testAsInt16FromDataArray [
	| aDataArray |
	aDataArray := PDRConverter asHexArrayFromString: '0000'.
	self assert: ((PDRConverter  asInt16FromDataArray: aDataArray fromIndex: 1) = 0.0 ).
	aDataArray := PDRConverter asHexArrayFromString: '7B00'.
	self assert: ((PDRConverter  asInt16FromDataArray: aDataArray fromIndex: 1) = 123) .
	aDataArray := PDRConverter asHexArrayFromString: '85FF'.
	self assert: ((PDRConverter  asInt16FromDataArray: aDataArray fromIndex: 1) = -123) .
]

{ #category : #'as yet unclassified' }
TestPDRConverter >> testAsInt32FromDataArray [
	| aDataArray |
	aDataArray := PDRConverter asHexArrayFromString: '00000000'.
	self assert: ((PDRConverter  asInt32FromDataArray: aDataArray fromIndex: 1) = 0.0 ).
	aDataArray := PDRConverter asHexArrayFromString: '1E000000'.
	self assert: ((PDRConverter  asInt32FromDataArray: aDataArray fromIndex: 1) =30 ).
	aDataArray := PDRConverter asHexArrayFromString: 'D2040000'.
	self assert: ((PDRConverter  asInt32FromDataArray: aDataArray fromIndex: 1) =1234 ).
	aDataArray := PDRConverter asHexArrayFromString: '3041AB00'.
	self assert: ((PDRConverter  asInt32FromDataArray: aDataArray fromIndex: 1) =11223344 ).
]

{ #category : #'as yet unclassified' }
TestPDRConverter >> testAsUnsignedInt16FromDataArray [
	| aDataArray |
	aDataArray := PDRConverter asHexArrayFromString: '0000'.
	self assert: ((PDRConverter  asUnsignedInt16FromDataArray: aDataArray fromIndex: 1) = 0.0 ).
	aDataArray := PDRConverter asHexArrayFromString: '7B00'.
	self assert: ((PDRConverter  asUnsignedInt16FromDataArray: aDataArray fromIndex: 1) = 123) .
	aDataArray := PDRConverter asHexArrayFromString: 'E110'.
	self assert: ((PDRConverter  asUnsignedInt16FromDataArray: aDataArray fromIndex: 1) = 4321) .
]
