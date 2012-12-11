Class {
	#name : #PhaROSTypedHandShakeMessage,
	#superclass : #PhaROSHandShakeMessage,
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #verification }
PhaROSTypedHandShakeMessage >> digestMD5FromType [ 
	| md5 |
	" The following line got for result a number in hexa as string with the base specified as a header (16r) "
	md5 := (MD5 hashMessage: self type) asInteger hex.
	self md5Sum: (md5 copyFrom: 4 to: md5 size).
	
	
	
]

{ #category : #accessing }
PhaROSTypedHandShakeMessage >> type [
	^self at: 'type'.
		

]

{ #category : #accessing }
PhaROSTypedHandShakeMessage >> type: aString [
	^self at: 'type' put: aString.
		

]

{ #category : #verification }
PhaROSTypedHandShakeMessage >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#md5Sum -> ByteString .
			#type -> ByteString
		} asDictionary
	); yourself.
]
