Class {
	#name : #'Stdr_msgsSoundSensorMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg class >> rosTypeDefinition [ 
^' float32 maxRange
 float32 frequency
 float32 angleSpan
 string frame_id
 geometry_msgs/Pose2D pose
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg class >> rosTypeName [ 
^'stdr_msgs/SoundSensorMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> angleSpan [
	^ self getAt: #angleSpan. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> angleSpan: aValue [
	^ self at: #angleSpan put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> frequency [
	^ self getAt: #frequency. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> frequency: aValue [
	^ self at: #frequency put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> initialize [
	super initialize.
	 self maxRange: 0.0. 
	 self frequency: 0.0. 
	 self angleSpan: 0.0. 
	 self frame_id: ''. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> maxRange [
	^ self getAt: #maxRange. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> maxRange: aValue [
	^ self at: #maxRange put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMsg >> pose: aValue [
	^ self at: #pose put: aValue. 

]
