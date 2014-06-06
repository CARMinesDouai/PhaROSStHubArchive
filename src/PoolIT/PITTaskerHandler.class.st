Class {
	#name : #PITTaskerHandler,
	#superclass : #TKTSpawnerProxyHandler,
	#category : #'PoolIT-Sugar'
}

{ #category : #running }
PITTaskerHandler >> spawn: aBlock [	
	^ aBlock scheduleIt.
]
