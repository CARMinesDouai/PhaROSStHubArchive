Class {
	#name : #'Stdr_msgsCO2Source',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source class >> rosMd5Sum [ 
^'5d5cdddff090254ed6052018cd9b2686'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source class >> rosTypeDefinition [ 
^' string id
 float32 ppm
 geometry_msgs/Pose2D pose
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source class >> rosTypeName [ 
^'stdr_msgs/CO2Source'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source class >> typeCreationOrder [ 
^322
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> initialize [
	super initialize.
	 self id: ''. 
	 self ppm: 0.0. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> ppm [
	^ self getAt: #ppm. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2Source >> ppm: aValue [
	^ self at: #ppm put: aValue. 

]
