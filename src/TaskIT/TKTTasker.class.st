Class {
	#name : #TKTTasker,
	#superclass : #TKTProxy,
	#category : #'TaskIT-Worker'
}

{ #category : #'as yet unclassified' }
TKTTasker >> scheddule [
	^ self.
]

{ #category : #'as yet unclassified' }
TKTTasker >> spawn: aBlock [
	^ aBlock taskIt.
]