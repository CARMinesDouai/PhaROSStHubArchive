Class {
	#name : #'Stdr_msgsCO2SensorMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg class >> rosMd5Sum [ 
^'a2ce066e5e102e00628fbb7d1ee5e32b'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg class >> rosTypeDefinition [ 
^' float32 maxRange
 float32 frequency
 string frame_id
 geometry_msgs/Pose2D pose
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg class >> rosTypeName [ 
^'stdr_msgs/CO2SensorMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> frequency [
	^ self getAt: #frequency. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> frequency: aValue [
	^ self at: #frequency put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> initialize [
	super initialize.
	 self maxRange: 0.0. 
	 self frequency: 0.0. 
	 self frame_id: ''. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> maxRange [
	^ self getAt: #maxRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> maxRange: aValue [
	^ self at: #maxRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMsg >> pose: aValue [
	^ self at: #pose put: aValue. 

]
