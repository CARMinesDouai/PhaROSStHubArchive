Class {
	#name : #'Geometry_msgsInertia',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsInertia class >> rosMd5Sum [ 
^'1d26e4bb6c83ff141c5cf0d883c2b0fe'
]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia class >> rosTypeDefinition [ 
^' float64 m
 geometry_msgs/Vector3 com
 float64 ixx
 float64 ixy
 float64 ixz
 float64 iyy
 float64 iyz
 float64 izz
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia class >> rosTypeName [ 
^'geometry_msgs/Inertia'
]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia class >> typeCreationOrder [ 
^141
]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> com [
	^ self getAt: #com. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> com: aValue [
	^ self at: #com put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> initialize [
	super initialize.
	 self m: 0.0. 
	 self com: Geometry_msgsVector3 new. 
	 self ixx: 0.0. 
	 self ixy: 0.0. 
	 self ixz: 0.0. 
	 self iyy: 0.0. 
	 self iyz: 0.0. 
	 self izz: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> ixx [
	^ self getAt: #ixx. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> ixx: aValue [
	^ self at: #ixx put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> ixy [
	^ self getAt: #ixy. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> ixy: aValue [
	^ self at: #ixy put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> ixz [
	^ self getAt: #ixz. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> ixz: aValue [
	^ self at: #ixz put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> iyy [
	^ self getAt: #iyy. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> iyy: aValue [
	^ self at: #iyy put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> iyz [
	^ self getAt: #iyz. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> iyz: aValue [
	^ self at: #iyz put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> izz [
	^ self getAt: #izz. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> izz: aValue [
	^ self at: #izz put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> m [
	^ self getAt: #m. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertia >> m: aValue [
	^ self at: #m put: aValue. 

]
