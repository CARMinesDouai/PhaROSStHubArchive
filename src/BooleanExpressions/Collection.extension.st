Extension { #name : #Collection }

{ #category : #'*BooleanExpressions' }
Collection >> allFalse [
	^self noneSatisfy: [ :each| each value ]
]

{ #category : #'*BooleanExpressions' }
Collection >> allTrue [
	^self allSatisfy: [ :each| each value ]
]

{ #category : #'*BooleanExpressions' }
Collection >> anyFalse [
	^self anySatisfy: [ :each| each value not ]
]

{ #category : #'*BooleanExpressions' }
Collection >> anyTrue [
	^self anySatisfy: [ :each| each value ]
]
