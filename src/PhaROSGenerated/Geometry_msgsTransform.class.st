Class {
	#name : #'Geometry_msgsTransform',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsTransform class >> rosTypeDefinition [ 
^' geometry_msgs/Vector3 translation
 geometry_msgs/Quaternion rotation
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform class >> rosTypeName [ 
^'geometry_msgs/Transform'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> initialize [
	super initialize.
	 self translation: Geometry_msgsVector3 new. 
	 self rotation: Geometry_msgsQuaternion new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> rotation [
	^ self getAt: #rotation. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> rotation: aValue [
	^ self at: #rotation put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> translation [
	^ self getAt: #translation. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> translation: aValue [
	^ self at: #translation put: aValue. 

]
