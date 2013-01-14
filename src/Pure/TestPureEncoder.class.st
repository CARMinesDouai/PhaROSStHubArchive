"
Les tests de la cette classe sont basés sur les conversions obtenues sur le site
www.binaryconvert.com
"
Class {
	#name : #TestPureEncoder,
	#superclass : #TestCase,
	#category : #'Pure-Tests-RobotIndependent'
}

{ #category : #'as yet unclassified' }
TestPureEncoder class >> hexArrayFromString: aString [
| array |

	array := (ByteArray readHexFrom: aString) asOrderedCollection.
	
	^ (array collect: [ :n | (n < 16 ifTrue: ['0'] ifFalse:['']), (n printStringBase: 16).  ]) asByteArray.
]

{ #category : #'Test PDRConverter' }
TestPureEncoder >> testAs8BitsHexStringFromInteger [
	| encoder |
	
	
	
	encoder := PureEncoder forArray: (String new:2).
	encoder encodeInt8: 1.
	self assert:( encoder contents  = '01').

	encoder := PureEncoder forArray: (String new:2).
	encoder encodeInt8: 0.
	self assert:( encoder contents  = '00').
	
	encoder := PureEncoder forArray: (String new:2).
	encoder encodeInt8: 10.
	self assert:( encoder contents  = '0A').
	
	
	encoder := PureEncoder forArray: (String new:2).
	encoder encodeInt8: 16.
	self assert:( encoder contents  = '10').
	

]

{ #category : #'Test PDRConverter' }
TestPureEncoder >> testAsHexStringFromFloat32 [
	|  encoder |
	


	encoder := PureEncoder forArray: (String new: 8).
	encoder encodefloat32: 0.
	self assert:(encoder contents = '00000000').	
		
	encoder := PureEncoder forArray: (String new: 8).
	
	
	encoder encodefloat32: 1.
	
	self assert:(encoder contents = '0000803f' ).	

	encoder := PureEncoder forArray: (String new: 8).
	encoder encodefloat32: -1.
	self assert:(encoder contents = '000080bf').	


]

{ #category : #'Test PDRConverter' }
TestPureEncoder >> testAsHexStringFromFloat64 [
	|  encoder |
	


	encoder := PureEncoder forArray: (String new: 16).
	encoder encodefloat64: 0.
	self assert:(encoder contents = '00000000000000000000000000000000').	
		
	encoder := PureEncoder forArray: (String new: 16).
	
	
	encoder encodefloat64: 1.

	self assert:(encoder contents = '000000000000f03f0000000000000000' ).	

	encoder := PureEncoder forArray: (String new: 16).
	encoder encodefloat64: -1.
	self assert:(encoder contents = '000000000000f0bf0000000000000000').	


]
