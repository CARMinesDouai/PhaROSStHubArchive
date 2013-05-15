Class {
	#name : #PhaROSHSTyped,
	#superclass : #PhaROSHSMessage,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #verification }
PhaROSHSTyped class >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#md5Sum -> ByteString .
			#type -> ByteString
		} asDictionary
	); yourself.
]

{ #category : #accessing }
PhaROSHSTyped >> type [
	^self at: 'type'.
		

]

{ #category : #accessing }
PhaROSHSTyped >> type: aString [
	^self at: 'type' put: aString.
		

]
