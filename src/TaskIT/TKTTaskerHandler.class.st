Class {
	#name : #TKTTaskerHandler,
	#superclass : #TKTProxyHandler,
	#category : #'TaskIT-Util'
}

{ #category : #running }
TKTTaskerHandler >> spawn: aBlock [	
	^ aBlock scheduleIt.
]
