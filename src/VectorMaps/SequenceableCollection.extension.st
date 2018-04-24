Extension { #name : #SequenceableCollection }

{ #category : #'*VectorMaps' }
SequenceableCollection >> asRenderableElement [
	^(VMCollectionRenderer model: self)
]

{ #category : #'*VectorMaps' }
SequenceableCollection >> asVMLineSegCollection [
	"assumes that the OrderedCollection contains VMLine (or derived) instances."
	^(VMLineSegCollection new)
		addAll: self;
		yourself
]

{ #category : #'*VectorMaps' }
SequenceableCollection >> asVMPolygon [
	"assumes that the OrderedCollection contains line segments that form a valid polygon"
	^(VMPolygon new)
		addAll: self;
		yourself.
]

{ #category : #'*VectorMaps' }
SequenceableCollection >> asVMPolygonCollection [
	"assumes that the OrderedCollection contains VMPolygon instances"
	^(VMPolygonCollection new)
		addAll: self;
		yourself.
]

{ #category : #'*VectorMaps' }
SequenceableCollection >> with: aSeqCollection collect: aBlock [
	"same as a normal #collect, but with to sequenceable collections of the same size.
	aBlock receives two parameters (the element from this collection and the element
	from aSeqCollection)."
	| result |
	
	self assert: self size = aSeqCollection size.
	result := self species new: self size.
	1 to: self size do: [ :index |
		result at: index put: (aBlock value: (self at: index) value: (aSeqCollection at: index))
	].
	
	^result
	

]
