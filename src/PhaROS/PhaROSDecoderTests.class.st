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
PhaROSDecoderTests >> testMinimumPrecision [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder minimumPrecision= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedByte [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedByte= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedDuration [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedDuration= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedFloat32 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedFloat32= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedFloat64 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedFloat64= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt16 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedInt16= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt32 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedInt32= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt64 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedInt64= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedInt8 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedInt8= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedString [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedString= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedTime [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedTime= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint16 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedUint16= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint32 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedUint32= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint64 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedUint64= nil). 

]

{ #category : #'as yet unclassified' }
PhaROSDecoderTests >> testNextEncodedUint8 [
	 decoder stream: (ReadStream on: #() )
	 self assert: (decoder nextEncodedUint8= nil). 

]
