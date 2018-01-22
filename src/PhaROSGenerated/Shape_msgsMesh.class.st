Class {
	#name : #'Shape_msgsMesh',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> initialize [
	super initialize.
	 self triangles: OrderedCollection new . 
	 self vertices: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> triangles [
	^ self getAt: #triangles. 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> triangles: aValue [
	^ self at: #triangles put: aValue. 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> vertices [
	^ self getAt: #vertices. 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> vertices: aValue [
	^ self at: #vertices put: aValue. 

]
