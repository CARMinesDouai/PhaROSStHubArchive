Class {
	#name : #'Yocs_msgsTable',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsTable class >> rosTypeDefinition [ 
^' string name
 float32 radius
 float32 height
 geometry_msgs/PoseWithCovarianceStamped pose
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTable class >> rosTypeName [ 
^'yocs_msgs/Table'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> initialize [
	super initialize.
	 self name: ''. 
	 self radius: 0.0. 
	 self height: 0.0. 
	 self pose: Geometry_msgsPoseWithCovarianceStamped new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTable >> radius: aValue [
	^ self at: #radius put: aValue. 

]
