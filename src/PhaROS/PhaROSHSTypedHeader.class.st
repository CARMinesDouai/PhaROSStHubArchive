Class {
	#name : #PhaROSHSTypedHeader,
	#superclass : #PhaROSHSMessageHeader,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #verification }
PhaROSHSTypedHeader class >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#md5Sum -> ByteString .
			#type -> ByteString
		} asDictionary
	); yourself.
]

{ #category : #accessing }
PhaROSHSTypedHeader >> type [
	^self at: 'type'.
		

]

{ #category : #accessing }
PhaROSHSTypedHeader >> type: aString [
	^self at: 'type' put: aString.
		

]
