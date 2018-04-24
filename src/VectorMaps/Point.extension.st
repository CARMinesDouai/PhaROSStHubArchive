Extension { #name : #Point }

{ #category : #'*VectorMaps' }
Point >> applyTransform: aVMTFMatrix [
	| tf |
	
	tf := aVMTFMatrix asVMTFMatrix.
	
	^self class x: (
		((tf at: 1 at: 1) * x) + 
		((tf at: 1 at: 2) * y) + 
		(tf at: 1 at: 3)
	) y: (
		((tf at: 2 at: 1) * x) + 
		((tf at: 2 at: 2) * y) + 
		(tf at: 2 at: 3)
	).

]

{ #category : #'*VectorMaps' }
Point >> asDhbVector [
	^(DhbVector new: 2)
		at: 1 put: x;
		at: 2 put: y;
		yourself.
]

{ #category : #'*VectorMaps' }
Point >> asVMPoint [
	^VMPoint x: x y: y.
]

{ #category : #'*VectorMaps' }
Point >> asVMVertex [
	^ VMGraphVertex point: self
]

{ #category : #'*VectorMaps' }
Point >> flipY [
	^x @ (y negated)
]
