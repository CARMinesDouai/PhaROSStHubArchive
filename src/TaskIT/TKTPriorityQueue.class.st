Class {
	#name : #TKTPriorityQueue,
	#superclass : #TKTQueue,
	#category : #'TaskIT-Channel'
}

{ #category : #'as yet unclassified' }
TKTPriorityQueue >> initialize [ 
	super initialize.
	queue := TKTVariable for: (SortedCollection sortBlock: [ :w1 :w2 | w1 > w2 ]).
	
]
