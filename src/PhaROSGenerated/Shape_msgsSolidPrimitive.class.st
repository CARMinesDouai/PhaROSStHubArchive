Class {
	#name : #'Shape_msgsSolidPrimitive',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> box [
	^1

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> box_x [
	^0

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> box_y [
	^1

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> box_z [
	^2

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> cone [
	^4

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> cone_height [
	^0

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> cone_radius [
	^1

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> cylinder [
	^3

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> cylinder_height [
	^0

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> cylinder_radius [
	^1

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> rosMd5Sum [ 
^'d8f8cbc74c5ff283fca29569ccefb45d'
]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> rosTypeDefinition [ 
^' int8 BOX=1
 int8 SPHERE=2
 int8 CYLINDER=3
 int8 CONE=4
 int8 BOX_X=0
 int8 BOX_Y=1
 int8 BOX_Z=2
 int8 SPHERE_RADIUS=0
 int8 CYLINDER_HEIGHT=0
 int8 CYLINDER_RADIUS=1
 int8 CONE_HEIGHT=0
 int8 CONE_RADIUS=1
 int8 type
 float64[] dimensions
'
]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> rosTypeName [ 
^'shape_msgs/SolidPrimitive'
]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> sphere [
	^2

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive class >> sphere_radius [
	^0

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive >> dimensions [
	^ self getAt: #dimensions. 

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive >> dimensions: aValue [
	^ self at: #dimensions put: aValue. 

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive >> initialize [
	super initialize.
	 self type: 0. 
	 self dimensions: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Shape_msgsSolidPrimitive >> type: aValue [
	^ self at: #type put: aValue. 

]
