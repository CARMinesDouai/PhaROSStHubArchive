Class {
	#name : #'Geometry_msgsPointStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped class >> rosMd5Sum [ 
^'c63aecb41bfdfd6b7e1fac37c7cbe7bf'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Point point
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped class >> rosTypeName [ 
^'geometry_msgs/PointStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self point: Geometry_msgsPoint new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped >> point [
	^ self getAt: #point. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPointStamped >> point: aValue [
	^ self at: #point put: aValue. 

]
