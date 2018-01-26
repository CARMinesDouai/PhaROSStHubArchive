Class {
	#name : #'Yocs_msgsWall',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsWall class >> rosMd5Sum [ 
^'6fba3b6a148ebf1773d978f0b5f0bde8'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWall class >> rosTypeDefinition [ 
^' string name
 float32 length
 float32 width
 float32 height
 geometry_msgs/PoseWithCovarianceStamped pose
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWall class >> rosTypeName [ 
^'yocs_msgs/Wall'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWall class >> typeCreationOrder [ 
^456
]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> initialize [
	super initialize.
	 self name: ''. 
	 self length: 0.0. 
	 self width: 0.0. 
	 self height: 0.0. 
	 self pose: Geometry_msgsPoseWithCovarianceStamped new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> length [
	^ self getAt: #length. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> length: aValue [
	^ self at: #length put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWall >> width: aValue [
	^ self at: #width put: aValue. 

]
