Class {
	#name : #'Geometry_msgsQuaternionStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped class >> rosMd5Sum [ 
^'e57f1e547e0e1fd13504588ffc8334e2'
]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Quaternion quaternion
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped class >> rosTypeName [ 
^'geometry_msgs/QuaternionStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self quaternion: Geometry_msgsQuaternion new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> quaternion [
	^ self getAt: #quaternion. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> quaternion: aValue [
	^ self at: #quaternion put: aValue. 

]
