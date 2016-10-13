Class {
	#name : #VMSVDTests,
	#superclass : #VMTests,
	#category : #'VectorMaps-Tests'
}

{ #category : #'as yet unclassified' }
VMSVDTests >> matrix: matrixA isSimilarTo: matrixB [
	"returns true if the values of each cell are the same (+/- epsilon) between the two provided matrices"
	| error epsilon returnValue |
	
	returnValue := true.
	epsilon := 0.0001.
	
	1 to: 2 do: [ :r |
		1 to: 2 do: [ :c |
			error := (matrixA at: r at: c) - (matrixB at: r at: c).
			(error abs > epsilon) ifTrue: [
				returnValue := false.
			].
		].
	].
	
	^returnValue.

]

{ #category : #'as yet unclassified' }
VMSVDTests >> testMatrix [
	"computes the SVD for the matrix (1 2) / (0 1) and compares the results with pre-computed values"
	| m svd  epsilon u s v |
	
	epsilon := 0.000001.
	m := DhbMatrix rows: { {1. 2}. {0. 1} }.
	u := DhbMatrix rows: { {0.923879532. 0.382683432}. {-0.3826834324. 0.923879533} }.
	s := DhbMatrix rows: { {2.41421356. 0}. {0. 0.414213562} }.
	v := DhbMatrix rows: { {0.382683432. 0.923879533}. {-0.923879533. 0.3826834324} }.
	
	svd := VMSVD matrix: m.
	
	Transcript
		show: 'u='; cr;
		show: svd u; cr;
		show: 's='; cr;
		show: svd s; cr;
		show: 'v='; cr;
		show: svd v; cr.
	
	self assert: ( self matrix: svd u isSimilarTo: u ).
	self assert: ( self matrix: svd s isSimilarTo: s ).
	self assert: ( self matrix: svd v isSimilarTo: v ).

]

{ #category : #'as yet unclassified' }
VMSVDTests >> testUV [
	"the matrices U and V of the SVD must satisify u*u^T = identity and v^T*v = identity. this test checks for these
	properties for a few symetric metrices. (symetric metrices are guaranteed to have real eigen values, which is
	required by our Eigen2d implementation)"
	| m mData svd  epsilon id |
	
	epsilon := 0.000001.
	
	mData := {
		{ {5. 2}.  {2. 1} }.
		{ {1. 0}.  {0. 1} }.
		{ {1024. 64}.  {64. 512} }.
	}.
	
	mData do: [ :data |
		m := DhbMatrix rows: data.
		id := DhbMatrix rows: { {1. 0}.  {0. 1} }.
		
		svd := VMSVD matrix: m.
		
		self assert: (
			self matrix: ((svd u transpose) * svd u) isSimilarTo: id 
		).
		
		self assert: (
			self matrix: ((svd v transpose) * svd v) isSimilarTo: id 
		).
	].

]
