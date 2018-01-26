Class {
	#name : #'Geometry_msgsPoint',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoint class >> rosMd5Sum [ 
^'4a842b65f413084dc2b10fb484ea7f17'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint class >> rosTypeDefinition [ 
^' float64 x
 float64 y
 float64 z
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint class >> rosTypeName [ 
^'geometry_msgs/Point'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint class >> typeCreationOrder [ 
^39
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self z: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> y: aValue [
	^ self at: #y put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> z [
	^ self getAt: #z. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> z: aValue [
	^ self at: #z put: aValue. 

]
