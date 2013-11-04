Class {
	#name : #TKTTaskerHandler,
	#superclass : #TKTProxyHandler,
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTTaskerHandler >> spawn: aBlock [	
	^ aBlock taskIt.
]
