Class {
	#name : #'Base_local_plannerPosition2DInt',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt class >> rosMd5Sum [ 
^'3b834ede922a0fff22c43585c533b49f'
]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt class >> rosTypeDefinition [ 
^' int64 x
 int64 y
'
]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt class >> rosTypeName [ 
^'base_local_planner/Position2DInt'
]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> initialize [
	super initialize.
	 self x: 0. 
	 self y: 0. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Base_local_plannerPosition2DInt >> y: aValue [
	^ self at: #y put: aValue. 

]
