Class {
	#name : #'Yocs_msgsWallList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsWallList class >> rosMd5Sum [ 
^'2879979aabb372fc7f6d782228e53412'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList class >> rosTypeDefinition [ 
^' yocs_msgs/Wall[] obstacles
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList class >> rosTypeName [ 
^'yocs_msgs/WallList'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList class >> typeCreationOrder [ 
^457
]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList >> initialize [
	super initialize.
	 self obstacles: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList >> obstacles [
	^ self getAt: #obstacles. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList >> obstacles: aValue [
	^ self at: #obstacles put: aValue. 

]
