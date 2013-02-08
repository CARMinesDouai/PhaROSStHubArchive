Class {
	#name : #PureEncoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Pure-Messages'
}

{ #category : #'as yet unclassified' }
PureEncoder class >> for: aStream [
	^ self new stream: aStream ; yourself .
]

{ #category : #'as yet unclassified' }
PureEncoder class >> forArray: anArray [
	^ self new stream: (WriteStream on: anArray) ; yourself .
]

{ #category : #accessing }
PureEncoder >> contents [
	self flush.
	^ stream contents.
]

{ #category : #encoding }
PureEncoder >> encodeHexString: aString [

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
PureEncoder >> encodeInt8: anInteger [

 | hex |
	
	
	hex := anInteger hex .
	hex := hex copyFrom: 4 to: hex size.
	anInteger < 16 ifTrue: [
		hex := '0', hex.
	].
	
	stream nextPutAll: hex.
	


]

{ #category : #encoding }
PureEncoder >> encodeUInt64: aNumber [
	| hex |

	hex := aNumber printStringBase: 16.
	
	hex := ('0000000000000000' copyFrom: 1 to:( 16 - hex size )), hex.
	
	stream nextPutAll: hex reversed.
	


]

{ #category : #encoding }
PureEncoder >> encodefloat32: aFloat [

	| result |
	
	
	aFloat = 0.0 ifTrue: [
		result := '00000000'.
	] ifFalse: [
		result := (ByteArray readHexFrom: (aFloat asFloat asIEEE32BitWord printStringBase: 16) ) reversed hex  .	
	].
	
	stream nextPutAll: result.
	


]

{ #category : #encoding }
PureEncoder >> encodefloat64: float [


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
PureEncoder >> flush [
	stream flush.
]

{ #category : #encoding }
PureEncoder >> nextPutString: aString [

	stream nextPutAll: aString.

]

{ #category : #accessing }
PureEncoder >> stream [ 
	^ stream .
]

{ #category : #accessing }
PureEncoder >> stream: aStream [
	stream := aStream.
]
