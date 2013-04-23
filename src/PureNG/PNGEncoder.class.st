Class {
	#name : #PNGEncoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #accessing }
PNGEncoder >> contents [
	self flush.
	^ stream contents.
]

{ #category : #encoding }
PNGEncoder >> encodeFloat32: aFloat [

	| result |
	
	
	aFloat = 0.0 ifTrue: [
		result := '00000000'.
	] ifFalse: [
		result := (ByteArray readHexFrom: (aFloat asFloat asIEEE32BitWord printStringBase: 16) ) reversed hex  .	
	].
	
	stream nextPutAll: result.
	


]

{ #category : #encoding }
PNGEncoder >> encodeFloat64: float [


	| encoded aFloat |

	aFloat := float asFloat.
	encoded := ByteArray new: 8.
	
	encoded at:1 put: ((aFloat basicAt:2) digitAt: 1).
	encoded at:2 put: ((aFloat basicAt:2) digitAt: 2).
	encoded at:3 put: ((aFloat basicAt:2) digitAt: 3).
	encoded at:4 put: ((aFloat basicAt:2) digitAt: 4).
	
	encoded at:5 put: ((aFloat basicAt:1) digitAt: 1).
	encoded at:6 put: ((aFloat basicAt:1) digitAt: 2).
	encoded at:7 put: ((aFloat basicAt:1) digitAt: 3).
	encoded at:8 put: ((aFloat basicAt:1) digitAt: 4).
	
				
	stream nextPutAll: encoded hex.
	
	


]

{ #category : #encoding }
PNGEncoder >> encodeHexString: aString [

| correction index array |

	array := ByteArray readHexFrom: aString.
	
	^ array collect: [ :n | (n < 16 ifTrue: ['0'] ifFalse:['']), (n printStringBase: 16).  ].
	
	"
	correction := Array  new: (tableau size ) .
	
	
	index :=1.
	tableau do: [:contenu | 
				correction at:index put: ((contenu asInteger )printStringBase:16).
				index:= index+1. 
				].
	index :=1.
	correction := correction do: [:contenu | 
				(contenu size=1) ifTrue: [correction at: index put: ('0',contenu value) asString ]ifFalse: [correction at: index put: (contenu value)asString ] .
				index:= index+1.
			].
	stream nextPutAll: aString.
"
]

{ #category : #encoding }
PNGEncoder >> encodeInt16: anInteger [
 	| hex |
	hex := anInteger printStringBase: 16  nDigits:  4.
	stream nextPutAll: (hex copyFrom: 3 to: 4).
	stream nextPutAll: (hex copyFrom: 1 to: 2).
]

{ #category : #encoding }
PNGEncoder >> encodeInt64: anInteger [
 	| hex |
	hex := anInteger printStringBase: 16  nDigits:  16.
	(2 to: 16 by: 2) reverseDo: [:each|
		stream nextPutAll: (hex copyFrom: each - 1 to: each )
	]
]

{ #category : #encoding }
PNGEncoder >> encodeInt8: anInteger [
 	anInteger printOn: self stream base: 16  nDigits:  2.
	


]

{ #category : #encoding }
PNGEncoder >> flush [
	stream flush.
]

{ #category : #'initialize-release' }
PNGEncoder >> initialize [
	super initialize.
	stream := String new writeStream.
]

{ #category : #'pure codes' }
PNGEncoder >> nextPutDeleteActionCode [
	self nextPutString: '05' "delete code = 0x05"
]

{ #category : #'pure codes' }
PNGEncoder >> nextPutInsertActionCode [
	self nextPutString: '04' "insert code = 0x04"
]

{ #category : #'pure codes' }
PNGEncoder >> nextPutNotificationId [
	self nextPutString: 'FF' "request identifier (not 0x00 or 0xFF)" 
]

{ #category : #'pure codes' }
PNGEncoder >> nextPutReplaceActionCode [
	self nextPutString: '02' "replace code = 0x02"
]

{ #category : #'pure codes' }
PNGEncoder >> nextPutRequestId [
	self nextPutString: '01' "request identifier (not 0x00 or 0xFF)" 
]

{ #category : #encoding }
PNGEncoder >> nextPutString: aString [

	stream nextPutAll: aString.

]

{ #category : #'pure codes' }
PNGEncoder >> nextPutUpdateActionCode [
	self nextPutString: '03' "update code = 0x03"
]

{ #category : #accessing }
PNGEncoder >> stream [ 
	^ stream .
]

{ #category : #accessing }
PNGEncoder >> stream: aStream [
	stream := aStream.
]
