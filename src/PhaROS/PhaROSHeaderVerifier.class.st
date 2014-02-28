Class {
	#name : #PhaROSHeaderVerifier,
	#superclass : #Object,
	#category : #'PhaROS-Network-Tcp-Encoding'
}

{ #category : #'as yet unclassified' }
PhaROSHeaderVerifier >> verificationDictionaryFor: aTcpMessage [ 
	^ aTcpMessage class verificationDictionary.
]

{ #category : #'as yet unclassified' }
PhaROSHeaderVerifier >> verify: aTcpMessage [
	aTcpMessage header size = 0 ifTrue: [ ^ self ].
	
	aTcpMessage md5Sum ifNil:[ 
		"Bug? Feature? Sometimes things come with nil "
		aTcpMessage md5Sum: ''.
	].
	^
	(self verificationDictionaryFor: aTcpMessage ) keysAndValuesDo: [ :key :val | 
		self assert: [ (aTcpMessage perform: key asSymbol ) class = val ]
	].
	
]
