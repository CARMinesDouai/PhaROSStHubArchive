Class {
	#name : #'Pcl_msgsVertices',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Pcl_msgsVertices >> initialize [
	super initialize.
	 self vertices: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Pcl_msgsVertices >> vertices [
	^ self getAt: #vertices. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsVertices >> vertices: aValue [
	^ self at: #vertices put: aValue. 

]
