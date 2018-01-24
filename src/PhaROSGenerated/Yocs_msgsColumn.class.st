Class {
	#name : #'Yocs_msgsColumn',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsColumn class >> rosMd5Sum [ 
^'8e1bb2c627c92d4c6f6075fe37858727'
]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn class >> rosTypeDefinition [ 
^' string name
 float32 radius
 float32 height
 geometry_msgs/PoseWithCovarianceStamped pose
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn class >> rosTypeName [ 
^'yocs_msgs/Column'
]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> initialize [
	super initialize.
	 self name: ''. 
	 self radius: 0.0. 
	 self height: 0.0. 
	 self pose: Geometry_msgsPoseWithCovarianceStamped new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> radius: aValue [
	^ self at: #radius put: aValue. 

]
