Class {
	#name : #'Geometry_msgsPolygon',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon >> initialize [
	super initialize.
	 self points: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon >> points: aValue [
	^ self at: #points put: aValue. 

]
