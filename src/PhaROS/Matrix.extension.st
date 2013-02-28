Extension { #name : #Matrix }

{ #category : #'*PhaROS' }
Matrix >> dotProduct: anOtherMatrix [
	|result|
	self assert: self columnCount = anOtherMatrix rowCount.
	
	result := 0 .
	1 to: self rowCount do: [ :i |
		1 to: anOtherMatrix columnCount do: [ :j |
			(self atRow: i ) with: (anOtherMatrix atColumn: j) do: [ :r :c | result := result + (r * c)].
		]
	].

	^ result. 
]

{ #category : #'*PhaROS' }
Matrix >> outerProduct: anOtherMatrix [

	self assert: self columnCount = anOtherMatrix columnCount.
	self assert: self rowCount = anOtherMatrix rowCount.
	self assert: self rowCount = 1. 
	
	^ Matrix rows: self columnCount  columns:  self columnCount  tabulate: [ :r :c |
			(self at: 1 at: r) * (anOtherMatrix at:1 at: c)
	].
]
