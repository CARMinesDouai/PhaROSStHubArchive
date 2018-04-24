"
VMPoint is a Point that additionally has a type associated with it. It also has a 'bounds' method which is helpfull for visualization via the VMViewer class.
"
Class {
	#name : #VMPoint,
	#superclass : #Point,
	#instVars : [
		'type'
	],
	#category : #'VectorMaps-Data Structures: Points & Lines'
}

{ #category : #accessing }
VMPoint >> bounds [
	^VMRectangle point: self point: self.
]

{ #category : #accessing }
VMPoint >> type [
	^type
]

{ #category : #accessing }
VMPoint >> type: aVMPointType [
	type := aVMPointType
]
