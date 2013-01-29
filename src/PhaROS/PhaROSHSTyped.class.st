Class {
	#name : #PhaROSHSTyped,
	#superclass : #PhaROSHSMessage,
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #verification }
PhaROSHSTyped >> digestMD5FromType [ 
	| md5 |
	" The following line got for result a number in hexa as string with the base specified as a header (16r) "
	md5 := (MD5 hashMessage: self type) asInteger hex.
	self md5Sum: (md5 copyFrom: 4 to: md5 size).
	
	
	
]

{ #category : #accessing }
PhaROSHSTyped >> type [
	^self at: 'type'.
		

]

{ #category : #accessing }
PhaROSHSTyped >> type: aString [
	^self at: 'type' put: aString.
		

]

{ #category : #verification }
PhaROSHSTyped >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#md5Sum -> ByteString .
			#type -> ByteString
		} asDictionary
	); yourself.
]
