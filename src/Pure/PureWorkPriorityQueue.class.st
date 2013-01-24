Class {
	#name : #PureWorkPriorityQueue,
	#superclass : #PureWorkQueue,
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureWorkPriorityQueue >> initialize [ 
	super initialize.
	queue := SortedCollection sortBlock: [ :w1 :w2 | w1 < w2 ].
	
]
