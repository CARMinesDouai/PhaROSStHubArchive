Class {
	#name : #'Geometry_msgsWrench',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsWrench class >> rosMd5Sum [ 
^'4f539cf138b23283b520fd271b567936'
]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench class >> rosTypeDefinition [ 
^' geometry_msgs/Vector3 force
 geometry_msgs/Vector3 torque
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench class >> rosTypeName [ 
^'geometry_msgs/Wrench'
]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> force [
	^ self getAt: #force. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> force: aValue [
	^ self at: #force put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> initialize [
	super initialize.
	 self force: Geometry_msgsVector3 new. 
	 self torque: Geometry_msgsVector3 new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> torque [
	^ self getAt: #torque. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> torque: aValue [
	^ self at: #torque put: aValue. 

]
