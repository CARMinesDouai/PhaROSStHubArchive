Class {
	#name : #'Stdr_msgsLaserSensorMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg class >> rosTypeDefinition [ 
^' float32 maxAngle
 float32 minAngle
 float32 maxRange
 float32 minRange
 int32 numRays
 stdr_msgs/Noise noise
 float32 frequency
 string frame_id
 geometry_msgs/Pose2D pose
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg class >> rosTypeName [ 
^'stdr_msgs/LaserSensorMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> frequency [
	^ self getAt: #frequency. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> frequency: aValue [
	^ self at: #frequency put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> initialize [
	super initialize.
	 self maxAngle: 0.0. 
	 self minAngle: 0.0. 
	 self maxRange: 0.0. 
	 self minRange: 0.0. 
	 self numRays: 0. 
	 self noise: Stdr_msgsNoise new. 
	 self frequency: 0.0. 
	 self frame_id: ''. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> maxAngle [
	^ self getAt: #maxAngle. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> maxAngle: aValue [
	^ self at: #maxAngle put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> maxRange [
	^ self getAt: #maxRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> maxRange: aValue [
	^ self at: #maxRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> minAngle [
	^ self getAt: #minAngle. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> minAngle: aValue [
	^ self at: #minAngle put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> minRange [
	^ self getAt: #minRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> minRange: aValue [
	^ self at: #minRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> noise [
	^ self getAt: #noise. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> noise: aValue [
	^ self at: #noise put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> numRays [
	^ self getAt: #numRays. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> numRays: aValue [
	^ self at: #numRays put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsLaserSensorMsg >> pose: aValue [
	^ self at: #pose put: aValue. 

]
