Extension { #name : #Object }

{ #category : #'*Equals' }
Object >> valuesToCompareForEquality [
	^self class allInstVarNames collect: [:ivName|
		self instVarNamed: ivName]
]
