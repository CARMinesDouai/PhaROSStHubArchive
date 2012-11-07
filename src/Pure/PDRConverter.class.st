Class {
	#name : #PDRConverter,
	#superclass : #Object,
	#category : #'Pure-Kernel'
}

{ #category : #convertingFromNumber }
PDRConverter class >> as32BitsHexStringFromFloat: aFloat [
	| tempHexString tempResult compteur result |
	(aFloat=0.0)ifTrue: [^ '00000000'].
	tempHexString := aFloat asFloat asIEEE32BitWord hex asString.
	tempResult := ByteString new:8.
	compteur:=1.
	tempResult do:[:token| 
		tempResult at: compteur put: (tempHexString at: (compteur+3) ).
		compteur:=compteur+1.].
	result:=ByteString new:8.
	result at:1 put: (tempResult at:7).
	result at:2 put: (tempResult at:8).
	result at:3 put: (tempResult at:5).
	result at:4 put: (tempResult at:6).
	result at:5 put: (tempResult at:3).
	result at:6 put: (tempResult at:4).
	result at:7 put: (tempResult at:1).
	result at:8 put: (tempResult at:2).
	^result.
	
]

{ #category : #convertingFromNumber }
PDRConverter class >> as64BitsHexStringFromFloat: aFloat [
	| tempHexString tempResult compteur result |
	(aFloat=0.0)ifTrue: [^ '0000000000000000' ].
	tempHexString := aFloat asFloat asIEEE32BitWord hex asString.
	tempResult := ByteString new:16.
	compteur:=1.
	tempResult do:[:token| 
		tempResult at: compteur put: (tempHexString at: (compteur+3) ).
		compteur:=compteur+1.].
	result:= tempResult reversed.
	^result.
	
]

{ #category : #convertingFromNumber }
PDRConverter class >> as8BitsHexStringFromInteger: anInteger [
	
	| tempHexString result compteur|
	(anInteger=0)ifTrue: [^ '00'].
	(anInteger<10)ifTrue: [^ ('0',anInteger asString)].
	tempHexString := anInteger hex.
	(anInteger<16)ifTrue: [
		result := ByteString new:2.
		result at: 2 put: (tempHexString at: 4).
		result at:1 put: ('0' at:1) .
		^result
		].
	result := ByteString new:2.
	compteur:=1.
	result do:[:token| 
		result at: compteur put: (tempHexString at: (compteur+3) ).
		compteur:=compteur+1.].
	^result
	
	
]

{ #category : #convertingFromArray }
PDRConverter class >> asFloat32FromDataArray: aDataArray fromIndex: start [
	|  floatResult |
	
	floatResult := (ByteArray readHexFrom: ((aDataArray at: start), (aDataArray at: start+1), (aDataArray at: start+2), (aDataArray at: start+3)))floatAt: 1 bigEndian: false.
	^floatResult. 
]

{ #category : #convertingFromArray }
PDRConverter class >> asFloat64FromDataArray: aDataArray fromIndex: start [
	|  floatResult |
	
	floatResult := (ByteArray readHexFrom: ((aDataArray at: start), (aDataArray at: start+1), (aDataArray at: start+2), (aDataArray at: start+3),(aDataArray at: start+4), (aDataArray at: start+5), (aDataArray at: start+6), (aDataArray at: start+7)))doubleAt: 1 bigEndian: false.
	^floatResult. 
]

{ #category : #convertingFromHexString }
PDRConverter class >> asHexArrayFromString: aString [
	| correction index tableau |
	tableau:= ByteArray readHexFrom: aString.
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
		^correction
]

{ #category : #convertingFromArray }
PDRConverter class >> asInt16FromDataArray: aDataArray fromIndex: start [
	|  floatResult |
	
	floatResult := (ByteArray readHexFrom: ((aDataArray at: start), (aDataArray at: start+1)))shortAt: 1 bigEndian: false.
	^floatResult. 
]

{ #category : #convertingFromArray }
PDRConverter class >> asInt32FromDataArray: aDataArray fromIndex: start [
	|  floatResult |
	
	floatResult := (ByteArray readHexFrom: ((aDataArray at: start), (aDataArray at: start+1), (aDataArray at: start+2), (aDataArray at: start+3)))longAt: 1 bigEndian: false.
	^floatResult. 
]

{ #category : #convertingFromArray }
PDRConverter class >> asUnsignedInt16FromDataArray: aDataArray fromIndex: start [
	|  intResult |
	
	intResult := (ByteArray readHexFrom: (aDataArray at: start),(aDataArray at: start+1))unsignedShortAt: 1 bigEndian: false.
	^intResult. 
]
