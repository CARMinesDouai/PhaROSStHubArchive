Class {
	#name : #VMGraphPointRenderer,
	#superclass : #VMPointRenderer,
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #accessing }
VMGraphPointRenderer >> centerPoint [
	^ self model point
	
]

{ #category : #accessing }
VMGraphPointRenderer >> label [
	^ self model id asString
]
