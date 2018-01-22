Class {
	#name : #'Control_msgsPointHeadGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal class >> rosTypeDefinition [ 
^' geometry_msgs/PointStamped target
 geometry_msgs/Vector3 pointing_axis
 string pointing_frame
 duration min_duration
 float64 max_velocity
'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal class >> rosTypeName [ 
^'control_msgs/PointHeadGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> initialize [
	super initialize.
	 self target: Geometry_msgsPointStamped new. 
	 self pointing_axis: Geometry_msgsVector3 new. 
	 self pointing_frame: ''. 
	 self min_duration:  Duration seconds: 0. 
	 self max_velocity: 0.0. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> max_velocity [
	^ self getAt: #max_velocity. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> max_velocity: aValue [
	^ self at: #max_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> min_duration [
	^ self getAt: #min_duration. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> min_duration: aValue [
	^ self at: #min_duration put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> pointing_axis [
	^ self getAt: #pointing_axis. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> pointing_axis: aValue [
	^ self at: #pointing_axis put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> pointing_frame [
	^ self getAt: #pointing_frame. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> pointing_frame: aValue [
	^ self at: #pointing_frame put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> target [
	^ self getAt: #target. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadGoal >> target: aValue [
	^ self at: #target put: aValue. 

]
