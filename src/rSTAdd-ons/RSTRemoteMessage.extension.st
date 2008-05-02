Extension { #name : #RSTRemoteMessage }

{ #category : #'*rSTAdd-ons' }
RSTRemoteMessage >> printOn: aStream [
	aStream nextPutAll: to asString.
	aStream nextPutAll: '>>'.
	args isEmpty ifTrue: [^ aStream nextPutAll: selector printString].
	args with: selector keywords do: [:arg :word |
		aStream nextPutAll: word printString.
		aStream space.
		arg printOn: aStream.
		aStream space.
	].
	aStream skip: -1.
]
