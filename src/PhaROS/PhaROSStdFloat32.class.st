Class {
	#name : #PhaROSStdFloat32,
	#superclass : #PhaROSValue,
	#category : #'PhaROS-Types'
}

{ #category : #'as yet unclassified' }
PhaROSStdFloat32 >> data [
	^ self getAt: #data.
]

{ #category : #'as yet unclassified' }
PhaROSStdFloat32 >> data: aValue [ 
	^ self at: #data put: aValue  .
]
