Class {
	#name : #'Geometry_msgsPoint32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 class >> rosTypeDefinition [ 
^' float32 x
 float32 y
 float32 z
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 class >> rosTypeName [ 
^'geometry_msgs/Point32'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self z: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 >> y: aValue [
	^ self at: #y put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 >> z [
	^ self getAt: #z. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint32 >> z: aValue [
	^ self at: #z put: aValue. 

]
