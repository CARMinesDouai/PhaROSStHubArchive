Class {
	#name : #'Shape_msgsPlane',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Shape_msgsPlane class >> rosMd5Sum [ 
^'2c1b92ed8f31492f8e73f6a4a44ca796'
]

{ #category : #'as yet unclassified' }
Shape_msgsPlane class >> rosTypeDefinition [ 
^' float64[4]  coef
'
]

{ #category : #'as yet unclassified' }
Shape_msgsPlane class >> rosTypeName [ 
^'shape_msgs/Plane'
]

{ #category : #'as yet unclassified' }
Shape_msgsPlane >> coef [
	^ self getAt: #coef. 

]

{ #category : #'as yet unclassified' }
Shape_msgsPlane >> coef: aValue [
	^ self at: #coef put: aValue. 

]

{ #category : #'as yet unclassified' }
Shape_msgsPlane >> initialize [
	super initialize.
	 self coef:  (OrderedCollection new: 4). 

]
