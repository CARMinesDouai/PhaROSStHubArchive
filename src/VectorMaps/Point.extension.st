Extension { #name : #Point }

{ #category : #'*VectorMaps' }
Point >> asVMVertex [
	^ VMGraphVertex point: self
]
