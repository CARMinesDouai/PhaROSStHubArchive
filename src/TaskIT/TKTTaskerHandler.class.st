Class {
	#name : #TKTTaskerHandler,
	#superclass : #TKTSpawnerProxyHandler,
	#category : #'TaskIT-Util'
}

{ #category : #running }
TKTTaskerHandler >> spawn: aBlock [	
	^ aBlock scheduleIt.
]
