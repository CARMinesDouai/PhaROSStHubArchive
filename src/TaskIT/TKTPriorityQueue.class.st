Class {
	#name : #TKTPriorityQueue,
	#superclass : #TKTQueue,
	#category : #'TaskIT-Channel'
}

{ #category : #'as yet unclassified' }
TKTPriorityQueue >> initialize [ 
	super initialize.
	queue := TKTExclusiveAccessVariable initialValue: (SortedCollection sortBlock: [ :w1 :w2 | w1 > w2 ]).
	
]
