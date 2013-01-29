Class {
	#name : #PhaROSEncoderTests,
	#superclass : #TestCase,
	#instVars : [
		'encoder'
	],
	#category : #'PhaROS-Encoding-Test'
}

{ #category : #setup }
PhaROSEncoderTests >> setUp [
	encoder := PhaROSEncoder new.
	
]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeBoolean [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeBoolean:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeByte [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeByte:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeBytes [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeBytes:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeDuration [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeDuration:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt16 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeInt16:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt32 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeInt32:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt64 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeInt64:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeInt8 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeInt8:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeString [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeString:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeTime [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeTime:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint16 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeUint16:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint32 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeUint32:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint64 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeUint64:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodeUint8 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodeUint8:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodefloat32 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodefloat32:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testEncodefloat64 [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder encodefloat64:nil = nil). 

]

{ #category : #tests }
PhaROSEncoderTests >> testStream [
	 encoder stream: (WriteStream on: ByteArray new: 20 )
	 self assert: (encoder stream:nil = nil). 

]
