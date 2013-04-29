Extension { #name : #Object }

{ #category : #'*PhaROS' }
Object >> \> anAdaption [ 
	^ PhaROSMessageAdapter new \>  self \>  anAdaption.
]

{ #category : #'*PhaROS' }
Object >> adaptToAdapter [ 
	self error: ' Just symbols and classes can be uses as convertions '
]

{ #category : #'*PhaROS' }
Object >> asRoStByteArray [ 
	^self asByteArray 
]

{ #category : #'*PhaROS' }
Object >> isBasic [
	^ true.
]
