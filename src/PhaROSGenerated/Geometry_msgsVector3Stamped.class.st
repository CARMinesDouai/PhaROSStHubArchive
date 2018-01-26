Class {
	#name : #'Geometry_msgsVector3Stamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped class >> rosMd5Sum [ 
^'7b324c7325e683bf02a9b14b01090ec7'
]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Vector3 vector
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped class >> rosTypeName [ 
^'geometry_msgs/Vector3Stamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped class >> typeCreationOrder [ 
^155
]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self vector: Geometry_msgsVector3 new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> vector [
	^ self getAt: #vector. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> vector: aValue [
	^ self at: #vector put: aValue. 

]
