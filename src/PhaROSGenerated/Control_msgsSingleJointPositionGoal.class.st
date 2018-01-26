Class {
	#name : #'Control_msgsSingleJointPositionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal class >> rosMd5Sum [ 
^'fbaaa562a23a013fd5053e5f72cbb35c'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal class >> rosTypeDefinition [ 
^' float64 position
 duration min_duration
 float64 max_velocity
'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal class >> rosTypeName [ 
^'control_msgs/SingleJointPositionGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal class >> typeCreationOrder [ 
^90
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal >> initialize [
	super initialize.
	 self position: 0.0. 
	 self min_duration:  Duration seconds: 0. 
	 self max_velocity: 0.0. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal >> max_velocity [
	^ self getAt: #max_velocity. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal >> max_velocity: aValue [
	^ self at: #max_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal >> min_duration [
	^ self getAt: #min_duration. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal >> min_duration: aValue [
	^ self at: #min_duration put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionGoal >> position: aValue [
	^ self at: #position put: aValue. 

]
