Class {
	#name : #VMRectangle,
	#superclass : #Rectangle,
	#category : #'VectorMaps-kernel'
}

{ #category : #accessing }
VMRectangle >> center [
	"unlike in the original Rectangle, this method computes the center as floats, not integers"
	^self topLeft + self bottomRight / 2
]
