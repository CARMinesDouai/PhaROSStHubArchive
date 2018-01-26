Class {
	#name : #'Stdr_msgsSonarSensorMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg class >> rosMd5Sum [ 
^'e8b8bd75b2e357572ea0c9ee72ed58c1'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg class >> rosTypeDefinition [ 
^' float32 maxRange
 float32 minRange
 float32 coneAngle
 float32 frequency
 stdr_msgs/Noise noise
 string frame_id
 geometry_msgs/Pose2D pose
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg class >> rosTypeName [ 
^'stdr_msgs/SonarSensorMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg class >> typeCreationOrder [ 
^337
]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> coneAngle [
	^ self getAt: #coneAngle. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> coneAngle: aValue [
	^ self at: #coneAngle put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> frequency [
	^ self getAt: #frequency. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> frequency: aValue [
	^ self at: #frequency put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> initialize [
	super initialize.
	 self maxRange: 0.0. 
	 self minRange: 0.0. 
	 self coneAngle: 0.0. 
	 self frequency: 0.0. 
	 self noise: Stdr_msgsNoise new. 
	 self frame_id: ''. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> maxRange [
	^ self getAt: #maxRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> maxRange: aValue [
	^ self at: #maxRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> minRange [
	^ self getAt: #minRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> minRange: aValue [
	^ self at: #minRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> noise [
	^ self getAt: #noise. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> noise: aValue [
	^ self at: #noise put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSonarSensorMsg >> pose: aValue [
	^ self at: #pose put: aValue. 

]
